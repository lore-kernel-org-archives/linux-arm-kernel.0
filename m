From: pavel@denx.de (Pavel Machek)
Date: Tue, 10 Jul 2012 13:15:15 +0200
Subject: [RFC PATCHv1 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <20120627162548.01adc769@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-3-git-send-email-dinguyen@altera.com>
 <20120627162548.01adc769@skate>
Message-ID: <20120710111515.GB8701@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Le Wed, 27 Jun 2012 08:50:07 -0500,
> <dinguyen@altera.com> a ?crit :
> 
> > +CONFIG_CMDLINE="console=ttyS0,57600 mem=256M at 0x0"
> 
> Why do you need to specify the memory map here, since it's already
> passed in the device tree?

Fixed.

> > +const static struct of_device_id irq_match[] = {
> > +	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> > +	{}
> > +};
> > +
> > +static struct map_desc cyclone5_io_desc[] __initdata = {
> > +	{
> > +		.virtual	= IO_ADDRESS(SOCFPGA_SPTIMER0_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_SPTIMER0_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_SPTIMER1_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_SPTIMER1_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_OSC1TIMER0_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_OSC1TIMER0_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_OSC1TIMER1_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_OSC1TIMER1_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_MPUSCU_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_MPUSCU_BASE),
> > +		.length		= SZ_8K,
> > +		.type		= MT_DEVICE,
> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_SYSMGR_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_SYSMGR_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_MPUL2_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_MPUL2_BASE),
> > +		.length		= SZ_8K,
> > +		.type		= MT_DEVICE,
> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_CLKMGR_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_CLKMGR_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	},
> > +};
> 
> Most of those static mappings should instead be turned into dynamic
> mappings created with ioremap(), at least for the timers.

Now this one is interesting. I just removed these mappings, and it
still works. I guess that's good.

								Pavel

commit 5f2d9e152e170a328689e5ab0c3f42851b99a4ec
Author: Pavel <pavel@ucw.cz>
Date:   Tue Jul 10 13:08:54 2012 +0200

    cyclone5_map_io seems to be unneccessary. Remove it.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
index 459f5a6..0bc0b8b 100644
--- a/arch/arm/mach-socfpga/socfpga_cyclone5.c
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -50,30 +50,6 @@ const static struct of_device_id irq_match[] = {
 	{}
 };
 
-static struct map_desc cyclone5_io_desc[] __initdata = {
-	{
-		.virtual	= IO_ADDRESS(SOCFPGA_MPUSCU_BASE),
-		.pfn		= __phys_to_pfn(SOCFPGA_MPUSCU_BASE),
-		.length		= SZ_8K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= IO_ADDRESS(SOCFPGA_SYSMGR_BASE),
-		.pfn		= __phys_to_pfn(SOCFPGA_SYSMGR_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= IO_ADDRESS(SOCFPGA_CLKMGR_BASE),
-		.pfn		= __phys_to_pfn(SOCFPGA_CLKMGR_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
-static void __init cyclone5_map_io(void)
-{
-	iotable_init(cyclone5_io_desc, ARRAY_SIZE(cyclone5_io_desc));
-}
-
 static void __init gic_init_irq(void)
 {
 	of_irq_init(irq_match);
@@ -100,7 +76,6 @@ static const char *altera_dt_match[] = {
 };
 
 DT_MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
-	.map_io		= cyclone5_map_io,
 	.init_early	= socfpga_init_early,
 	.init_irq	= gic_init_irq,
 	.handle_irq     = gic_handle_irq,


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
