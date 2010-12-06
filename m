From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 06 Dec 2010 11:14:52 +0100
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <20101206083306.GI10693@pengutronix.de>
References: <20101011152516.GF27153@n2100.arm.linux.org.uk>
	<1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101123101210.GA18170@n2100.arm.linux.org.uk>
	<20101123102632.GM4693@pengutronix.de>
	<1290521329.3901.14.camel@realization>
	<20101123141713.GQ4693@pengutronix.de>
	<20101124080214.GU4693@pengutronix.de>
	<20101206083306.GI10693@pengutronix.de>
Message-ID: <1291630492.3151.14.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, 2010-12-06 at 09:33 +0100, Uwe Kleine-K?nig wrote:
> Hello Alberto,
> 
> On Wed, Nov 24, 2010 at 09:02:14AM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Nov 23, 2010 at 03:17:13PM +0100, Uwe Kleine-K?nig wrote:
> > > On Tue, Nov 23, 2010 at 03:08:49PM +0100, Alberto Panizzo wrote:
> > > > Hi Uwe,
> > > > On mar, 2010-11-23 at 11:26 +0100, Uwe Kleine-K?nig wrote:
> > > > > Hello Russell,
> > > > > 
> > > > > On Tue, Nov 23, 2010 at 10:12:11AM +0000, Russell King - ARM Linux wrote:
> > > > > > On Tue, Nov 23, 2010 at 10:43:02AM +0100, Uwe Kleine-K?nig wrote:
> > > > > > > There is no need to memzero the buffer because dma_alloc_coherent zeros
> > > > > > > the memory for us.
> > > > > > > 
> > > > > > > This fixes:
> > > > > > > 
> > > > > > > 	BUG: Your driver calls ioremap() on system memory.  This leads
> > > > > > > 	<4>to architecturally unpredictable behaviour on ARMv6+, and ioremap()
> > > > > > > 	<4>will fail in the next kernel release.  Please fix your driver.
> > > > > > > 
> > > > > > > Tested-by: Michael Grzeschik <mgr@pengutronix.de>
> > > > > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > > > > ---
> > > > > > > Hello,
> > > > > > > 
> > > > > > > it seems to work this way, still I'd like to have some feedback if this
> > > > > > > is done right.  Russell?
> > > > > > 
> > > > > > Yes and probably no.  Yes, it's architecturally correct because the memory
> > > > > > will be mapped only once, thereby avoiding the aliasing issue.
> > > > > > 
> > > > > > Probably no, because the memory is mapped strongly as device memory by
> > > > > > ioremap.  ISTR whether memory remains accessible when mapped as a device
> > > > > > is not something covered by the architecture, but I guess is more to do
> > > > > > with how the interconnect on the SoC is setup.
> > > > > > 
> > > > > > In other words, we probably have gremlins lurking in
> > > > > > dma_declare_coherent_memory() which could bite us at a later date.
> > > > > That is, the patch is OK as such, right?
> > > > > 
> > > > > Best regards
> > > > > Uwe
> > > > > 
> > > > 
> > > > I'm trying to achieve the camera support for the i.MX31 3-Stack board.
> > > > The camera driver is in an early stage and results are not as expected
> > > > (I have to solve some timing issues). 
> > > > Adding the dma reservation code as you do in this patch results in 
> > > > system freeze when the capture chain is activated..
> > > Hmm, system freeze as is Sysrq doesn't work anymore?
> > > 
> > > Sysrq-L comes to mind, or CONFIG_DETECT_HUNG_TASK=y together with the
> > > various lock debug options!?
> > Anything new from your side?  I wonder if this is only a problem in your
> > driver.  Can I take a look at your driver?
> ping
> 
> I'd like to have this patch in Sascha's for-.38 patch.  Sascha, what do
> you think?
> 
> Uwe
> 

Uwe, the following function works for me:
+static void __init mx31_3ds_reserve(void)
+{
+       long ret;
+       /* reserve MX3_CAMERA_BUF_SIZE for mx3-camera */
+       mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
+                       /* ??? */ MX3_CAMERA_BUF_SIZE);
+       memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
+       memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
+       if (!mx3_camera_base) {
+               pr_err("%s: Wrong base allocation\n", __func__);
+               return;
+       }
+       ret = memblock_reserve(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
+       if (ret) {
+               pr_err("%s: Memory not reserved\n", __func__);
+               return;
+       }
+}

The basic Idea is: why a region allocated, freed and removed can
be declared safely as dma memory for the camera in a second time?
Instead, I used the reserve API on the previous region so I am
sure that region is not used by someone else before declaring it
ad dma region for camera.

The ugly part of this code is that memblock_reserve want a base address
that I have to decide before and I am supposing that the base address
resulting from the allocate/free/remove operations, can be safely fed 
to it.

Without this reservation all tries to use gstreamer on the camera
device results in system freeze.

With a reservation of 8M I am able to end a double buffer pipeline
of a rgb565 1600x1200 image.

[  472.010000] mx3-camera mx3-camera.0: __videobuf_mmap_mapper
[  472.050000] mx3-camera mx3-camera.0: dma_alloc_coherent data is at addr c9000000 (size 3842048)
[  472.080000] mx3-camera mx3-camera.0: mmap c71ea2a0: q=c7194f08 4068a000-40a34000 (3a9800) pgoff 00087800 buf 0
[  472.100000] mx3-camera mx3-camera.0: vm_open c71ea2a0 [count=0,vma=4068a000-40a34000]
[  472.130000] mx3-camera mx3-camera.0: __videobuf_mmap_mapper
[  472.180000] mx3-camera mx3-camera.0: dma_alloc_coherent data is at addr c9400000 (size 3842048)
[  472.200000] mx3-camera mx3-camera.0: mmap c7114b20: q=c7194f08 40ace000-40e78000 (3a9800) pgoff 00087c00 buf 1
[  472.230000] mx3-camera mx3-camera.0: vm_open c7114b20 [count=0,vma=40ace000-40e78000]
[  472.250000] mx3-camera mx3-camera.0: __videobuf_iolock memory method MMAP
[  472.270000] mx3-camera mx3-camera.0: __videobuf_iolock memory method MMAP

Best Regards,

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
