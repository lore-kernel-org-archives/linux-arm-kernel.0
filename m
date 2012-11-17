From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:46:12 +0100
Subject: [PATCH 3/5] ARM: Kirkwood: Convert Dockstar to use regulators
In-Reply-To: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
References: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353163574-6362-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control the power to USB using a fixed regulator.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-dockstar.dts |   17 +++++++++++++++++
 arch/arm/mach-kirkwood/board-dockstar.c |    4 ----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 08a5824..c0fbfdc 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -54,4 +54,21 @@
 			gpios = <&gpio1 15 1>;
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
diff --git a/arch/arm/mach-kirkwood/board-dockstar.c b/arch/arm/mach-kirkwood/board-dockstar.c
index f2fbb02..5c60fa1 100644
--- a/arch/arm/mach-kirkwood/board-dockstar.c
+++ b/arch/arm/mach-kirkwood/board-dockstar.c
@@ -24,7 +24,6 @@
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -52,9 +51,6 @@ void __init dockstar_dt_init(void)
 	 */
 	kirkwood_mpp_conf(dockstar_mpp_config);
 
-	if (gpio_request(29, "USB Power Enable") != 0 ||
-	    gpio_direction_output(29, 1) != 0)
-		pr_err("can't setup GPIO 29 (USB Power Enable)\n");
 	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&dockstar_ge00_data);
-- 
1.7.10.4
