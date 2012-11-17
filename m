From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:46:11 +0100
Subject: [PATCH 2/5] ARM: Kirkwood: Convert DNSKW to use regulators
In-Reply-To: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
References: <1353163574-6362-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353163574-6362-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control the power to SATA0 and SATA1 using a fixed regulator.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dnskw.c  |    4 ----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 22aa07a..b6aeb4f 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -81,4 +81,33 @@
 			};
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata0_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA0 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 7 0>;
+		};
+		sata1_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "SATA1 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 8 0>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 549369e..653bbbe 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -76,10 +76,6 @@ void __init dnskw_init(void)
 	kirkwood_ehci_init();
 	kirkwood_ge00_init(&dnskw_ge00_data);
 
-	/* Ensure power is supplied to both HDDs */
-	dnskw_gpio_register(39, "dnskw:power:sata0", 1);
-	dnskw_gpio_register(40, "dnskw:power:sata1", 1);
-
 	/* Set NAS to turn back on after a power failure */
 	dnskw_gpio_register(37, "dnskw:power:recover", 1);
 }
-- 
1.7.10.4
