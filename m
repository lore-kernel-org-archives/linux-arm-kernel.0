From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 14:36:28 +0100
Subject: [PATCH 6/9] ARM: vexpress: Add fixed regulator for SMSC
In-Reply-To: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1342013791-19516-7-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMSC driver requires "vdd33a" and "vddvario" regulator supplies now.

Add fixed regulator describing 3V3 power line (in both motherboard's
Device Trees and the non-DT code) and force fixed regulator config
option if regulators framework is enabled.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |   10 ++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi     |   10 ++++++++++
 arch/arm/mach-vexpress/v2m.c            |   10 ++++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6374a08..cb15fca 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -318,6 +318,7 @@ config ARCH_VEXPRESS
 	select NO_IOPORT
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 142c72a..d8a827b 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -55,6 +55,8 @@
 			reg-io-width = <4>;
 			smsc,irq-active-high;
 			smsc,irq-push-pull;
+			vdd33a-supply = <&v2m_fixed_3v3>;
+			vddvario-supply = <&v2m_fixed_3v3>;
 		};
 
 		usb at 2,03000000 {
@@ -198,5 +200,13 @@
 				interrupts = <14>;
 			};
 		};
+
+		v2m_fixed_3v3: fixedregulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index 47ee307..dba53fd 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -54,6 +54,8 @@
 			reg-io-width = <4>;
 			smsc,irq-active-high;
 			smsc,irq-push-pull;
+			vdd33a-supply = <&v2m_fixed_3v3>;
+			vddvario-supply = <&v2m_fixed_3v3>;
 		};
 
 		usb at 3,03000000 {
@@ -197,5 +199,13 @@
 				interrupts = <14>;
 			};
 		};
+
+		v2m_fixed_3v3: fixedregulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
 	};
 };
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 8a64402..bf7832d 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -18,6 +18,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/mtd/physmap.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/arch_timer.h>
 #include <asm/mach-types.h>
@@ -199,6 +201,11 @@ static struct platform_device v2m_eth_device = {
 	.dev.platform_data = &v2m_eth_config,
 };
 
+static struct regulator_consumer_supply v2m_eth_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 static struct resource v2m_usb_resources[] = {
 	{
 		.start	= V2M_ISP1761,
@@ -503,6 +510,9 @@ static void __init v2m_init(void)
 {
 	int i;
 
+	regulator_register_fixed(0, v2m_eth_supplies,
+			ARRAY_SIZE(v2m_eth_supplies));
+
 	platform_device_register(&v2m_pcie_i2c_device);
 	platform_device_register(&v2m_ddc_i2c_device);
 	platform_device_register(&v2m_flash_device);
-- 
1.7.9.5
