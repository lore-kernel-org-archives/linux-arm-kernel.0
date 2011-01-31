From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 31 Jan 2011 19:08:48 +0200
Subject: PXA270 overlay problem
In-Reply-To: <20110131130414.GE8948@n2100.arm.linux.org.uk>
References: <201101262246.01164.anarsoul@gmail.com>
	<20110131130414.GE8948@n2100.arm.linux.org.uk>
Message-ID: <201101311908.49275.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 January 2011 15:04:14 Russell King - ARM Linux wrote:
> On Wed, Jan 26, 2011 at 10:46:00PM +0200, Vasily Khoruzhick wrote:
> > Hi, I'm experiencing problems with overlay1/overlay2 on PXA270 using
> > pxafb driver. Main problem is overlays just don't work for some reason,
> > and even more - after enabling any overlay something weird happens (LCD
> > blinks for a 0.5 second, and then main plane comes back, no overlay
> > plane is visible), I'm getting following messages on dmesg:
> > 
> > [   93.679574] overlay1fb_disable: timeout disabling overlay1
> > [   95.601537] BUG: Bad page state in process sh  pfn:a1b60
> > [   95.601645] page:c0456c00 count:0 mapcount:0 mapping:  (null)
> > index:0x0 [   95.601698] page flags: 0x200(arch_1)
> 
> Ouch.  PG_arch_1 is our 'dcache clean' bit, which we set to indicate
> that the page is clean.  This should never be set on a newly allocated
> page.
> 
> It's cleared by generic code whenever a page enters the free lists, so
> newly allocated pages should never have the bit set.
> 
> What your report means is that someone did DMA cache maintainence
> (specifically, unmapping the page), copied the page as a result of
> a COW fault, or called flush_dcache_page() on an already free'd page.
> 
> Maybe the pages were mapped into userspace, meanwhile someone free'd
> the pages.
> 
> And yes, I can see one way that this could happen:
> 
> - open overlay
> - map buffer
> - set framebuffer parameters
>    (free's mapped buffer, leaving the mapped one in place, creates new
> buffer) - close overlay

But I map framebuffer only after FBIOPUT_VSCREENINFO ioctl.

> Maybe another way:
> 
> static int overlayfb_release(struct fb_info *info, int user)
> {
>         struct pxafb_layer *ofb = (struct pxafb_layer*) info;
> 
>         atomic_dec(&ofb->usage);
>         ofb->ops->disable(ofb);
> 
>         free_pages_exact(ofb->video_mem, ofb->video_mem_size);
> 
> So if two users open the overlay, both map it, and then one closes, the
> memory backing the overlay gets freed - meanwhile the other user still
> has it mapped etc.

Again, there's only one user - my app.

> The alloc/free stuff in there just looks really dangerous to me.

Yep, it looks dangerous.

Regards
Vasily
