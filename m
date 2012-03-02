From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  2 Mar 2012 20:54:08 +0100
Subject: [PATCH 6/6] ARM: at91: add Shutdown Controller (SHDWC) DT support
In-Reply-To: <20120302192844.GB21255@game.jcrosoft.org>
References: <20120302192844.GB21255@game.jcrosoft.org>
Message-ID: <1330718048-9314-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a string to specific the wakeup mode to make it more readable.

Add the Real-time Clock Wake-up support too for sam9g45 and sam9x5.
Add AT91_SHDW_CPTWK0_MAX to specific the Max of the Wakeup Counter.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/arm/atmel-at91.txt         |   29 +++++++
 arch/arm/boot/dts/at91sam9g20.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +
 arch/arm/mach-at91/include/mach/at91_shdwc.h       |    4 +-
 arch/arm/mach-at91/setup.c                         |   89 ++++++++++++++++++++
 6 files changed, 136 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 1f87820..ecc81e3 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -61,3 +61,32 @@ Examples:
 		reg = <0xffffe400 0x200
 		       0xffffe600 0x200>;
 	};
+
+SHDWC Shutdown Controller
+
+required properties:
+- compatible: Should be "atmel,<chip>-shdwc".
+  <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".
+- reg: Should contain registers location and length
+
+optional properties:
+- atmel,wakeup-mode: String, operation mode of the wakeup mode.
+  Supported values are: "none", "high", "low", "any".
+- atmel,wakeup-counter: Counter on Wake-up 0 (between 0x0 and 0xf).
+
+optional at91sam9260 properties:
+- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
+
+optional at91sam9rl properties:
+- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
+- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
+
+optional at91sam9x5 properties:
+- atmel,wakeup-rtc-timer: boolean to enable Real-time Clock Wake-up.
+
+Example:
+
+	rstc at fffffd00 {
+		compatible = "atmel,at91sam9260-rstc";
+		reg = <0xfffffd00 0x10>;
+	};
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 573ac5a..62c85ac 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -74,6 +74,11 @@
 				reg = <0xfffffd00 0x10>;
 			};
 
+			shdwc at fffffd10 {
+				compatible = "atmel,at91sam9260-shdwc";
+				reg = <0xfffffd10 0x10>;
+			};
+
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 6da07a9..e655d01 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -83,6 +83,11 @@
 			};
 
 
+			shdwc at fffffd10 {
+				compatible = "atmel,at91sam9rl-shdwc";
+				reg = <0xfffffd10 0x10>;
+			};
+
 			tcb0: timer at fff7c000 {
 				compatible = "atmel,at91rm9200-tcb";
 				reg = <0xfff7c000 0x100>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 09bc806..8a68f33 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -73,6 +73,11 @@
 				reg = <0xfffffe00 0x10>;
 			};
 
+			shdwc at fffffe10 {
+				compatible = "atmel,at91sam9x5-shdwc";
+				reg = <0xfffffe10 0x10>;
+			};
+
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
diff --git a/arch/arm/mach-at91/include/mach/at91_shdwc.h b/arch/arm/mach-at91/include/mach/at91_shdwc.h
index 1d4fe82..60478ea 100644
--- a/arch/arm/mach-at91/include/mach/at91_shdwc.h
+++ b/arch/arm/mach-at91/include/mach/at91_shdwc.h
@@ -36,9 +36,11 @@ extern void __iomem *at91_shdwc_base;
 #define			AT91_SHDW_WKMODE0_HIGH		1
 #define			AT91_SHDW_WKMODE0_LOW		2
 #define			AT91_SHDW_WKMODE0_ANYLEVEL	3
-#define		AT91_SHDW_CPTWK0	(0xf << 4)		/* Counter On Wake Up 0 */
+#define		AT91_SHDW_CPTWK0_MAX	0xf			/* Maximum Counter On Wake Up 0 */
+#define		AT91_SHDW_CPTWK0	(AT91_SHDW_CPTWK0_MAX << 4) /* Counter On Wake Up 0 */
 #define			AT91_SHDW_CPTWK0_(x)	((x) << 4)
 #define		AT91_SHDW_RTTWKEN	(1   << 16)		/* Real Time Timer Wake-up Enable */
