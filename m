From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 30 May 2014 13:38:04 +1000
Subject: linux-next: manual merge of the omap_dss2 tree with the arm-soc tree
Message-ID: <20140530133804.414f6d5c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

Today's linux-next merge of the omap_dss2 tree got a conflict in
arch/arm/boot/dts/am437x-gp-evm.dts between commit 99ffa6425f1b ("ARM:
dts: am437x-gp-evm: add support for parallel NAND flash") from the
arm-soc tree and commit 0186bec97131 ("ARM: dts: am437x-gp-evm: add LCD
data") from the omap_dss2 tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am437x-gp-evm.dts
index c25d15837ce9,3acccdf258e9..000000000000
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@@ -151,26 -193,46 +193,67 @@@
  		>;
  	};
  
 +	nand_flash_x8: nand_flash_x8 {
 +		pinctrl-single,pins = <
 +			0x26c(PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* spi2_cs0.gpio/eMMCorNANDsel */
 +			0x0  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
 +			0x4  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
 +			0x8  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
 +			0xc  (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
 +			0x10 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
 +			0x14 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
 +			0x18 (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
 +			0x1c (PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
 +			0x70 (PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
 +			0x74 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
 +			0x7c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
 +			0x90 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
 +			0x94 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
 +			0x98 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
 +			0x9c (PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 +		>;
 +	};
++
+ 	dss_pins: dss_pins {
+ 		pinctrl-single,pins = <
+ 			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+ 			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+ 			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+ 			0x02c (PIN_OUTPUT_PULLUP | MUX_MODE1)
+ 			0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+ 			0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+ 			0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
+ 			0x03c (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
+ 			0x0a0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+ 			0x0a4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0a8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0ac (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0b0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0b4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0b8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0bc (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0c0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0c4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0c8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0cc (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0d0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0d4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0d8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
+ 			0x0dc (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
+ 			0x0e0 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
+ 			0x0e4 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
+ 			0x0e8 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
+ 			0x0ec (PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+ 
+ 		>;
+ 	};
+ 
+ 	lcd_pins: lcd_pins {
+ 		pinctrl-single,pins = <
+ 			/* GPIO 5_8 to select LCD / HDMI */
+ 			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+ 		>;
+ 	};
  };
  
  &i2c0 {
@@@ -273,89 -330,16 +356,103 @@@
  	phy-mode = "rgmii";
  };
  
 +&elm {
 +	status = "okay";
 +};
 +
 +&gpmc {
 +	status = "okay";
 +	pinctrl-names = "default";
 +	pinctrl-0 = <&nand_flash_x8>;
 +	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
 +	nand at 0,0 {
 +		reg = <0 0 4>;		/* device IO registers */
 +		ti,nand-ecc-opt = "bch8";
 +		ti,elm-id = <&elm>;
 +		nand-bus-width = <8>;
 +		gpmc,device-width = <1>;
 +		gpmc,sync-clk-ps = <0>;
 +		gpmc,cs-on-ns = <0>;
 +		gpmc,cs-rd-off-ns = <40>;
 +		gpmc,cs-wr-off-ns = <40>;
 +		gpmc,adv-on-ns = <0>;
 +		gpmc,adv-rd-off-ns = <25>;
 +		gpmc,adv-wr-off-ns = <25>;
 +		gpmc,we-on-ns = <0>;
 +		gpmc,we-off-ns = <20>;
 +		gpmc,oe-on-ns = <3>;
 +		gpmc,oe-off-ns = <30>;
 +		gpmc,access-ns = <30>;
 +		gpmc,rd-cycle-ns = <40>;
 +		gpmc,wr-cycle-ns = <40>;
 +		gpmc,wait-pin = <0>;
 +		gpmc,wait-on-read;
 +		gpmc,wait-on-write;
 +		gpmc,bus-turnaround-ns = <0>;
 +		gpmc,cycle2cycle-delay-ns = <0>;
 +		gpmc,clk-activation-ns = <0>;
 +		gpmc,wait-monitoring-ns = <0>;
 +		gpmc,wr-access-ns = <40>;
 +		gpmc,wr-data-mux-bus-ns = <0>;
 +		/* MTD partition table */
 +		/* All SPL-* partitions are sized to minimal length
 +		 * which can be independently programmable. For
 +		 * NAND flash this is equal to size of erase-block */
 +		#address-cells = <1>;
 +		#size-cells = <1>;
 +		partition at 0 {
 +			label = "NAND.SPL";
 +			reg = <0x00000000 0x00040000>;
 +		};
 +		partition at 1 {
 +			label = "NAND.SPL.backup1";
 +			reg = <0x00040000 0x00040000>;
 +		};
 +		partition at 2 {
 +			label = "NAND.SPL.backup2";
 +			reg = <0x00080000 0x00040000>;
 +		};
 +		partition at 3 {
 +			label = "NAND.SPL.backup3";
 +			reg = <0x000c0000 0x00040000>;
 +		};
 +		partition at 4 {
 +			label = "NAND.u-boot-spl-os";
 +			reg = <0x00100000 0x00080000>;
 +		};
 +		partition at 5 {
 +			label = "NAND.u-boot";
 +			reg = <0x00180000 0x00100000>;
 +		};
 +		partition at 6 {
 +			label = "NAND.u-boot-env";
 +			reg = <0x00280000 0x00040000>;
 +		};
 +		partition at 7 {
 +			label = "NAND.u-boot-env.backup1";
 +			reg = <0x002c0000 0x00040000>;
 +		};
 +		partition at 8 {
 +			label = "NAND.kernel";
 +			reg = <0x00300000 0x00700000>;
 +		};
 +		partition at 9 {
 +			label = "NAND.file-system";
 +			reg = <0x00a00000 0x1f600000>;
 +		};
 +	};
 +};
++
+ &dss {
+ 	status = "ok";
+ 
+ 	pinctrl-names = "default";
+ 	pinctrl-0 = <&dss_pins>;
+ 
+ 	port {
+ 		dpi_out: endpoint at 0 {
+ 			remote-endpoint = <&lcd_in>;
+ 			data-lines = <24>;
+ 		};
+ 	};
+ };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140530/ef2404a9/attachment.sig>
