From: pavel@denx.de (Pavel Machek)
Date: Sun, 1 Jul 2012 20:10:38 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120630185743.GA4536@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate> <20120630185743.GA4536@elf.ucw.cz>
Message-ID: <20120701181038.GA26573@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I don't think the ARM maintainers want more implementations of the
> > clock API. New SoCs should instead use the new clock framework in
> > drivers/clk/. See Documentation/clk.txt for details. You can for
> > example look at the mxs or spear implementations for examples.
> 
> Agreed. Looks like fixed-rates.
> 
> > > +	{
> > > +		.dev_id		= "dma-pl330",
> > > +		.clk		= &l4_main_clk,
> > > +	}
> > > +};
> > 
> > These should use the clock framework.
> 
> Yep. Something like this? (Untested)

Did not work, apparently

socfpga_init_early() is too early to call clk_*(). This one actually
finishes kernel boot.

Worrying thing is that if I don't call it at all, it also finishes
kernel boot. So how does one test this properly?
									Pavel



diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 37863d1..81358e6 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -3,6 +3,7 @@ config MACH_SOCFPGA_CYCLONE5
 	bool "SOCFPGA Cyclone5 platform"
 	select HAVE_SMP
 	select PLAT_SOCFPGA_ETH
+	select COMMON_CLK
 	help
 	  Include support for the Altera(R) Cyclone5 development platform.
 
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 5502add..3e79bb0 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= common.o clock.o dw_apb_timer.o
+obj-y					:= common.o dw_apb_timer.o
 obj-$(CONFIG_MACH_SOCFPGA_CYCLONE5)	+= socfpga_cyclone5.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
\ No newline at end of file
diff --git a/arch/arm/mach-socfpga/common.c b/arch/arm/mach-socfpga/common.c
index 331040e..0df10ef 100644
--- a/arch/arm/mach-socfpga/common.c
+++ b/arch/arm/mach-socfpga/common.c
@@ -22,6 +22,7 @@
 #include <linux/clkdev.h>
 #include <linux/gfp.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 
 #include <mach/iomap.h>
 #include <mach/socfpga_cyclone5.h>
@@ -49,51 +50,6 @@ extern struct dma_pl330_platdata dma_platform_data;
 #define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
 #define SOCFPGA_L4_MAIN_CLK					(400000000)
 
-static struct clk dummy_apb_pclk;
-static struct clk dummy_i2c_clk = {
-	.rate   = 100000000,
-};
-static struct clk dummy_spim_clk = {
-	.rate   = 100000000,
-};
-static struct clk mpu_periphclk = {
-	.rate   = SOCFPGA_MPU_PERIHCLK_FREQ_HZ,
-};
-
-static struct clk l4_main_clk = {
-	.rate   = SOCFPGA_L4_MAIN_CLK,
-};
-
-static struct clk_lookup lookups[] = {
-	{	/* Bus clock */
-		.con_id		= "apb_pclk",
-		.clk		= &dummy_apb_pclk,
-	},
-	{
-		.dev_id		= "ffc04000.i2c",
-		.clk		= &dummy_i2c_clk,
-	},
-	{
-		.dev_id		= "ffc05000.i2c",
-		.clk		= &dummy_i2c_clk,
-	},
-	{
-		.dev_id		= "dw-spi-mmio.0",
-		.clk		= &dummy_spim_clk,
-	},
-	{
-		.dev_id		= "dw-spi-mmio.1",
-		.clk		= &dummy_spim_clk,
-	},
-	{
-		.dev_id		= "smp_twd",
-		.clk		= &mpu_periphclk,
-	},
-	{
-		.dev_id		= "dma-pl330",
-		.clk		= &l4_main_clk,
-	}
-};
 
 struct plat_serial8250_port uart_platform_data[] = {
 		{
@@ -103,11 +59,46 @@ struct plat_serial8250_port uart_platform_data[] = {
 		},
 };
 
+void __init socfpga_init_clocks(void)
+{
+	struct clk *dummy_apb_pclk;
+	struct clk *dummy_i2c_clk;
+	struct clk *dummy_spim_clk;
+	struct clk *mpu_periphclk;
+	struct clk *l4_main_clk;
+
+	dummy_apb_pclk = clk_register_fixed_rate(NULL, "apb", NULL, 0, 0);
+	dummy_i2c_clk  = clk_register_fixed_rate(NULL, "i2c", NULL, 0, 100000000);
+	dummy_spim_clk = clk_register_fixed_rate(NULL, "spim", NULL, 0, 100000000);
+	mpu_periphclk  = clk_register_fixed_rate(NULL, "mpu_periph", NULL, 0, SOCFPGA_MPU_PERIHCLK_FREQ_HZ);
+	l4_main_clk    = clk_register_fixed_rate(NULL, "l4_main", NULL, 0, SOCFPGA_L4_MAIN_CLK);
+
+	{ 
+		static struct clk_lookup lookups[7];
+		lookups[0].con_id	= "apb_pclk"; 	/* Bus clock */
+		lookups[0].clk		= dummy_apb_pclk;
+		lookups[1].dev_id	= "ffc04000.i2c";
+		lookups[1].clk		= dummy_i2c_clk;
+		lookups[2].dev_id	= "ffc05000.i2c";
+		lookups[2].clk		= dummy_i2c_clk;
+		lookups[3].dev_id	= "dw-spi-mmio.0";
+		lookups[3].clk		= dummy_spim_clk;
+		lookups[4].dev_id	= "dw-spi-mmio.1";
+		lookups[4].clk		= dummy_spim_clk;
+		lookups[5].dev_id	= "smp_twd";
+		lookups[5].clk		= mpu_periphclk;
+		lookups[6].dev_id	= "dma-pl330";
+		lookups[6].clk		= l4_main_clk;
+		clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+	}
+}
+
 void __init socfpga_init_early(void)
 {
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 }
 
+//initcall(socfpga_init_clocks);
+
 /*
  * Where is the timer (VA)?
  */
diff --git a/arch/arm/mach-socfpga/include/mach/clock.h b/arch/arm/mach-socfpga/include/mach/clock.h
index 5187064..de9d3b2 100644
--- a/arch/arm/mach-socfpga/include/mach/clock.h
+++ b/arch/arm/mach-socfpga/include/mach/clock.h
@@ -1,11 +1,4 @@
 #ifndef __MACH_CLOCK_H
 #define __MACH_CLOCK_H
 
-struct clk;
-
-struct clk_ops {
-	long	(*round)(struct clk *, unsigned long);
-	int	(*set)(struct clk *, unsigned long);
-};
-
 #endif
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
