From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:46:14 +0100
Subject: [PATCH 5/5] ARM: Kirkwood: Convert LSXL to use regulators
In-Reply-To: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
References: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353163574-6362-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control the power to USB and HDD using a fixed regulator.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-lsxl.c  |    8 --------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 8fea375..65a8c52 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -94,4 +94,33 @@
 			gpios = <&gpio1 16 1>;
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 11 0>;
+		};
+		hdd_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "HDD Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 10 0>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
index 83d8975..b9845c0 100644
--- a/arch/arm/mach-kirkwood/board-lsxl.c
+++ b/arch/arm/mach-kirkwood/board-lsxl.c
@@ -19,7 +19,6 @@
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/gpio.h>
 #include <linux/gpio-fan.h>
 #include <linux/input.h>
 #include <asm/mach-types.h>
@@ -111,9 +110,6 @@ static void lsxl_power_off(void)
 	kirkwood_restart('h', NULL);
 }
 
-#define LSXL_GPIO_HDD_POWER 10
-#define LSXL_GPIO_USB_POWER 11
-
 void __init lsxl_init(void)
 {
 	/*
@@ -121,10 +117,6 @@ void __init lsxl_init(void)
 	 */
 	kirkwood_mpp_conf(lsxl_mpp_config);
 
-	/* usb and sata power on */
-	gpio_set_value(LSXL_GPIO_USB_POWER, 1);
-	gpio_set_value(LSXL_GPIO_HDD_POWER, 1);
-
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&lsxl_ge00_data);
 	kirkwood_ge01_init(&lsxl_ge01_data);
-- 
1.7.10.4
