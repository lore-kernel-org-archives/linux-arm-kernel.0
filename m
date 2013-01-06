From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:38 +0100
Subject: [PATCH 05/11] ARM: Kirkwood: Use fixed-regulator instead of board
 gpio call
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the change to a DT based pinctrl/gpio driver, using gpio API
calls in board-*.c files no longer works, a dereferenced NULL pointer
exception occurs instead. By converting the GPIO code into a
fixed-regulator which gets probed later once pinctrl/gpio is
available, we avoid the exception.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Peter <s.peter@mplch>
---
 arch/arm/boot/dts/kirkwood-topkick.dts     |   17 +++++++++++++++++
 arch/arm/mach-kirkwood/board-usi_topkick.c |    4 ----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index c0de5a7..cd15452 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -82,4 +82,21 @@
 			gpios = <&gpio1 16 1>;
 		};
 	};
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
+			gpio = <&gpio1 4 0>;
+		};
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-usi_topkick.c b/arch/arm/mach-kirkwood/board-usi_topkick.c
index 15e69fc..23d2dd1 100644
--- a/arch/arm/mach-kirkwood/board-usi_topkick.c
+++ b/arch/arm/mach-kirkwood/board-usi_topkick.c
@@ -64,8 +64,6 @@ static unsigned int topkick_mpp_config[] __initdata = {
 	0
 };
 
-#define TOPKICK_SATA0_PWR_ENABLE 36
-
 void __init usi_topkick_init(void)
 {
 	/*
@@ -73,8 +71,6 @@ void __init usi_topkick_init(void)
 	 */
 	kirkwood_mpp_conf(topkick_mpp_config);
 
-	/* SATA0 power enable */
-	gpio_set_value(TOPKICK_SATA0_PWR_ENABLE, 1);
 
 	kirkwood_ge00_init(&topkick_ge00_data);
 	kirkwood_sdio_init(&topkick_mvsdio_data);
-- 
1.7.10.4
