From: pavel@denx.de (Pavel Machek)
Date: Wed, 4 Jul 2012 12:56:53 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120627162014.1494cdd7@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate>
Message-ID: <20120704105653.GA20021@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!


> > +struct plat_serial8250_port uart_platform_data[] = {
> > +		{
> > +		.type		= PORT_16850,
> > +		.flags 		= UPF_BOOT_AUTOCONF | UPF_IOREMAP | \
> > +				  UPF_FIXED_TYPE,
> > +		},
> > +};
> 
> This sounds strange. Why aren't you using the ns16850 compatible string
> to instantiate the UART devices directly from your device tree?

Hmm, strange. I see picoxcell-pc3x2.dtsi using similar
dw-apb-uart. According to 8250_dw.c, it is not completely
16550-compatible, and uses slightly modified driver.

So it can be driven from dts, but not as ns16850 compatible. This
patch does so.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/common.c b/arch/arm/mach-socfpga/common.c
index 0df10ef..ae310a5 100644
--- a/arch/arm/mach-socfpga/common.c
+++ b/arch/arm/mach-socfpga/common.c
@@ -45,20 +45,9 @@
 extern struct dw_mci_board sdmmc_platform_data;
 extern struct dma_pl330_platdata dma_platform_data;
 
-#define DW_APB_UART_OF_COMPATIBLE			"snps,dw-apb-uart"
-
 #define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
 #define SOCFPGA_L4_MAIN_CLK					(400000000)
 
-
-struct plat_serial8250_port uart_platform_data[] = {
-		{
-		.type		= PORT_16850,
-		.flags 		= UPF_BOOT_AUTOCONF | UPF_IOREMAP | \
-				  UPF_FIXED_TYPE,
-		},
-};
-
 void __init socfpga_init_clocks(void)
 {
 	struct clk *dummy_apb_pclk;
@@ -126,12 +115,3 @@ void __init socfpga_timer_init(void __iomem *src_timer_base,
 	dwapbt_clocksource_init(src_timer_base);
 	dwapbt_clockevents_init(event_timer_base, event_timer_irq);
 }
-
-int socfpga_notifier(struct device *device)
-{
-	struct device_node *dn = device->of_node;
-
-	if (of_device_is_compatible(dn, DW_APB_UART_OF_COMPATIBLE))
-		device->platform_data = &uart_platform_data;
-	return 0;
-}
diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
index d8cd89b..d67fc92 100644
--- a/arch/arm/mach-socfpga/socfpga_cyclone5.c
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -138,7 +138,6 @@ static void __init socfpga_cyclone5_init(void)
 	/* 8-way, 64K/way, evmon/parity/share */
 	l2x0_of_init(0x00760000, 0xfe000fff);
 #endif
-	platform_notify =  socfpga_notifier;
 	of_platform_populate(NULL, of_default_bus_match_table,
 		cyclone5_auxdata_lookup, NULL);
 }


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
