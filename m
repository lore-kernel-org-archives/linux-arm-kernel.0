From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 2 Aug 2011 14:09:37 +0800
Subject: [PATCH v3 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <CACxGe6vvL=xGCGMR0yhyJ8r2zLvBgYhYS1b9_VF3dg5hRNhNzQ@mail.gmail.com>
References: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
	<1312226252-8566-2-git-send-email-shawn.guo@linaro.org>
	<CACxGe6vvL=xGCGMR0yhyJ8r2zLvBgYhYS1b9_VF3dg5hRNhNzQ@mail.gmail.com>
Message-ID: <20110802060936.GA9972@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 11:01:39PM +0100, Grant Likely wrote:
> On Mon, Aug 1, 2011 at 8:17 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > From: Shawn Guo <shawn.guo@freescale.com>
> >
> > It adds device tree support for imx53 boards.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> 
> It's *really* close, but I see a problem...
> 
> > +static const char *imx53_dt_board_compat[] __initdata = {
> > + ? ? ? "fsl,imx53-ard",
> > + ? ? ? "fsl,imx53-evk",
> > + ? ? ? "fsl,imx53-qsb",
> > + ? ? ? "fsl,imx53-smd",
> > + ? ? ? NULL
> > +};
> > +
> > +DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
> > + ? ? ? .map_io ? ? ? ? = mx53_map_io,
> > + ? ? ? .init_early ? ? = imx53_init_early,
> > + ? ? ? .init_irq ? ? ? = mx53_init_irq,
> > + ? ? ? .timer ? ? ? ? ?= &imx53_timer,
> > + ? ? ? .init_machine ? = imx53_dt_init,
> > + ? ? ? .dt_compat ? ? ?= imx53_dt_board_compat,
> > +MACHINE_END
> > +
> > +DT_MACHINE_START(IMX53_DT_ARD, "Freescale i.MX53 ARD (Device Tree Support)")
> > + ? ? ? .map_io ? ? ? ? = mx53_map_io,
> > + ? ? ? .init_early ? ? = imx53_init_early,
> > + ? ? ? .init_irq ? ? ? = mx53_init_irq,
> > + ? ? ? .timer ? ? ? ? ?= &imx53_timer,
> > + ? ? ? .init_machine ? = imx53_ard_init,
> > + ? ? ? .dt_compat ? ? ?= imx53_dt_board_compat,
> > +MACHINE_END
> 
> These two machine_descs will match on exactly the same boards because
> they use the same dt_compat table.  So the ard variant will probably
> never get matched since it will be picked up by the IMX53_DT variant
> first.  Each machine_desc must have a different match table.
> 

I believe I tested it working when I split them into two machine_descs.
Oh, here is the evidence :)

$ arm-linux-gnueabi-objdump -t -j .init.arch.info  vmlinux

vmlinux:     file format elf32-littlearm

SYMBOL TABLE:
c03d73d0 l    d  .init.arch.info        00000000 .init.arch.info
c03d73d0 l     O .init.arch.info        0000003c __mach_desc_MX53_EVK
c03d740c l     O .init.arch.info        0000003c __mach_desc_MX53_SMD
c03d7448 l     O .init.arch.info        0000003c __mach_desc_MX53_LOCO
c03d7484 l     O .init.arch.info        0000003c __mach_desc_MX53_ARD
c03d74c0 l     O .init.arch.info        0000003c __mach_desc_IMX53_DT_ARD
c03d74fc l     O .init.arch.info        0000003c __mach_desc_IMX53_DT
c03d73d0 g       .init.arch.info        00000000 __arch_info_begin
c03d7538 g       .init.arch.info        00000000 __arch_info_end

It seems that gcc compiles the machine_desc in bottom-up order, so ARD
still can match the correct entry.  When I change the code to put
IMX53_DT_ARD before IMX53_DT, the __mach_desc_IMX53_DT_ARD goes behind
__mach_desc_IMX53_DT, in which case the ARD matching will be broken.
So yes, we need to fix it.

> However, today when we were talking you asked if it would be better to
> use a callback into board-specific code instead of the iomux table
> that is implemented in this patch.  I was fine either way, but my
> opinion was that the table would probably result in less code.  Well,
> combined with the above problem, I think I was wrong.  Since the only
> difference in the ard variant is the call to
> imx53_ard_weim_cs_config(), both the cs config and the iomux setup
> will be simpler if both are handled in a callback.  You're original
> instinct was correct.
> 

Ok, here you go.

---8<---
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..9b4395d 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -171,9 +171,6 @@ static struct imxi2c_platform_data mx53_ard_i2c3_data = {
 
 static void __init mx53_ard_io_init(void)
 {
-	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
-				ARRAY_SIZE(mx53_ard_pads));
-
 	gpio_request(ARD_ETHERNET_INT_B, "eth-int-b");
 	gpio_direction_input(ARD_ETHERNET_INT_B);
 
@@ -216,6 +213,13 @@ static int weim_cs_config(void)
 	return 0;
 }
 
+void __init imx53_ard_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
+					 ARRAY_SIZE(mx53_ard_pads));
+	weim_cs_config();
+}
+
 static struct platform_device *devices[] __initdata = {
 	&ard_smsc_lan9220_device,
 };
