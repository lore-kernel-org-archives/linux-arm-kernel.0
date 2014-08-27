From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 Aug 2014 13:42:18 +0100
Subject: [PATCH 3/9] ARM: sti: Add BCH (NAND Flash) Controller support for
 STiH41x (Orly) SoCs
In-Reply-To: <1409143344-22458-1-git-send-email-lee.jones@linaro.org>
References: <1409143344-22458-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409143344-22458-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide device information and flash layout for the NAND Micron
MT29F8G08ABABAWP chip found on the STM B2020 Development Board.

Reviewed-By: Pekon Gupta <pekon@pek-sem.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih41x-b2020.dtsi | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index d8a8429..553ee1f 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -74,5 +74,43 @@
 
 			pinctrl-0	= <&pinctrl_rgmii1>;
 		};
+
+		nand at fe901000 {
+			compatible = "st,nand-bch";
+			reg = <0xfe901000 0x1000>, <0xfef00000 0x107c>;
+			reg-names = "emi_nand", "emiss";
+			interrupts = <0 139 0x0>;
+			interrupt-names = "nand_irq";
+			status = "disabled";
+
+			/*
+			 * Micron MT29F8G08ABABAWP:
+			 *  - Size = 8Gib(1GiB); Page = 4096+224; Block = 512KiB
+			 *  - ECC = 4-bit/540B min
+			 *  - ONFI 2.1 (timing parameters retrieved during probe)
+			 */
+			bank0 {
+				nand-on-flash-bbt;
+				st,nand-csn		= <0>;
+				st,nand-timing-relax	= <0>;
+
+				partitions {
+					#address-cells	= <1>;
+					#size-cells	= <1>;
+
+					partition at 0 {
+						/* 8MB */
+						label = "NANDFlash1";
+						reg = <0x00000000 0x00800000>;
+					};
+
+					partition at 800000 {
+						/* 1GB - 8MB */
+						label = "NANDFlash2";
+						reg = <0x00800000 0x1f000000>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
1.9.1
