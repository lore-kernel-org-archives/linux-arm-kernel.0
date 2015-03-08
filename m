From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 08 Mar 2015 22:42:59 +0100
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <20150306174316.GA26692@opensource.wolfsonmicro.com>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-6-git-send-email-arnd@arndb.de>
 <20150306174316.GA26692@opensource.wolfsonmicro.com>
Message-ID: <6643361.dhtMagqMYZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 March 2015 17:43:16 Charles Keepax wrote:
> On Mon, Mar 02, 2015 at 01:35:58PM +0100, Arnd Bergmann wrote:
> > This is another prerequisite for enabling multiplatform
> > support, and it is the part I am least certain about.
> > 
> > I assume it will cause the extra boot message "Cannot
> > allocate irq_descs @ IRQ%d, assuming pre-allocated" to
> > be printed, but otherwise work ok. This definitely needs
> > to be tested on real hardware to see if it works.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> 
> This one appears to cause some problems with the IRQs on
> Cragganmore, I need to look into it a bit more but it looks like
> one of the PMICs can't allocate its IRQs:
> 
> [    0.961455] wm831x 1-0034: WM8311 revision C
> [    0.965066] wm831x 1-0034: Failed to allocate IRQs: -17
> 
> And the CODEC can't request its IRQ:
> 
> [    4.252735] arizona spi0.1: WM5102 revision C
> [    4.269763] arizona spi0.1: Failed to request primary IRQ 263: -22
> 
> Hopefully I can look into this a little more next week.
> 

My interpretation is that I mistakenly set the .nr_irqs value for
craggamore to include all irqs that the board has, while the
wm831x tries to allocate the irq descriptors itself and fails if
they are already allocated. If that is the only problem here, it
would get fixed by this change:

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index f395a5617142..cbe353a5450e 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -855,7 +855,7 @@ static void __init crag6410_machine_init(void)
 MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	/* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
 	.atag_offset	= 0x100,
-	.nr_irqs	= S3C64XX_NR_IRQS + 160,
+	.nr_irqs	= S3C64XX_NR_IRQS,
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,

The samsung-gpio driver does not allocate irq descriptors for itself
though, otherwise we could make the S3C64XX_NR_IRQS number smaller.

	Arnd
