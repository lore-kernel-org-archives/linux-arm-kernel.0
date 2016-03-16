From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 16 Mar 2016 14:58:07 +0800
Subject: [PATCH v5 3/5] ARM: at91: pm: configure PMC fast startup signals
In-Reply-To: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
References: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1458111489-23774-4-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fast startup signal is used as wake up sources for ULP1 mode.
As soon as a fast startup signal is asserted, the embedded 12 MHz
RC oscillator restarts automatically.

This patch is to configure the fast startup signals, which signal
is enabled to trigger the PMC to wake up the system from ULP1 mode
should be configured via the DT.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v5:
 - to improve the scalability, rework the DT expression part, use
   the child nodes to describe the wake-up input and its active level.

Changes in v4: None
Changes in v3:
 - use 0 and 1, not string, to define the trigger active polarity.

Changes in v2:
 - shorten the pmc-fast-startup property's name.
 - use the value property, instead of bool property for high
   or low triggered.

 arch/arm/mach-at91/pm.c      |   66 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h |   14 +++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5c2db34..29895f1 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -24,6 +24,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk/at91_pmc.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <asm/irq.h>
 #include <linux/atomic.h>
@@ -461,6 +463,68 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 		pr_info("AT91: PM not supported, due to no SRAM allocated\n");
 }
 
+static int __init at91_pmc_fast_startup_init(void)
+{
+	struct device_node *np, *cnp;
+	struct regmap *regmap;
+	u32 input, input_mask;
+	u32 mode = 0, polarity = 0;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "atmel,sama5d2-pmc-fast-startup");
+	if (!np)
+		return -ENODEV;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap)) {
+		pr_info("AT91: failed to find PMC fast startup node\n");
+		return PTR_ERR(regmap);
+	}
+
+	for_each_child_of_node(np, cnp) {
+		if (of_property_read_u32(cnp, "reg", &input)) {
+			pr_warn("AT91: reg property is missing for %s\n",
+				cnp->full_name);
+			continue;
+		}
+
+		input_mask = 1 << input;
+		if (!(input_mask & AT91_PMC_FS_INPUT_MASK)) {
+			pr_warn("AT91: wake-up input %d out of range\n", input);
+			continue;
+		}
+		mode |= input_mask;
+
+		if (of_property_read_bool(cnp, "atmel,wakeup-active-high"))
+			polarity |= input_mask;
+	}
+
+	if (of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
+		mode |= AT91_PMC_RTCAL;
+
+	if (of_property_read_bool(np, "atmel,wakeup-usb-resume"))
+		mode |= AT91_PMC_USBAL;
+
+	if (of_property_read_bool(np, "atmel,wakeup-sdmmc-cd"))
+		mode |= AT91_PMC_SDMMC_CD;
+
+	if (of_property_read_bool(np, "atmel,wakeup-rxlp-match"))
+		mode |= AT91_PMC_RXLP_MCE;
+
+	if (of_property_read_bool(np, "atmel,wakeup-acc-comparison"))
+		mode |= AT91_PMC_ACC_CE;
+
+	pr_debug("AT91: mode = 0x%x, ploarity = 0%x\n", mode, polarity);
+
+	regmap_write(regmap, AT91_PMC_FSMR, mode);
+
+	regmap_write(regmap, AT91_PMC_FSPR, polarity);
+
+	of_node_put(np);
+
+	return 0;
+}
+
 void __init at91rm9200_pm_init(void)
 {
 	at91_dt_ramc();
@@ -509,4 +573,6 @@ void __init sama5_pm_init(void)
 
 	if (readl(pmc + AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION)
 		at91_pm_data.ulp_mode = ULP1_MODE;
+
+	at91_pmc_fast_startup_init();
 }
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 4afd891..4b942c5 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -168,6 +168,20 @@
 #define		AT91_PMC_WPVS		(0x1  <<  0)		/* Write Protect Violation Status */
 #define		AT91_PMC_WPVSRC		(0xffff  <<  8)		/* Write Protect Violation Source */
 
+#define AT91_PMC_FSMR		0x70		/* Fast Startup Mode Register */
+#define AT91_PMC_FSTT(n)	(0x1 << n)
+#define AT91_PMC_RTCAL		BIT(17)		/* RTC Alarm Enable */
+#define AT91_PMC_USBAL		BIT(18)		/* USB Resume Enable */
+#define AT91_PMC_SDMMC_CD	BIT(19)		/* SDMMC Card Detect Enable */
+#define AT91_PMC_LPM		BIT(20)		/* Low-power Mode */
+#define AT91_PMC_RXLP_MCE	BIT(24)		/* Backup UART Receive Enable */
+#define AT91_PMC_ACC_CE		BIT(25)		/* ACC Enable */
+
+#define AT91_PMC_FSPR		0x74		/* Fast Startup Polarity Reg */
+#define AT91_PMC_FSTP(n)	(0x1 << n)
+
+#define AT91_PMC_FS_INPUT_MASK  0x7ff
+
 #define AT91_PMC_VERSION	0xfc
 
 #define AT91_PMC_PCER1		0x100			/* Peripheral Clock Enable Register 1 [SAMA5 only]*/
-- 
1.7.9.5
