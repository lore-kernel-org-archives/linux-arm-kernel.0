From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Aug 2012 14:16:13 +0200
Subject: [PATCH 5/6] ARM: integrator: convert AMBA devices to device tree
Message-ID: <1345119373-22774-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the AMBA (PrimeCell) devices on the Integrator/AP
and Integrator/CP over to probing from the Device Tree if the
kernel is compiled for Device Tree support.

We continue to #ifdef out all non-DT code and vice versa on
respective boot type to get a clean cut.

We need to add a bunch of auxdata (compare to the Versatile)
to handle bus names and callbacks alike.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts       |  47 +++++++++++++
 arch/arm/boot/dts/integratorcp.dts       |  64 ++++++++++++++++++
 arch/arm/mach-integrator/common.h        |   2 +
 arch/arm/mach-integrator/core.c          |   8 ++-
 arch/arm/mach-integrator/integrator_ap.c | 109 ++++++++++++++++++++++---------
 arch/arm/mach-integrator/integrator_cp.c |  97 +++++++++++++++++----------
 6 files changed, 261 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index a40d1ec0..303d001 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -23,4 +23,51 @@
 		clear-mask = <0xffffffff>;
 		valid-mask = <0x003fffff>;
 	};
+
+	fpga {
+		compatible = "arm,amba-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rtc: rtc at 15000000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x15000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <8>;
+			arm,primecell-periphid = <0x00041030>;
+		};
+
+		uart0: uart at 16000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x16000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <1>;
+			arm,primecell-periphid = <0x00041010>;
+		};
+
+		uart1: uart at 17000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x17000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <2>;
+			arm,primecell-periphid = <0x00041010>;
+		};
+
+		kmi0: kmi at 18000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x18000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <3>;
+			arm,primecell-periphid = <0x00041050>;
+		};
+
+		kmi1: kmi at 19000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x19000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <4>;
+			arm,primecell-periphid = <0x00041050>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index b6ca10f..517d420 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -43,4 +43,68 @@
 		clear-mask = <0x00000fff>;
 		valid-mask = <0x00000fff>;
 	};
+
+	fpga {
+		compatible = "arm,amba-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rtc: rtc at 15000000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x15000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <8>;
+		};
+
+		uart0: uart at 16000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x16000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <1>;
+		};
+
+		uart1: uart at 17000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x17000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <2>;
+		};
+
+		kmi0: kmi at 18000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x18000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <3>;
+		};
+
+		kmi1: kmi at 19000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x19000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <4>;
+		};
+
+		mmci: mmc at 1C000000 {
+			compatible = "arm,pl180", "arm,primecell";
+			reg = <0x1C000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <23 24>;
+			max-frequency = <515633>;
+		};
+
+		aaci: aaci at 1D000000 {
+			compatible = "arm,pl041", "arm,primecell";
+			reg = <0x1D000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <25>;
+		};
+
+		clcd: clcd at c0000000 {
+			compatible = "arm,pl110", "arm,primecell";
+			reg = <0xC0000000 0x1000>;
+			interrupt-parent = <&pic>;
+			interrupts = <22>;
+		};
+	};
 };
diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index c4338e2..c3ff21b 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -1,3 +1,5 @@
+#include <linux/amba/serial.h>
+extern struct amba_pl010_data integrator_uart_data;
 void integrator_init_early(void);
 int integrator_init(bool is_cp);
 void integrator_reserve(void);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 67ea181..42890c8 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -33,7 +33,9 @@
 #include <asm/mach/time.h>
 #include <asm/pgtable.h>
 
-static struct amba_pl010_data integrator_uart_data;
+#include "common.h"
+
+#ifndef CONFIG_OF
 
 #define INTEGRATOR_RTC_IRQ	{ IRQ_RTCINT }
 #define INTEGRATOR_UART0_IRQ	{ IRQ_UARTINT0 }
@@ -86,6 +88,8 @@ int __init integrator_init(bool is_cp)
 	return 0;
 }
 
