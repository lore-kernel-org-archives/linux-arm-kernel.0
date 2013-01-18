From: avinashphilip@ti.com (Philip Avinash)
Date: Fri, 18 Jan 2013 12:11:35 +0530
Subject: [PATCH 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
In-Reply-To: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1358491295-4022-4-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NAND flash connected in am335x-evm on GPMC controller. This patch adds
device tree node in am335x-evm with GPMC controller timing for NAND flash
interface, NAND partition table, ECC scheme, elm handle id, pin-mux
setup.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   98 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..1c6b1a8 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -26,7 +26,8 @@
 
 	am33xx_pinmux: pinmux at 44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
+		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0
+			&nandflash_pins_s0>;
 
 		matrix_keypad_s0: matrix_keypad_s0 {
 			pinctrl-single,pins = <
@@ -44,6 +45,26 @@
 				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
 			>;
 		};
+
+		nandflash_pins_s0: nandflash_pins_s0 {
+			pinctrl-single,pins = <
+				0x0 0x30	/* gpmc_ad0.gpmc_ad0, INPUT | PULLUP | MODE0 */
+				0x4 0x30	/* gpmc_ad1.gpmc_ad1, INPUT | PULLUP | MODE0 */
+				0x8 0x30	/* gpmc_ad2.gpmc_ad2, INPUT | PULLUP | MODE0 */
+				0xc 0x30	/* gpmc_ad3.gpmc_ad3, INPUT | PULLUP | MODE0 */
+				0x10 0x30	/* gpmc_ad4.gpmc_ad4, INPUT | PULLUP | MODE0 */
+				0x14 0x30	/* gpmc_ad5.gpmc_ad5, INPUT | PULLUP | MODE0 */
+				0x18 0x30	/* gpmc_ad6.gpmc_ad6, INPUT | PULLUP | MODE0 */
+				0x1c 0x30	/* gpmc_ad7.gpmc_ad7, INPUT | PULLUP | MODE0 */
+				0x70 0x30	/* gpmc_wait0.gpmc_wait0, INPUT | PULLUP | MODE0 */
+				0x74 0x37	/* gpmc_wpn.gpio0_30, INPUT | PULLUP | MODE7 */
+				0x7c 0x8	/* gpmc_csn0.gpmc_csn0,  PULL DISA */
+				0x90 0x8	/* gpmc_advn_ale.gpmc_advn_ale, PULL DISA */
+				0x94 0x8	/* gpmc_oen_ren.gpmc_oen_ren, PULL DISA */
+				0x98 0x8	/* gpmc_wen.gpmc_wen, PULL DISA */
+				0x9c 0x8	/* gpmc_be0n_cle.gpmc_be0n_cle, PULL DISA */
+			>;
+		};
 	};
 
 	ocp {
@@ -102,6 +123,81 @@
 				reg = <0x48>;
 			};
 		};
+
+		elm: elm at 48080000 {
+			status = "okay";
+		};
+
+		gpmc: gpmc at 50000000 {
+			status = "okay";
+			ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+
+			nand at 0,0 {
+				reg = <0 0 0>; /* CS0, offset 0 */
+				nand-bus-width = <8>;
+				ti,nand-ecc-opt = "bch8";
+
+				gpmc,sync-clk = <0>;
+				gpmc,cs-on = <0>;
+				gpmc,cs-rd-off = <44>;
+				gpmc,cs-wr-off = <44>;
+				gpmc,adv-on = <6>;
+				gpmc,adv-rd-off = <34>;
+				gpmc,adv-wr-off = <44>;
+				gpmc,we-off = <40>;
+				gpmc,oe-off = <54>;
+				gpmc,access = <64>;
+				gpmc,rd-cycle = <82>;
+				gpmc,wr-cycle = <82>;
+				gpmc,wr-access = <40>;
+				gpmc,wr-data-mux-bus = <0>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				elm_id = <&elm>;
+
+				/* MTD partition table */
+				partition at 0 {
+					label = "SPL1";
+					reg = <0x00000000 0x000020000>;
+				};
+
+				partition at 1 {
+					label = "SPL2";
+					reg = <0x00020000 0x00020000>;
+				};
+
+				partition at 2 {
+					label = "SPL3";
+					reg = <0x00040000 0x00020000>;
+				};
+
+				partition at 3 {
+					label = "SPL4";
+					reg = <0x00060000 0x00020000>;
+				};
+
+				partition at 4 {
+					label = "U-boot";
+					reg = <0x00080000 0x001e0000>;
+				};
+
+				partition at 5 {
+					label = "environment";
+					reg = <0x00260000 0x00020000>;
+				};
+
+				partition at 6 {
+					label = "Kernel";
+					reg = <0x00280000 0x00500000>;
+				};
+
+				partition at 7 {
+					label = "File-System";
+					reg = <0x00780000 0x0F880000>;
+				};
+			};
+		};
 	};
 
 	vbat: fixedregulator at 0 {
-- 
1.7.9.5
