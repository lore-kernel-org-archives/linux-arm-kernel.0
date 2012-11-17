From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:46:13 +0100
Subject: [PATCH 4/5] ARM: Kirkwood: Convert GoFlexNet to use regulators
In-Reply-To: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
References: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353163574-6362-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control the power to USB using a fixed regulator.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Josh Coombs <josh.coombs@gmail.com>
---
 arch/arm/boot/dts/kirkwood-goflexnet.dts |   17 +++++++++++++++++
 arch/arm/mach-kirkwood/board-goflexnet.c |    4 ----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index 7c8238f..84de887 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -96,4 +96,21 @@
 			gpios = <&gpio1 9 0>;
 		};
 	};
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
+			gpio = <&gpio0 29 0>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-goflexnet.c b/arch/arm/mach-kirkwood/board-goflexnet.c
index 001ca8c..7257a35 100644
--- a/arch/arm/mach-kirkwood/board-goflexnet.c
+++ b/arch/arm/mach-kirkwood/board-goflexnet.c
@@ -26,7 +26,6 @@
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -62,9 +61,6 @@ void __init goflexnet_init(void)
 	 */
 	kirkwood_mpp_conf(goflexnet_mpp_config);
 
-	if (gpio_request(29, "USB Power Enable") != 0 ||
-	    gpio_direction_output(29, 1) != 0)
-		pr_err("can't setup GPIO 29 (USB Power Enable)\n");
 	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&goflexnet_ge00_data);
-- 
1.7.10.4