+#define		AT91_SHDW_RTCWKEN	(1   << 17)		/* Real Time Clock Wake-up Enable */
 
 #define AT91_SHDW_SR		0x08			/* Shut Down Status Register */
 #define		AT91_SHDW_WAKEUP0	(1 <<  0)		/* Wake-up 0 Status */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index f86450d..9206a67 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -338,10 +338,99 @@ static void at91_dt_ramc(void)
 	of_node_put(np);
 }
 
+static struct of_device_id shdwc_ids[] = {
+	{ .compatible = "atmel,at91sam9260-shdwc", },
+	{ .compatible = "atmel,at91sam9rl-shdwc", },
+	{ .compatible = "atmel,at91sam9x5-shdwc", },
+	{ /*sentinel*/ }
+};
+
+static const char *shdwc_wakeup_modes[] = {
+	[AT91_SHDW_WKMODE0_NONE]	= "none",
+	[AT91_SHDW_WKMODE0_HIGH]	= "high",
+	[AT91_SHDW_WKMODE0_LOW]		= "low",
+	[AT91_SHDW_WKMODE0_ANYLEVEL]	= "any",
+};
+
+const int at91_dtget_shdwc_wakeup_mode(struct device_node *np)
+{
+	const char *pm;
+	int err, i;
+
+	err = of_property_read_string(np, "atmel,wakeup-mode", &pm);
+	if (err < 0)
+		return AT91_SHDW_WKMODE0_ANYLEVEL;
+
+	for (i = 0; i < ARRAY_SIZE(shdwc_wakeup_modes); i++)
+		if (!strcasecmp(pm, shdwc_wakeup_modes[i]))
+			return i;
+
+	return -ENODEV;
+}
+
+static void at91_dt_shdwc(void)
+{
+	struct device_node *np;
+	int wakeup_mode;
+	bool have_rtt, have_rtc;
+	u32 reg;
+	u32 mode = 0;
+
+	np = of_find_matching_node(NULL, shdwc_ids);
+	if (!np) {
+		pr_debug("AT91: unable to find compatible shutdown (shdwc) conroller node in dtb\n");
+		return;
+	}
+
+	at91_shdwc_base = of_iomap(np, 0);
+	if (!at91_shdwc_base)
+		panic("AT91: unable to map shdwc cpu registers\n");
+
+	wakeup_mode = at91_dtget_shdwc_wakeup_mode(np);
+	if (wakeup_mode < 0) {
+		pr_warn("AT91: shdwc unknown wakeup mode\n");
+		goto end;
+	}
+
+	if (!of_property_read_u32(np, "atmel,wakeup-counter", &reg)) {
+		if (reg > AT91_SHDW_CPTWK0_MAX) {
+			pr_warn("AT91: shdwc wakeup conter 0x%x > 0x%x reduce it to 0x%x\n",
+				reg, AT91_SHDW_CPTWK0_MAX, AT91_SHDW_CPTWK0_MAX);
+			reg = AT91_SHDW_CPTWK0_MAX;
+		}
+		mode |= AT91_SHDW_CPTWK0_(reg);
+	}
+
+	if (of_device_is_compatible(np, "atmel,at91sam9x5-shdwc")) {
+		have_rtt = false;
+		have_rtc = true;
+	} else if (of_device_is_compatible(np, "atmel,at91sam9rl-shdwc")) {
+		have_rtt = true;
+		have_rtc = true;
+	} else {
+		have_rtt = true;
+		have_rtc = false;
+	}
+
+	if (have_rtc && of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
+			mode |= AT91_SHDW_RTCWKEN;
+
+	if (have_rtt && of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
+			mode |= AT91_SHDW_RTTWKEN;
+
+	at91_shdwc_write(AT91_SHDW_MR, wakeup_mode | mode);
+
+end:
+	pm_power_off = at91sam9_poweroff;
+
+	of_node_put(np);
+}
+
 void __init at91_dt_initialize(void)
 {
 	at91_dt_rstc();
 	at91_dt_ramc();
+	at91_dt_shdwc();
 
 	/* Init clock subsystem */
 	at91_dt_clock_init();
-- 
1.7.7
