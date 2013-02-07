From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Feb 2013 17:07:01 +0100
Subject: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
In-Reply-To: <5113CD6F.3060108@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <201302071439.13720.arnd@arndb.de> <5113CD6F.3060108@ti.com>
Message-ID: <10081370.NaeII8M1Pj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013 09:51:11 Jon Hunter wrote:
> >> @@ -673,7 +702,7 @@ static int omap_dma_init(void)
> >>  {
> >>      int rc = platform_driver_register(&omap_dma_driver);
> >>  
> >> -    if (rc == 0) {
> >> +    if ((rc == 0) && (!of_have_populated_dt())) {
> >>              pdev = platform_device_register_full(&omap_dma_dev_info);
> >>              if (IS_ERR(pdev)) {
> >>                      platform_driver_unregister(&omap_dma_driver);
> > 
> > There is already a patch in linux-next that makes this obsolete.
> > The device is now registered in arch/arm/mach-omap2/dma.c, so
> > I guess you have to change that location now.
> 
> Thanks. Will rebase on top of linux-next.

Actually, there is another problem with that, because then
you may get into the situation where nobody can apply your
patch.

You should never build work on top of linux-next, because
then your base gets rebuilt every day. Instead, you should
/test/ your branch merged with linux-next to ensure it works
with all the other things in place, and when you see conflicts
like this, you have to find out what they are and then decide
whether you need to rebase it, and to what.

Example:

$ git log --oneline next/master drivers/dma/omap-dma.c | head
be1f948 ARM: OMAP: Fix dmaengine init for multiplatform
45c3eb7 ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h
8280960 ARM: OMAP: Remove cpu_is_omap usage from plat-omap/dma.c
94c6578 Merge branch 'omap-for-v3.8/cleanup-headers-dma' into omap-for-v3.8/cleanup-headers
27615a9 ARM: OMAP: Trivial driver changes to remove include plat/cpu.h
2b6c4e7 ARM: OMAP: DMA: Move plat/dma.h to plat-omap/dma-omap.h
f5a246e Merge tag 'sound-3.7' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
2dde5b9 dmaengine: omap-dma: Add support to suppress interrupts in cyclic mode
ec8b5e4 dmaengine: Pass flags via device_prep_dma_cyclic() callback
2dcdf57 dmaengine: omap: Add support for pause/resume in cyclic dma mode

The topmost patch in linux-next is what has the conflict, so let's
see how that got there:

$ git log --oneline --ancestry-path --merges be1f948..next/master | tail
669166d Merge branch 'next/cleanup' into for-next
82fe557 Merge branch 'next/cleanup' into for-next
2f9adc9 Merge branch 'next/soc' into for-next
91ae65c Merge branch 'next/multiplatform' into for-next
2fd73eb Merge tag 'vt8500-multiplatform-3.9' of git://server.prisktech.co.nz/git/linuxwmt into next/multiplatform
33740d2 Merge branch 'fixes' into for-next
b75baf8 Merge branch 'next/multiplatform' into for-next
6130133 Merge tag 'omap-for-v3.9/multiplatform-enable-signed-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/multiplatform
3613f45 Merge branch 'next/multiplatform' into for-next
45f6a1d Merge tag 'omap-for-v3.9/multiplatform-enable-signed-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/multiplatform


At the bottom, you can see where it got merged. The commit was
in Tony's omap-for-v3.9/multiplatform-enable-signed-v2, which
subsequently got merged into arm-soc/next/multiplatform,
arm-soc/for-next and next/master.

The logical step is to base your patch on top of
omap-for-v3.9/multiplatform-enable-signed-v2, and work with
Tony and/or Olof and me to get that upstream.

	Arnd
