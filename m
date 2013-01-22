From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 18:13:57 +0000
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <20130121210150.GA9184@kroah.com>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <201301211855.25455.arnd@arndb.de> <20130121210150.GA9184@kroah.com>
Message-ID: <201301221813.57741.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Greg KH wrote:
> > 
> > I don't know a lot about USB, but I always assumed that this was not
> > a normal condition and that there are only a couple of URBs per endpoint
> > used at a time. Maybe Greg or someone else with a USB background can
> > shed some light on this.
> 
> There's no restriction on how many URBs a driver can have outstanding at
> once, and if you have a system with a lot of USB devices running at the
> same time, there could be lots of URBs in flight depending on the number
> of host controllers and devices and drivers being used.

Ok, thanks for clarifying that. I read some more of the em28xx driver,
and while it does have a bunch of URBs in flight, there are only five
audio and five video URBs that I see simultaneously being submitted,
and then resubmitted from their completion handlers. I think this
means that there should be 10 URBs active at any given time in this
driver, which does not explain why we get 256 allocations.

I also noticed that the initial submissions are all atomic but don't
need to, so it may be worth trying the patch below, which should also
help in low-memory situations. We could also try moving the resubmission
into a workqueue in order to let those be GFP_KERNEL, but I don't think
that will help.

	Arnd

diff --git a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
index 2fdb66e..8b789f4 100644
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -177,12 +177,12 @@ static int em28xx_init_audio_isoc(struct em28xx *dev)
 		struct urb *urb;
 		int j, k;
 
-		dev->adev.transfer_buffer[i] = kmalloc(sb_size, GFP_ATOMIC);
+		dev->adev.transfer_buffer[i] = kmalloc(sb_size, GFP_KERNEL);
 		if (!dev->adev.transfer_buffer[i])
 			return -ENOMEM;
 
 		memset(dev->adev.transfer_buffer[i], 0x80, sb_size);
-		urb = usb_alloc_urb(EM28XX_NUM_AUDIO_PACKETS, GFP_ATOMIC);
+		urb = usb_alloc_urb(EM28XX_NUM_AUDIO_PACKETS, GFP_KERNEL);
 		if (!urb) {
 			em28xx_errdev("usb_alloc_urb failed!\n");
 			for (j = 0; j < i; j++) {
@@ -212,7 +212,7 @@ static int em28xx_init_audio_isoc(struct em28xx *dev)
 	}
 
 	for (i = 0; i < EM28XX_AUDIO_BUFS; i++) {
-		errCode = usb_submit_urb(dev->adev.urb[i], GFP_ATOMIC);
+		errCode = usb_submit_urb(dev->adev.urb[i], GFP_KERNEL);
 		if (errCode) {
 			em28xx_errdev("submit of audio urb failed\n");
 			em28xx_deinit_isoc_audio(dev);
diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index bed07a6..c5a2c4b 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -1166,7 +1166,7 @@ int em28xx_init_isoc(struct em28xx *dev, enum em28xx_mode mode,
 
 	/* submit urbs and enables IRQ */
 	for (i = 0; i < isoc_bufs->num_bufs; i++) {
-		rc = usb_submit_urb(isoc_bufs->urb[i], GFP_ATOMIC);
+		rc = usb_submit_urb(isoc_bufs->urb[i], GFP_KERNEL);
 		if (rc) {
 			em28xx_err("submit of urb %i failed (error=%i)\n", i,
 				   rc);
