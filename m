From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  2 Mar 2012 20:54:04 +0100
Subject: [PATCH 2/6] ARM: at91: add pmc DT support
In-Reply-To: <20120302192844.GB21255@game.jcrosoft.org>
References: <20120302192844.GB21255@game.jcrosoft.org>
Message-ID: <1330718048-9314-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specified the main Oscillator via clock binding.
This will allow to do not hardcode it anymore in the DT board at 12MHz.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/arm/atmel-pmc.txt          |   11 ++++
 arch/arm/boot/dts/at91sam9g20.dtsi                 |    5 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 ++
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   11 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 ++
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   11 ++++
 arch/arm/boot/dts/usb_a9g20.dts                    |   11 ++++
 arch/arm/mach-at91/clock.c                         |   56 ++++++++++++++++++--
 arch/arm/mach-at91/generic.h                       |    1 +
 arch/arm/mach-at91/setup.c                         |    3 +-
 10 files changed, 112 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
new file mode 100644
index 0000000..389bed5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
@@ -0,0 +1,11 @@
+* Power Management Controller (PMC)
+
+Required properties:
+- compatible: Should be "atmel,at91rm9200-pmc"
+- reg: Should contain PMC registers location and length
+
+Examples:
+	pmc: pmc at fffffc00 {
+		compatible = "atmel,at91rm9200-pmc";
+		reg = <0xfffffc00 0x100>;
+	};
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index c030703..ee94828 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -59,6 +59,11 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+			pmc: pmc at fffffc00 {
+				compatible = "atmel,at91rm9200-pmc";
+				reg = <0xfffffc00 0x100>;
+			};
+
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 4b54424..dfb71d5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -60,6 +60,11 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+			pmc: pmc at fffffc00 {
+				compatible = "atmel,at91rm9200-pmc";
+				reg = <0xfffffc00 0x100>;
+			};
+
 			pit: timer at fffffd30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 4b1eb36..7147588 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -21,6 +21,17 @@
 		reg = <0x70000000 0x4000000>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+	};
+
 	ahb {
 		apb {
 			dbgu: serial at ffffee00 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index ac3c96c..a7d7107 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -58,6 +58,11 @@
 				reg = <0xfffff000 0x200>;
 			};
 
+			pmc: pmc at fffffc00 {
+				compatible = "atmel,at91rm9200-pmc";
+				reg = <0xfffffc00 0x100>;
+			};
+
 			pit: timer at fffffe30 {
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 3f84585..03116b2 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -12,6 +12,17 @@
 		reg = <0x20000000 0x8000000>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+	};
+
 	ahb {
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index e4a732f..390c481 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -20,6 +20,17 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+	};
+
 	ahb {
 		apb {
 			dbgu: serial at fffff200 {
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index be51ca7..a0f4d74 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 
 #include <mach/hardware.h>
 #include <mach/at91_pmc.h>
@@ -671,16 +672,12 @@ static void __init at91_upll_usbfs_clock_init(unsigned long main_clock)
 	uhpck.rate_hz /= 1 + ((at91_pmc_read(AT91_PMC_USB) & AT91_PMC_OHCIUSBDIV) >> 8);
 }
 
-int __init at91_clock_init(unsigned long main_clock)
+static int __init at91_pmc_init(unsigned long main_clock)
 {
 	unsigned tmp, freq, mckr;
 	int i;
 	int pll_overclock = false;
 
-	at91_pmc_base = ioremap(AT91_PMC, 256);
-	if (!at91_pmc_base)
-		panic("Impossible to ioremap AT91_PMC 0x%x\n", AT91_PMC);
-
 	/*
 	 * When the bootloader initialized the main oscillator correctly,
 	 * there's no problem using the cycle counter.  But if it didn't,
@@ -802,6 +799,55 @@ int __init at91_clock_init(unsigned long main_clock)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static struct of_device_id pmc_ids[] = {
+	{ .compatible = "atmel,at91rm9200-pmc" },
+	{ /*sentinel*/ }
+};
+
+static struct of_device_id osc_ids[] = {
+	{ .compatible = "atmel,osc" },
+	{ /*sentinel*/ }
+};
+
+int __init at91_dt_clock_init(void)
+{
+	struct device_node *np;
+	u32 main_clock = 0;
+
+	np = of_find_matching_node(NULL, pmc_ids);
+	if (!np)
+		panic("unable to find compatible pmc node in dtb\n");
+
+	at91_pmc_base = of_iomap(np, 0);
+	if (!at91_pmc_base)
+		panic("unable to map pmc cpu registers\n");
+
+	of_node_put(np);
+
+	/* retrieve the freqency of fixed clocks from device tree */
+	np = of_find_matching_node(NULL, osc_ids);
+	if (np) {
+		u32 rate;
+		if (!of_property_read_u32(np, "clock-frequency", &rate))
+			main_clock = rate;
+	}
+
+	of_node_put(np);
+
+	return at91_pmc_init(main_clock);
+}
+#endif
+
+int __init at91_clock_init(unsigned long main_clock)
+{
+	at91_pmc_base = ioremap(AT91_PMC, 256);
+	if (!at91_pmc_base)
+		panic("Impossible to ioremap AT91_PMC 0x%x\n", AT91_PMC);
+
+	return at91_pmc_init(main_clock);
+}
+
 /*
  * Several unused clocks may be active.  Turn them off.
  */
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index d5f5083..dd9b346 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -53,6 +53,7 @@ extern void __init at91sam9rl_set_console_clock(int id);
 extern void __init at91sam9g45_set_console_clock(int id);
 #ifdef CONFIG_AT91_PMC_UNIT
 extern int __init at91_clock_init(unsigned long main_clock);
+extern int __init at91_dt_clock_init(void);
 #else
 static int inline at91_clock_init(unsigned long main_clock) { return 0; }
 #endif
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index c0bd5a6..d7abc25 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -292,9 +292,8 @@ void __init at91_dt_initialize(void)
 	/* temporary until have the ramc binding*/
 	at91_boot_soc.ioremap_registers();
 
-	/* temporary until have the pmc binding */
 	/* Init clock subsystem */
-	at91_clock_init(12000000);
+	at91_dt_clock_init();
 
 	/* Register the processor-specific clocks */
 	at91_boot_soc.register_clocks();
-- 
1.7.7
