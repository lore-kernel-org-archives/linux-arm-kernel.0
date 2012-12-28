From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 15:08:48 +0100
Subject: [PATCH 1/3] ARM: Kirkwood: Convert NSA310 to DT based regulators.
In-Reply-To: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
References: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
Message-ID: <1356703730-4926-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-nsa310.dts |   17 +++++++++++++++++
 arch/arm/mach-kirkwood/board-nsa310.c |    4 ----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 5509f96..2dc1d09 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -141,4 +141,21 @@
 			gpios = <&gpio1 8 0>;
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb0_power_off: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB Power Off";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio0 21 0>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
index f58d2e1..d04184d 100644
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -19,7 +19,6 @@
 #include "common.h"
 #include "mpp.h"
 
-#define NSA310_GPIO_USB_POWER_OFF	21
 #define NSA310_GPIO_POWER_OFF		48
 
 static unsigned int nsa310_mpp_config[] __initdata = {
@@ -72,9 +71,6 @@ static void __init nsa310_gpio_init(void)
 				  "Power Off");
 	if (!err)
 		pm_power_off = nsa310_power_off;
-
-	nsa310_gpio_request(NSA310_GPIO_USB_POWER_OFF, GPIOF_OUT_INIT_LOW,
-			    "USB Power Off");
 }
 
 void __init nsa310_init(void)
-- 
1.7.10.4