+#endif
+
 /*
  * On the Integrator platform, the port RTS and DTR are provided by
  * bits in the following SC_CTRLS register bits:
@@ -122,7 +126,7 @@ static void integrator_uart_set_mctrl(struct amba_device *dev, void __iomem *bas
 	__raw_writel(ctrlc, SC_CTRLC);
 }
 
-static struct amba_pl010_data integrator_uart_data = {
+struct amba_pl010_data integrator_uart_data = {
 	.set_mctrl = integrator_uart_set_mctrl,
 };
 
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 58b0a58..ff20173 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -35,6 +35,7 @@
 #include <linux/clk.h>
 #include <linux/platform_data/clk-integrator.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
@@ -270,36 +271,6 @@ static struct platform_device cfi_flash_device = {
 	.resource	= &cfi_flash_resource,
 };
 
-static void __init ap_init(void)
-{
-	unsigned long sc_dec;
-	int i;
-
-	platform_device_register(&cfi_flash_device);
-
-	sc_dec = readl(VA_SC_BASE + INTEGRATOR_SC_DEC_OFFSET);
-	for (i = 0; i < 4; i++) {
-		struct lm_device *lmdev;
-
-		if ((sc_dec & (16 << i)) == 0)
-			continue;
-
-		lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
-		if (!lmdev)
-			continue;
-
-		lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
-		lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
-		lmdev->resource.flags = IORESOURCE_MEM;
-		lmdev->irq = IRQ_AP_EXPINT0 + i;
-		lmdev->id = i;
-
-		lm_device_register(lmdev);
-	}
-
-	integrator_init(false);
-}
-
 /*
  * Where is the timer (VA)?
  */
@@ -472,6 +443,52 @@ static void __init ap_init_irq_of(void)
 	integrator_clk_init(false);
 }
 
+/* For the Device Tree, add in the UART callbacks as AUXDATA */
+static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
+		"rtc", NULL),
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART0_BASE,
+		"uart0", &integrator_uart_data),
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART1_BASE,
+		"uart1", &integrator_uart_data),
+	OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
+		"kmi0", NULL),
+	OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
+		"kmi1", NULL),
+	{ /* sentinel */ },
+};
+
+static void __init ap_init_of(void)
+{
+	unsigned long sc_dec;
+	int i;
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			ap_auxdata_lookup, NULL);
+
+	platform_device_register(&cfi_flash_device);
+
+	sc_dec = readl(VA_SC_BASE + INTEGRATOR_SC_DEC_OFFSET);
+	for (i = 0; i < 4; i++) {
+		struct lm_device *lmdev;
+
+		if ((sc_dec & (16 << i)) == 0)
+			continue;
+
+		lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
+		if (!lmdev)
+			continue;
+
+		lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
+		lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
+		lmdev->resource.flags = IORESOURCE_MEM;
+		lmdev->irq = IRQ_AP_EXPINT0 + i;
+		lmdev->id = i;
+
+		lm_device_register(lmdev);
+	}
+}
+
 static const char * ap_dt_board_compat[] = {
 	"arm,integrator-ap",
 	NULL,
@@ -485,7 +502,7 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.init_irq	= ap_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
 	.timer		= &ap_timer,
-	.init_machine	= ap_init,
+	.init_machine	= ap_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = ap_dt_board_compat,
 MACHINE_END
@@ -514,6 +531,36 @@ static void __init ap_init_irq(void)
 	integrator_clk_init(false);
 }
 
+static void __init ap_init(void)
+{
+	unsigned long sc_dec;
+	int i;
+
+	platform_device_register(&cfi_flash_device);
+
+	sc_dec = readl(VA_SC_BASE + INTEGRATOR_SC_DEC_OFFSET);
+	for (i = 0; i < 4; i++) {
+		struct lm_device *lmdev;
+
+		if ((sc_dec & (16 << i)) == 0)
+			continue;
+
+		lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
+		if (!lmdev)
+			continue;
+
+		lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
+		lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
+		lmdev->resource.flags = IORESOURCE_MEM;
+		lmdev->irq = IRQ_AP_EXPINT0 + i;
+		lmdev->id = i;
+
+		lm_device_register(lmdev);
+	}
+
+	integrator_init(false);
+}
+
 MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 0f6dc99..c341174 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/platform_data/clk-integrator.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -244,16 +245,6 @@ static struct mmci_platform_data mmc_data = {
 	.gpio_cd	= -1,
 };
 
