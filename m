From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 17:39:29 +0000
Subject: PXA270 overlay problem
In-Reply-To: <201101311908.49275.anarsoul@gmail.com>
References: <201101262246.01164.anarsoul@gmail.com>
	<20110131130414.GE8948@n2100.arm.linux.org.uk>
	<201101311908.49275.anarsoul@gmail.com>
Message-ID: <20110131173929.GC32737@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 07:08:48PM +0200, Vasily Khoruzhick wrote:
> On Monday 31 January 2011 15:04:14 Russell King - ARM Linux wrote:
> > On Wed, Jan 26, 2011 at 10:46:00PM +0200, Vasily Khoruzhick wrote:
> > > Hi, I'm experiencing problems with overlay1/overlay2 on PXA270 using
> > > pxafb driver. Main problem is overlays just don't work for some reason,
> > > and even more - after enabling any overlay something weird happens (LCD
> > > blinks for a 0.5 second, and then main plane comes back, no overlay
> > > plane is visible), I'm getting following messages on dmesg:
> > > 
> > > [   93.679574] overlay1fb_disable: timeout disabling overlay1
> > > [   95.601537] BUG: Bad page state in process sh  pfn:a1b60
> > > [   95.601645] page:c0456c00 count:0 mapcount:0 mapping:  (null)
> > > index:0x0 [   95.601698] page flags: 0x200(arch_1)
> > 
> > Ouch.  PG_arch_1 is our 'dcache clean' bit, which we set to indicate
> > that the page is clean.  This should never be set on a newly allocated
> > page.
> > 
> > It's cleared by generic code whenever a page enters the free lists, so
> > newly allocated pages should never have the bit set.
> > 
> > What your report means is that someone did DMA cache maintainence
> > (specifically, unmapping the page), copied the page as a result of
> > a COW fault, or called flush_dcache_page() on an already free'd page.
> > 
> > Maybe the pages were mapped into userspace, meanwhile someone free'd
> > the pages.
> > 
> > And yes, I can see one way that this could happen:
> > 
> > - open overlay
> > - map buffer
> > - set framebuffer parameters
> >    (free's mapped buffer, leaving the mapped one in place, creates new
> > buffer) - close overlay
> 
> But I map framebuffer only after FBIOPUT_VSCREENINFO ioctl.
> 
> > Maybe another way:
> > 
> > static int overlayfb_release(struct fb_info *info, int user)
> > {
> >         struct pxafb_layer *ofb = (struct pxafb_layer*) info;
> > 
> >         atomic_dec(&ofb->usage);
> >         ofb->ops->disable(ofb);
> > 
> >         free_pages_exact(ofb->video_mem, ofb->video_mem_size);
> > 
> > So if two users open the overlay, both map it, and then one closes, the
> > memory backing the overlay gets freed - meanwhile the other user still
> > has it mapped etc.
> 
> Again, there's only one user - my app.

I didn't look any deeper so I can't say - but it feels very much like this
kind of thing is responsible for your problem.

Things actually get worse if I look at the driver:

static int overlayfb_open(struct fb_info *info, int user)
{
        /* allow only one user at a time */
        if (atomic_inc_and_test(&ofb->usage))
                return -EBUSY;

This is rubbish.  atomic_inc_and_test(v) does:

	val = *v;
	val += 1;
	*v = val;

	return val == 0;

So this doesn't stop multiple opens (and arguably you _can't_ prevent
multiple opens anyway.)

Anyway, I think it would be worth fixing this, and seeing what the effect
is.  Note that one of the side effects of one of this changes is that you
only get one attempt at increasing the memory size in FBIOPUT_VSCREENINFO.
Once the buffer has been allocated, we never change it - as there is no
way of knowing whether it's mapped or not.

The other change is that we properly remove all references to the
allocated memory when closing the device - which ensures that an open()
followed by mmap() with no FBIOPUT_VSCREENINFO call will always fail.

Lastly, it does allow concurrent opens, but makes sure that we have the
necessary number of closes before freeing the buffer.

Please give this a try and see whether it makes any difference for you.

 drivers/video/pxafb.c |   29 +++++++++++++++++------------
 drivers/video/pxafb.h |    2 +-
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 825b665..f73227f 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -720,12 +720,10 @@ static int overlayfb_open(struct fb_info *info, int user)
 	if (user == 0)
 		return -ENODEV;
 
-	/* allow only one user at a time */
-	if (atomic_inc_and_test(&ofb->usage))
-		return -EBUSY;
+	if (ofb->usage++ == 0)
+		/* unblank the base framebuffer */
+		fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
 
-	/* unblank the base framebuffer */
-	fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
 	return 0;
 }
 
@@ -733,12 +731,18 @@ static int overlayfb_release(struct fb_info *info, int user)
 {
 	struct pxafb_layer *ofb = (struct pxafb_layer*) info;
 
-	atomic_dec(&ofb->usage);
-	ofb->ops->disable(ofb);
+	if (--ofb->usage == 0) {
+		ofb->ops->disable(ofb);
 
-	free_pages_exact(ofb->video_mem, ofb->video_mem_size);
-	ofb->video_mem = NULL;
-	ofb->video_mem_size = 0;
+		mutex_lock(&ofb->fb.mm_lock);
+		ofb->fb.fix.smem_start	= 0;
+		ofb->fb.fix.smem_len	= 0;
+		mutex_unlock(&ofb->fb.mm_lock);
+
+		free_pages_exact(ofb->video_mem, ofb->video_mem_size);
+		ofb->video_mem = NULL;
+		ofb->video_mem_size = 0;
+	}
 	return 0;
 }
 
@@ -817,7 +821,8 @@ static int overlayfb_map_video_memory(struct pxafb_layer *ofb)
 		if (ofb->video_mem_size >= size)
 			return 0;
 
-		free_pages_exact(ofb->video_mem, ofb->video_mem_size);
+		/* don't re-allocate: userspace may have the buffer mapped */
+		return -EINVAL;
 	}
 
 	ofb->video_mem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
@@ -891,7 +896,7 @@ static void __devinit init_pxafb_overlay(struct pxafb_info *fbi,
 
 	ofb->id = id;
 	ofb->ops = &ofb_ops[id];
-	atomic_set(&ofb->usage, 0);
+	ofb->usage = 0;
 	ofb->fbi = fbi;
 	init_completion(&ofb->branch_done);
 }
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index 2353521..84e3ae1 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -92,7 +92,7 @@ struct pxafb_layer_ops {
 struct pxafb_layer {
 	struct fb_info		fb;
 	int			id;
-	atomic_t		usage;
+	uint32_t		usage;
 	uint32_t		control[2];
 
 	struct pxafb_layer_ops	*ops;