@@ -225,8 +229,8 @@ static void __init mx53_ard_board_init(void)
 	imx53_soc_init();
 	imx53_add_imx_uart(0, NULL);
 
+	imx53_ard_common_init();
 	mx53_ard_io_init();
-	weim_cs_config();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 1b417b0..7663905 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -131,12 +131,17 @@ static const struct spi_imx_master mx53_evk_spi_data __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
 };
 
+void __init imx53_evk_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
+					 ARRAY_SIZE(mx53_evk_pads));
+}
+
 static void __init mx53_evk_board_init(void)
 {
 	imx53_soc_init();
+	imx53_evk_common_init();
 
-	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
-					ARRAY_SIZE(mx53_evk_pads));
 	mx53_evk_init_uart();
 	mx53_evk_fec_reset();
 	imx53_add_fec(&mx53_evk_fec_pdata);
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 4e1d51d..3922cd5 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -257,12 +257,17 @@ static const struct gpio_led_platform_data mx53loco_leds_data __initconst = {
 	.num_leds	= ARRAY_SIZE(mx53loco_leds),
 };
 
+void __init imx53_qsb_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
+					 ARRAY_SIZE(mx53_loco_pads));
+}
+
 static void __init mx53_loco_board_init(void)
 {
 	imx53_soc_init();
+	imx53_qsb_common_init();
 
-	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
-					ARRAY_SIZE(mx53_loco_pads));
 	imx53_add_imx_uart(0, NULL);
 	mx53_loco_fec_reset();
 	imx53_add_fec(&mx53_loco_fec_data);
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index bc02894..b10c899 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -111,12 +111,17 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+void __init imx53_smd_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
+					 ARRAY_SIZE(mx53_smd_pads));
+}
+
 static void __init mx53_smd_board_init(void)
 {
 	imx53_soc_init();
+	imx53_smd_common_init();
 
-	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
-					ARRAY_SIZE(mx53_smd_pads));
 	mx53_smd_init_uart();
 	mx53_smd_fec_reset();
 	imx53_add_fec(&mx53_smd_fec_data);
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
new file mode 100644
index 0000000..7a09af2
--- /dev/null
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/mx53.h>
+
+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name.
+ */
+static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART1_BASE_ADDR, "imx21-uart.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART2_BASE_ADDR, "imx21-uart.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART3_BASE_ADDR, "imx21-uart.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART4_BASE_ADDR, "imx21-uart.3", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART5_BASE_ADDR, "imx21-uart.4", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-fec", MX53_FEC_BASE_ADDR, "imx25-fec.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx53.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx53.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx53.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx53.3", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-cspi", MX53_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C3_BASE_ADDR, "imx-i2c.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-sdma", MX53_SDMA_BASE_ADDR, "imx35-sdma", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-wdt", MX53_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx53_tzic_of_match[] __initconst = {
+	{ .compatible = "fsl,imx53-tzic", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx53_gpio_of_match[] __initconst = {
+	{ .compatible = "fsl,imx53-gpio", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
+	{ .compatible = "fsl,imx53-iomuxc-ard", .data = imx53_ard_common_init, },
+	{ .compatible = "fsl,imx53-iomuxc-evk", .data = imx53_evk_common_init, },
+	{ .compatible = "fsl,imx53-iomuxc-qsb", .data = imx53_qsb_common_init, },
+	{ .compatible = "fsl,imx53-iomuxc-smd", .data = imx53_smd_common_init, },
+	{ /* sentinel */ }
+};
+
+static void __init imx53_dt_init(void)
+{
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	void (*func)(void);
+	int gpio_irq = MXC_INTERNAL_IRQS + ARCH_NR_GPIOS;
+
+	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
+	if (node) {
+		of_id = of_match_node(imx53_iomuxc_of_match, node);
+		func = of_id->data;
+		func();
+		of_node_put(node);
+	}
+
+	irq_domain_generate_simple(imx53_tzic_of_match, MX53_TZIC_BASE_ADDR, 0);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO1_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO2_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO3_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO4_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO5_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO6_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO7_BASE_ADDR, gpio_irq);
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     imx53_auxdata_lookup, NULL);
+}
+
+static void __init imx53_timer_init(void)
+{
+	mx53_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer imx53_timer = {
+	.init = imx53_timer_init,
+};
+
+static const char *imx53_dt_board_compat[] __initdata = {
+	"fsl,imx53-ard",
+	"fsl,imx53-evk",
+	"fsl,imx53-qsb",
+	"fsl,imx53-smd",
+	NULL
+};
+
+DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
+	.map_io		= mx53_map_io,
+	.init_early	= imx53_init_early,
+	.init_irq	= mx53_init_irq,
+	.timer		= &imx53_timer,
+	.init_machine	= imx53_dt_init,
+	.dt_compat	= imx53_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4e3d978..96fc04d 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -72,4 +72,9 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+extern void imx53_ard_common_init(void);
+extern void imx53_evk_common_init(void);
+extern void imx53_qsb_common_init(void);
+extern void imx53_smd_common_init(void);
+
 #endif

-- 
Regards,
Shawn
