From: anilkumar.v@ti.com (Kumar, Anil)
Date: Fri, 7 Dec 2012 15:57:31 +0530
Subject: [PATCH 2/2] ARM: davinci: da850: add NAND driver entries
In-Reply-To: <1354876051-25938-1-git-send-email-anilkumar.v@ti.com>
References: <1354876051-25938-1-git-send-email-anilkumar.v@ti.com>
Message-ID: <1354876051-25938-3-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND driver entries to export NAND functionality on da850 EVM and
NAND pinctrl node to do pin mux according to pinctrl-single driver.

Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
---
Depend on link: 
http://www.spinics.net/lists/linux-doc/msg07535.html

:100644 100644 8cac9d2... 05b558a... M	arch/arm/boot/dts/da850-evm.dts
:100644 100644 94471bc... f198ee8... M	arch/arm/boot/dts/da850.dtsi
 arch/arm/boot/dts/da850-evm.dts |   19 +++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi    |   13 +++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 8cac9d2..05b558a 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -28,4 +28,23 @@
 			status = "okay";
 		};
 	};
+	nand_cs3 at 62000000 {
+		status = "okay";
+	};
+};
+&pmx_core{
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&nand_cs3_pins
+	>;
+
+	nand_cs3_pins: pinmux_nand_pins {
+		pinctrl-single,bits = <
+			0x1c 0x00110000  0x00ff0000     /* EMA_OE, EMA_WE */
+			0x1c 0x00000110  0x00000ff0     /* EMA_CS[4],EMA_CS[3]*/
+			0x24 0x11111111  0xffffffff     /* EMA_D[0], EMA_D[1], EMA_D[2], EMA_D[3],
+							   EMA_D[4], EMA_D[5], EMA_D[6], EMA_D[7] */
+			0x30 0x01100000  0x0ff00000     /* EMA_A[1], EMA_A[2] */
+		>;
+	};
 };
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 94471bc..f198ee8 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -67,4 +67,17 @@
 			status = "disabled";
 		};
 	};
+	nand_cs3 at 62000000 {
+		compatible = "ti,davinci-nand";
+		reg = <0x62000000 0x807ff
+			0x68000000 0x8000>;
+		ti,davinci-chipselect = <1>;
+		ti,davinci-mask-ale = <0>;
+		ti,davinci-mask-cle = <0>;
+		ti,davinci-mask-chipsel = <0>;
+		ti,davinci-ecc-mode = "hw";
+		ti,davinci-ecc-bits = <4>;
+		ti,davinci-nand-use-bbt;
+		status = "disabled";
+	};
 };
-- 
1.7.4.1
