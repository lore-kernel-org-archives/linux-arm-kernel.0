From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Jul 2012 16:22:42 +0200
Subject: [PATCH v2 09/12] ARM: Kirkwood: DTify the watchdog timer.
In-Reply-To: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Message-ID: <1341325365-21393-10-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support to the Orion watchdog timer, and enable its
use in the kirkwood devices using device tree.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/watchdog/marvel.txt |   14 ++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                       |    6 ++++++
 arch/arm/mach-kirkwood/board-dt.c                     |    2 +-
 drivers/watchdog/orion_wdt.c                          |    8 ++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvel.txt

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
new file mode 100644
index 0000000..0b2503a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -0,0 +1,14 @@
+* Marvell Orion Watchdog Time
+
+Required Properties:
+
+- Compatibility : "marvell,orion-wdt"
+- reg		: Address of the timer registers
+
+Example:
+
+	wdt at 20300 {
+		compatible = "marvell,orion-wdt";
+		reg = <0x20300 0x28>;
+		status = "okay";
+	};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index c8bc122..be8e127 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -69,6 +69,12 @@
 			status = "disabled";
 		};
 
+		wdt at 20300 {
+			compatible = "marvell,orion-wdt";
+			reg = <0x20300 0x28>;
+			status = "okay";
+		};
+
 		nand at 3000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index b7cd6d2..73e75cf 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -30,6 +30,7 @@ struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
 	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
 		       NULL),
+	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
 	{},
 };
 
@@ -55,7 +56,6 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_clk_init();
 
 	/* internal devices that every board has */
-	kirkwood_wdt_init();
 	kirkwood_xor0_init();
 	kirkwood_xor1_init();
 	kirkwood_crypto_init();
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0f57369..1531e02 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <mach/bridge-regs.h>
 
 /*
@@ -295,6 +296,12 @@ static void orion_wdt_shutdown(struct platform_device *pdev)
 		orion_wdt_disable();
 }
 
+static const struct of_device_id orion_wdt_of_match_table[] __devinitdata = {
+	{ .compatible = "marvell,orion-wdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
+
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
 	.remove		= __devexit_p(orion_wdt_remove),
@@ -302,6 +309,7 @@ static struct platform_driver orion_wdt_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "orion_wdt",
+		.of_match_table = of_match_ptr(orion_wdt_of_match_table),
 	},
 };
 
-- 
1.7.10
