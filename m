From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  1 Sep 2012 05:55:57 +0200
Subject: [PATCH 5/6 v2] ARM: integrator: convert AMBA devices to device tree
In-Reply-To: <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <1346471760-23993-5-git-send-email-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Move interrupt-parent up one step to the fpga bus for the
  PrimeCell devices. (Suggestion from Arnd Bergmann)
---
 arch/arm/boot/dts/integratorap.dts       |  43 ++++++++++++
 arch/arm/boot/dts/integratorcp.dts       |  57 ++++++++++++++++
 arch/arm/mach-integrator/common.h        |   2 +
 arch/arm/mach-integrator/core.c          |   8 ++-
 arch/arm/mach-integrator/integrator_ap.c | 109 ++++++++++++++++++++++---------
 arch/arm/mach-integrator/integrator_cp.c |  84 ++++++++++++++++++------
 6 files changed, 250 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 928a7be..de51bcf 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -48,4 +48,47 @@
 		clear-mask = <0xffffffff>;
 		valid-mask = <0x003fffff>;
 	};
+
+	fpga {
+		compatible = "arm,amba-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&pic>;
+
+		rtc: rtc at 15000000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x15000000 0x1000>;
+			interrupts = <8>;
+			arm,primecell-periphid = <0x00041030>;
+		};
+
+		uart0: uart at 16000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x16000000 0x1000>;
+			interrupts = <1>;
+			arm,primecell-periphid = <0x00041010>;
+		};
+
+		uart1: uart at 17000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x17000000 0x1000>;
+			interrupts = <2>;
+			arm,primecell-periphid = <0x00041010>;
+		};
+
+		kmi0: kmi at 18000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x18000000 0x1000>;
+			interrupts = <3>;
+			arm,primecell-periphid = <0x00041050>;
+		};
+
+		kmi1: kmi at 19000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x19000000 0x1000>;
+			interrupts = <4>;
+			arm,primecell-periphid = <0x00041050>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 8fad5a1..3265b25 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -66,4 +66,61 @@
 		clear-mask = <0x00000fff>;
 		valid-mask = <0x00000fff>;
 	};
+
+	fpga {
+		compatible = "arm,amba-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&pic>;
+
+		rtc: rtc at 15000000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x15000000 0x1000>;
+			interrupts = <8>;
+		};
+
+		uart0: uart at 16000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x16000000 0x1000>;
+			interrupts = <1>;
+		};
+
+		uart1: uart at 17000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x17000000 0x1000>;
+			interrupts = <2>;
+		};
+
+		kmi0: kmi at 18000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x18000000 0x1000>;
+			interrupts = <3>;
+		};
+
+		kmi1: kmi at 19000000 {
+			compatible = "arm,pl050", "arm,primecell";
+			reg = <0x19000000 0x1000>;
+			interrupts = <4>;
+		};
+
+		mmci: mmc at 1C000000 {
+			compatible = "arm,pl180", "arm,primecell";
+			reg = <0x1C000000 0x1000>;
+			interrupts = <23 24>;
+			max-frequency = <515633>;
+		};
+
+		aaci: aaci at 1D000000 {
+			compatible = "arm,pl041", "arm,primecell";
+			reg = <0x1D000000 0x1000>;
+			interrupts = <25>;
+		};
+
+		clcd: clcd at c0000000 {
+			compatible = "arm,pl110", "arm,primecell";
+			reg = <0xC0000000 0x1000>;
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
index 26d4d8c..990ce85 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -36,6 +36,7 @@
 #include <linux/platform_data/clk-integrator.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
@@ -271,36 +272,6 @@ static struct platform_device cfi_flash_device = {
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
@@ -493,6 +464,52 @@ static void __init ap_init_irq_of(void)
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
@@ -506,7 +523,7 @@ DT_MACHINE_START(INTEGRATOR_AP_DT, "ARM Integrator/AP (Device Tree)")
 	.init_irq	= ap_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
 	.timer		= &ap_of_timer,
-	.init_machine	= ap_init,
+	.init_machine	= ap_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = ap_dt_board_compat,
 MACHINE_END
@@ -558,6 +575,36 @@ static void __init ap_init_irq(void)
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
index e7f2fb6..1b07aa6 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -25,6 +25,7 @@
 #include <linux/platform_data/clk-integrator.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -245,16 +246,6 @@ static struct mmci_platform_data mmc_data = {
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
@@ -305,15 +296,6 @@ static struct clcd_board clcd_data = {
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
@@ -372,6 +354,37 @@ static void __init intcp_init_irq_of(void)
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
@@ -385,7 +398,7 @@ DT_MACHINE_START(INTEGRATOR_CP_DT, "ARM Integrator/CP (Device Tree)")
 	.init_irq	= intcp_init_irq_of,
 	.handle_irq	= fpga_handle_irq,
 	.timer		= &cp_of_timer,
-	.init_machine	= intcp_init,
+	.init_machine	= intcp_init_of,
 	.restart	= integrator_restart,
 	.dt_compat      = intcp_dt_board_compat,
 MACHINE_END
@@ -451,6 +464,37 @@ static struct sys_timer cp_timer = {
 	.init		= intcp_timer_init,
 };
 
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
1.7.11.4