-#define INTEGRATOR_CP_MMC_IRQS	{ IRQ_CP_MMCIINT0, IRQ_CP_MMCIINT1 }
-#define INTEGRATOR_CP_AACI_IRQS	{ IRQ_CP_AACIINT }
-
-static AMBA_APB_DEVICE(mmc, "mmci", 0, INTEGRATOR_CP_MMC_BASE,
-	INTEGRATOR_CP_MMC_IRQS, &mmc_data);
-
-static AMBA_APB_DEVICE(aaci, "aaci", 0, INTEGRATOR_CP_AACI_BASE,
-	INTEGRATOR_CP_AACI_IRQS, NULL);
-
-
 /*
  * CLCD support
  */
@@ -304,15 +295,6 @@ static struct clcd_board clcd_data = {
 	.remove		= versatile_clcd_remove_dma,
 };
 
-static AMBA_AHB_DEVICE(clcd, "clcd", 0, INTCP_PA_CLCD_BASE,
-	{ IRQ_CP_CLCDCINT }, &clcd_data);
-
-static struct amba_device *amba_devs[] __initdata = {
-	&mmc_device,
-	&aaci_device,
-	&clcd_device,
-};
-
 #define REFCOUNTER (__io_address(INTEGRATOR_HDR_BASE) + 0x28)
 
 static void __init intcp_init_early(void)
@@ -322,19 +304,6 @@ static void __init intcp_init_early(void)
 #endif
 }
 
-static void __init intcp_init(void)
-{
-	int i;
-
-	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
-
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-	integrator_init(true);
-}
-
 #define TIMER0_VA_BASE __io_address(INTEGRATOR_TIMER0_BASE)
 #define TIMER1_VA_BASE __io_address(INTEGRATOR_TIMER1_BASE)
 #define TIMER2_VA_BASE __io_address(INTEGRATOR_TIMER2_BASE)
@@ -366,6 +335,37 @@ static void __init intcp_init_irq_of(void)
 	integrator_clk_init(true);
 }
 
+/*
+ * For the Device Tree, add in the UART, MMC and CLCD specifics as AUXDATA
+ * and enforce the bus names since these are used for clock lookups.
+ */
+static struct of_dev_auxdata intcp_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
+		"rtc", NULL),
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART0_BASE,
+		"uart0", &integrator_uart_data),
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART1_BASE,
+		"uart1", &integrator_uart_data),
+	OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
+		"kmi0", NULL),
+	OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
+		"kmi1", NULL),
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_CP_MMC_BASE,
+		"mmci", &mmc_data),
+	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_CP_AACI_BASE,
+		"aaci", &mmc_data),
+	OF_DEV_AUXDATA("arm,primecell", INTCP_PA_CLCD_BASE,
+		"clcd", &clcd_data),
+	{ /* sentinel */ },
+};
+
+static void __init intcp_init_of(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table,
+			intcp_auxdata_lookup, NULL);
+	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
+}
+
 static const char * intcp_dt_board_compat[] = {
 	"arm,integrator-cp",
 	NULL,
@@ -379,7 +379,7 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.init_irq	= intcp_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
 	.timer		= &cp_timer,
-	.init_machine	= intcp_init,
+	.init_machine	= intcp_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = intcp_dt_board_compat,
 MACHINE_END
@@ -427,6 +427,37 @@ static void __init intcp_init_irq(void)
 	integrator_clk_init(true);
 }
 
+#define INTEGRATOR_CP_MMC_IRQS	{ IRQ_CP_MMCIINT0, IRQ_CP_MMCIINT1 }
+#define INTEGRATOR_CP_AACI_IRQS	{ IRQ_CP_AACIINT }
+
+static AMBA_APB_DEVICE(mmc, "mmci", 0, INTEGRATOR_CP_MMC_BASE,
+	INTEGRATOR_CP_MMC_IRQS, &mmc_data);
+
+static AMBA_APB_DEVICE(aaci, "aaci", 0, INTEGRATOR_CP_AACI_BASE,
+	INTEGRATOR_CP_AACI_IRQS, NULL);
+
+static AMBA_AHB_DEVICE(clcd, "clcd", 0, INTCP_PA_CLCD_BASE,
+	{ IRQ_CP_CLCDCINT }, &clcd_data);
+
+static struct amba_device *amba_devs[] __initdata = {
+	&mmc_device,
+	&aaci_device,
+	&clcd_device,
+};
+
+static void __init intcp_init(void)
+{
+	int i;
+
+	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
+
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
+		struct amba_device *d = amba_devs[i];
+		amba_device_register(d, &iomem_resource);
+	}
+	integrator_init(true);
+}
+
 MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
-- 
1.7.11.2
