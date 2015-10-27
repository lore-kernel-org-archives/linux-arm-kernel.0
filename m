From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 27 Oct 2015 14:14:57 +0200
Subject: [PATCH 3/6] ARM: OMAP2+: dts: cm-t335: add support for NAND flash
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1445948100-16446-4-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Add pinmux configuration for NAND specific GPMC pins.
Add description for GPMC controller. Add child node for NAND flash
including CM-T335 specific partition table to GPMC node.
Enable error-location module (ELM).

Acked-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 106 +++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 39df3d2..9d6117a 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -61,6 +61,41 @@
 		>;
 	};
 
+	nandflash_pins: pinmux_nandflash_pins {
+		pinctrl-single,pins = <
+			/* gpmc_ad0.gpmc_ad0 */
+			0x0 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad1.gpmc_ad1 */
+			0x4 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad2.gpmc_ad2 */
+			0x8 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad3.gpmc_ad3 */
+			0xc (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad4.gpmc_ad4 */
+			0x10 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad5.gpmc_ad5 */
+			0x14 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad6.gpmc_ad6 */
+			0x18 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_ad7.gpmc_ad7 */
+			0x1c (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_wait0.gpmc_wait0 */
+			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* gpmc_wpn.gpio0_30 */
+			0x74 (PIN_INPUT_PULLUP | MUX_MODE7)
+			/* gpmc_csn0.gpmc_csn0  */
+			0x7c (PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_advn_ale.gpmc_advn_ale */
+			0x90 (PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_oen_ren.gpmc_oen_ren */
+			0x94 (PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_wen.gpmc_wen */
+			0x98 (PIN_OUTPUT | MUX_MODE0)
+			/* gpmc_be0n_cle.gpmc_be0n_cle */
+			0x9c (PIN_OUTPUT | MUX_MODE0)
+		>;
+	};
+
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
 			/* uart0_rxd.uart0_rxd */
@@ -97,3 +132,74 @@
 	};
 };
 
+&gpmc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nandflash_pins>;
+	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	nand at 0,0 {
+		reg = <0 0 0>; /* CS0, offset 0 */
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id = <&elm>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		/* MTD partition table */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition at 0 {
+			label = "spl";
+			reg = <0x00000000 0x00200000>;
+		};
+		partition at 1 {
+			label = "uboot";
+			reg = <0x00200000 0x00100000>;
+		};
+		partition at 2 {
+			label = "uboot environment";
+			reg = <0x00300000 0x00100000>;
+		};
+		partition at 3 {
+			label = "dtb";
+			reg = <0x00400000 0x00100000>;
+		};
+		partition at 4 {
+			label = "splash";
+			reg = <0x00500000 0x00400000>;
+		};
+		partition at 5 {
+			label = "linux";
+			reg = <0x00900000 0x00600000>;
+		};
+		partition at 6 {
+			label = "rootfs";
+			reg = <0x00F00000 0>;
+		};
+	};
+};
+
+&elm {
+	status = "okay";
+};
+
-- 
2.6.0
