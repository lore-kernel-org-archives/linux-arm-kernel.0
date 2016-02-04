From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 4 Feb 2016 15:37:50 +0800
Subject: [PATCH v2 3/4] ARM: at91: pm: configure PMC fast startup signals
In-Reply-To: <1454571471-4434-1-git-send-email-wenyou.yang@atmel.com>
References: <1454571471-4434-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1454571471-4434-4-git-send-email-wenyou.yang@atmel.com>
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

Changes in v2:
 - shorten the pmc-fast-startup property's name.
 - use the value property, instead of bool property for high
   or low triggered.

 arch/arm/mach-at91/pm.c      |  115 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h |   32 ++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index a7aec35..6763de8 100644
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
@@ -425,6 +427,117 @@ static void __init at91_pm_sram_init(void)
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
+static int __init at91_pmc_fast_startup_init(void)
+{
+	struct device_node *np;
+	struct regmap *regmap;
+	const char *pm;
+	u32 mode = 0, polarity = 0;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "atmel,sama5d2-pmc-fast-startup");
+	if (!np)
+		return -ENODEV;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap)) {
+		pr_info("AT91: failed to find PMC fast startup\n");
+		return PTR_ERR(regmap);
+	}
+
+	mode |= of_property_read_bool(np, "atmel,wkup-trigger") ?
+		AT91_PMC_FSTT0 : 0;
+	mode |= of_property_read_bool(np, "atmel,secumod-trigger") ?
+		AT91_PMC_FSTT1 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu0-trigger") ?
+		AT91_PMC_FSTT2 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu1-trigger") ?
+		AT91_PMC_FSTT3 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu2-trigger") ?
+		AT91_PMC_FSTT4 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu3-trigger") ?
+		AT91_PMC_FSTT5 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu4-trigger") ?
+		AT91_PMC_FSTT6 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu5-trigger") ?
+		AT91_PMC_FSTT7 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu6-trigger") ?
+		AT91_PMC_FSTT8 : 0;
+	mode |= of_property_read_bool(np, "atmel,piobu7-trigger") ?
+		AT91_PMC_FSTT9 : 0;
+	mode |= of_property_read_bool(np, "atmel,gmac-wol-trigger") ?
+		AT91_PMC_FSTT10 : 0;
+	mode |= of_property_read_bool(np, "atmel,rtc-alarm-trigger") ?
+		AT91_PMC_RTCAL : 0;
+	mode |= of_property_read_bool(np, "atmel,usb-resume-trigger") ?
+		AT91_PMC_USBAL : 0;
+	mode |= of_property_read_bool(np, "atmel,sdmmc-cd-trigger") ?
+		AT91_PMC_SDMMC_CD : 0;
+	mode |= of_property_read_bool(np, "atmel,rxlp-match-trigger") ?
+		AT91_PMC_RXLP_MCE : 0;
+	mode |= of_property_read_bool(np, "atmel,acc-comparison-trigger") ?
+		AT91_PMC_ACC_CE : 0;
+
+	if (!of_property_read_string(np, "atmel,wkup-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP0;
+	}
+
+	if (mode & AT91_PMC_FSTT1)
+		polarity |= AT91_PMC_FSTP1;
+
+	if (!of_property_read_string(np, "atmel,piobu0-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP2;
+	}
+
+	if (!of_property_read_string(np, "atmel,piobu1-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP3;
+	}
+
+	if (!of_property_read_string(np, "atmel,piobu2-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP4;
+	}
+
+	if (!of_property_read_string(np, "atmel,piobu3-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP5;
+	}
+
+	if (!of_property_read_string(np, "atmel,piobu4-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP6;
+	}
+
+	if (!of_property_read_string(np, "atmel,piobu5-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP7;
+	}
+
+	if (!of_property_read_string(np, "atmel,piobu6-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP8;
+	}
+
+	if (!of_property_read_string(np, "atmel,piobu7-trigger-level", &pm)) {
+		if (!strcasecmp(pm, "high"))
+			polarity |= AT91_PMC_FSTP9;
+	}
+
+	if (mode & AT91_PMC_FSTT10)
+		polarity |= AT91_PMC_FSTP10;
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
 static const struct of_device_id atmel_pmc_ids[] = {
 	{ .compatible = "atmel,at91rm9200-pmc"  },
 	{ .compatible = "atmel,at91sam9260-pmc" },
@@ -509,4 +622,6 @@ void __init sama5_pm_init(void)
 
 	if (readl(pmc + AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION)
 		at91_pm_data.ulp_mode = ULP1_MODE;
+
+	at91_pmc_fast_startup_init();
 }
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 4afd891..683580e 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -168,6 +168,38 @@
 #define		AT91_PMC_WPVS		(0x1  <<  0)		/* Write Protect Violation Status */
 #define		AT91_PMC_WPVSRC		(0xffff  <<  8)		/* Write Protect Violation Source */
 
+#define AT91_PMC_FSMR		0x70		/* Fast Startup Mode Register */
+#define AT91_PMC_FSTT0		BIT(0)		/* WKUP Pin Enable */
+#define AT91_PMC_FSTT1		BIT(1)		/* Security Module Enable */
+#define AT91_PMC_FSTT2		BIT(2)		/* PIOBU0 Input Enable */
+#define AT91_PMC_FSTT3		BIT(3)		/* PIOBU1 Input Enable */
+#define AT91_PMC_FSTT4		BIT(4)		/* PIOBU2 Input Enable */
+#define AT91_PMC_FSTT5		BIT(5)		/* PIOBU3 Input Enable */
+#define AT91_PMC_FSTT6		BIT(6)		/* PIOBU4 Input Enable */
+#define AT91_PMC_FSTT7		BIT(7)		/* PIOBU5 Input Enable */
+#define AT91_PMC_FSTT8		BIT(8)		/* PIOBU6 Input Enable */
+#define AT91_PMC_FSTT9		BIT(9)		/* PIOBU7 Input Enable */
+#define AT91_PMC_FSTT10		BIT(10)		/* GMAC Wake-up On LAN Enable */
+#define AT91_PMC_RTCAL		BIT(17)		/* RTC Alarm Enable */
+#define AT91_PMC_USBAL		BIT(18)		/* USB Resume Enable */
+#define AT91_PMC_SDMMC_CD	BIT(19)		/* SDMMC Card Detect Enable */
+#define AT91_PMC_LPM		BIT(20)		/* Low-power Mode */
+#define AT91_PMC_RXLP_MCE	BIT(24)		/* Backup UART Receive Enable */
+#define AT91_PMC_ACC_CE		BIT(25)		/* ACC Enable */
+
+#define AT91_PMC_FSPR		0x74		/* Fast Startup Polarity Reg */
+#define AT91_PMC_FSTP0		BIT(0)		/* WKUP Pin Polarity */
+#define AT91_PMC_FSTP1		BIT(1)		/* Security Module Polarity */
+#define AT91_PMC_FSTP2		BIT(2)		/* PIOBU0 Pin Polarity */
+#define AT91_PMC_FSTP3		BIT(3)		/* PIOBU1 Pin Polarity */
+#define AT91_PMC_FSTP4		BIT(4)		/* PIOBU2 Pin Polarity */
+#define AT91_PMC_FSTP5		BIT(5)		/* PIOBU3 Pin Polarity */
+#define AT91_PMC_FSTP6		BIT(6)		/* PIOBU4 Pin Polarity */
+#define AT91_PMC_FSTP7		BIT(7)		/* PIOBU5 Pin Polarity */
+#define AT91_PMC_FSTP8		BIT(8)		/* PIOBU6 Pin Polarity */
+#define AT91_PMC_FSTP9		BIT(9)		/* PIOBU7 Pin Polarity */
+#define AT91_PMC_FSTP10		BIT(10)		/* Wake-up On LAN Polarity */
+
 #define AT91_PMC_VERSION	0xfc
 
 #define AT91_PMC_PCER1		0x100			/* Peripheral Clock Enable Register 1 [SAMA5 only]*/
-- 
1.7.9.5
