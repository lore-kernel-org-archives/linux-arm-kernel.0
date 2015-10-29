From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 29 Oct 2015 13:55:46 +0800
Subject: [RFC PATCH 1/2] ARM: at91: pm: init fast startup trigger signals to
 PMC
In-Reply-To: <1446098147-32487-1-git-send-email-wenyou.yang@atmel.com>
References: <1446098147-32487-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1446098147-32487-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to configure the fast startup signals, and which
signal is enabled to trigger to the PMC can be configured via
the DT property.

The fast startup signal is used as wake up sources for ULP1 mode.
As soon as a fast startup signal is asserted, the embedded 12 MHz
RC oscillator restarts automatically.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/mach-at91/pm.c      |   60 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h |   32 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e7ba340..ddf1ed9 100644
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
@@ -411,6 +413,62 @@ static void __init at91_pm_sram_init(void)
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
+static void __init at91_pmc_fast_startup_init(void)
+{
+	struct device_node *np;
+	struct regmap *regmap;
+	u32 regval;
+
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-pmc-fast-startup");
+	if (!np)
+		return;
+
+	regmap = syscon_node_to_regmap(of_get_parent(np));
+	if (IS_ERR(regmap)) {
+		pr_info("AT91: failed to find PMC fast startup\n");
+		return;
+	}
+
+	regval = of_property_read_bool(np, "atmel,fast-startup-wake-up") ?
+				AT91_PMC_FSTT0 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-secumod") ?
+				AT91_PMC_FSTT1 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu0") ?
+				AT91_PMC_FSTT2 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu1") ?
+				AT91_PMC_FSTT3 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu2") ?
+				AT91_PMC_FSTT4 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu3") ?
+				AT91_PMC_FSTT5 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu4") ?
+				AT91_PMC_FSTT6 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu5") ?
+				AT91_PMC_FSTT7 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu6") ?
+				AT91_PMC_FSTT8 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-piobu7") ?
+				AT91_PMC_FSTT9 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-gmac-wol") ?
+				AT91_PMC_FSTT10 : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-rtc-alarm") ?
+				AT91_PMC_RTCAL : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-usb-resume") ?
+				AT91_PMC_USBAL : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-sdmmc-cd") ?
+				AT91_PMC_SDMMC_CD : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-rxlp-match") ?
+				AT91_PMC_RXLP_MCE : 0;
+	regval |= of_property_read_bool(np, "atmel,fast-startup-acc") ?
+				AT91_PMC_ACC_CE : 0;
+
+	regmap_write(regmap, AT91_PMC_FSMR, regval);
+
+	regmap_write(regmap, AT91_PMC_FSPR, 0);
+
+	of_node_put(np);
+}
+
 static const struct of_device_id atmel_pmc_ids[] = {
 	{ .compatible = "atmel,at91rm9200-pmc"  },
 	{ .compatible = "atmel,at91sam9260-pmc" },
@@ -439,6 +497,8 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 	if (pm_idle)
 		arm_pm_idle = pm_idle;
 
+	at91_pmc_fast_startup_init();
+
 	at91_pm_sram_init();
 
 	if (at91_suspend_sram_fn)
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index b80b98b..6c1855b 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -154,6 +154,38 @@
 #define		AT91_PMC_CFDEV		(1 << 18)		/* Clock Failure Detector Event [some SAM9] */
 #define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
+#define AT91_PMC_FSMR		0x70			/* Fast Startup Mode Register */
+#define		AT91_PMC_FSTT0		(1 << 0)		/* Fast Startup from WKUP Pin Enable */
+#define		AT91_PMC_FSTT1		(1 << 1)		/* Fast Startup from Security Module Enable */
+#define		AT91_PMC_FSTT2		(1 << 2)		/* Fast Startup from PIOBU0 Input Enable */
+#define		AT91_PMC_FSTT3		(1 << 3)		/* Fast Startup from PIOBU1 Input Enable */
+#define		AT91_PMC_FSTT4		(1 << 4)		/* Fast Startup from PIOBU2 Input Enable */
+#define		AT91_PMC_FSTT5		(1 << 5)		/* Fast Startup from PIOBU3 Input Enable */
+#define		AT91_PMC_FSTT6		(1 << 6)		/* Fast Startup from PIOBU4 Input Enable */
+#define		AT91_PMC_FSTT7		(1 << 7)		/* Fast Startup from PIOBU5 Input Enable */
+#define		AT91_PMC_FSTT8		(1 << 8)		/* Fast Startup from PIOBU6 Input Enable */
+#define		AT91_PMC_FSTT9		(1 << 9)		/* Fast Startup from PIOBU7 Input Enable */
+#define		AT91_PMC_FSTT10		(1 << 10)		/* Fast Startup from GMAC Wake-up On LAN Enable */
+#define		AT91_PMC_RTCAL		(1 << 17)		/* Fast Startup from RTC Alarm Enable */
+#define		AT91_PMC_USBAL		(1 << 18)		/* Fast Startup from USB Resume Enable */
+#define		AT91_PMC_SDMMC_CD	(1 << 19)		/* Fast Startup from SDMMC Card Detect Enable */
+#define		AT91_PMC_LPM		(1 << 20)		/* Low-power Mode */
+#define		AT91_PMC_RXLP_MCE	(1 << 24)		/* Fast Startup from Backup UART Receive Match Condition Enable */
+#define		AT91_PMC_ACC_CE		(1 << 25)		/* Fast Startup from Analog Comparator Controller Comparison Enable*/
+
+#define AT91_PMC_FSPR		0x74			/* Fast Startup Polarity Register */
+#define		AT91_PMC_FSTP0		(1 << 0)		/* WKUP Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP1		(1 << 1)		/* Security Module Polarity for Fast Startup */
+#define		AT91_PMC_FSTP2		(1 << 2)		/* PIOBU0 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP3		(1 << 3)		/* PIOBU1 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP4		(1 << 4)		/* PIOBU2 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP5		(1 << 5)		/* PIOBU3 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP6		(1 << 6)		/* PIOBU4 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP7		(1 << 7)		/* PIOBU5 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP8		(1 << 8)		/* PIOBU6 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP9		(1 << 9)		/* PIOBU7 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP10		(1 << 10)		/* GMAC Wake-up On LAN Polarity for Fast Startup */
+
 #define AT91_PMC_PLLICPR	0x80			/* PLL Charge Pump Current Register */
 
 #define AT91_PMC_PROT		0xe4			/* Write Protect Mode Register [some SAM9] */
-- 
1.7.9.5
