From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 25 Sep 2014 12:58:57 +1000
Subject: linux-next: manual merge of the net-next tree with the arm-soc tree
Message-ID: <20140925125857.0516ceab@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the net-next tree got conflicts in
arch/arm/boot/dts/rk3188.dtsi and arch/arm/boot/dts/rk3xxx.dtsi between
commits fd14e6f9b461 ("ARM: dts: rockchip: add dwc2 controllers for
rk3066 and rk3188") and 4ff4ae1258a9 ("ARM: dts: rockchip: add emmc
nodes for rk3066 and rk3188") from the arm-soc tree and commit
18ec91e1947f ("ARM: dts: Add emac nodes to the rk3188 device tree")
from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/rk3188.dtsi
index 82732f5249b2,7f25bc51f2ee..000000000000
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@@ -147,27 -147,24 +147,45 @@@
  			bias-disable;
  		};
  
 +		emmc {
 +			emmc_clk: emmc-clk {
 +				rockchip,pins = <RK_GPIO0 24 RK_FUNC_2 &pcfg_pull_none>;
 +			};
 +
 +			emmc_cmd: emmc-cmd {
 +				rockchip,pins = <RK_GPIO0 26 RK_FUNC_2 &pcfg_pull_up>;
 +			};
 +
 +			emmc_rst: emmc-rst {
 +				rockchip,pins = <RK_GPIO0 27 RK_FUNC_2 &pcfg_pull_none>;
 +			};
 +
 +			/*
 +			 * The data pins are shared between nandc and emmc and
 +			 * not accessible through pinctrl. Also they should've
 +			 * been already set correctly by firmware, as
 +			 * flash/emmc is the boot-device.
 +			 */
 +		};
 +
+ 		emac {
+ 			emac_xfer: emac-xfer {
+ 				rockchip,pins = <RK_GPIO3 16 RK_FUNC_2 &pcfg_pull_none>, /* tx_en */
+ 						<RK_GPIO3 17 RK_FUNC_2 &pcfg_pull_none>, /* txd1 */
+ 						<RK_GPIO3 18 RK_FUNC_2 &pcfg_pull_none>, /* txd0 */
+ 						<RK_GPIO3 19 RK_FUNC_2 &pcfg_pull_none>, /* rxd0 */
+ 						<RK_GPIO3 20 RK_FUNC_2 &pcfg_pull_none>, /* rxd1 */
+ 						<RK_GPIO3 21 RK_FUNC_2 &pcfg_pull_none>, /* mac_clk */
+ 						<RK_GPIO3 22 RK_FUNC_2 &pcfg_pull_none>, /* rx_err */
+ 						<RK_GPIO3 23 RK_FUNC_2 &pcfg_pull_none>; /* crs_dvalid */
+ 			};
+ 
+ 			emac_mdio: emac-mdio {
+ 				rockchip,pins = <RK_GPIO3 24 RK_FUNC_2 &pcfg_pull_none>,
+ 						<RK_GPIO3 25 RK_FUNC_2 &pcfg_pull_none>;
+ 			};
+ 		};
+ 
  		i2c0 {
  			i2c0_xfer: i2c0-xfer {
  				rockchip,pins = <RK_GPIO1 24 RK_FUNC_1 &pcfg_pull_none>,
diff --cc arch/arm/boot/dts/rk3xxx.dtsi
index 7332d12eb565,208b1df6bcb0..000000000000
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@@ -134,24 -91,23 +134,41 @@@
  		status = "disabled";
  	};
  
 +	usb_otg: usb at 10180000 {
 +		compatible = "rockchip,rk3066-usb", "snps,dwc2";
 +		reg = <0x10180000 0x40000>;
 +		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 +		clocks = <&cru HCLK_OTG0>;
 +		clock-names = "otg";
 +		status = "disabled";
 +	};
 +
 +	usb_host: usb at 101c0000 {
 +		compatible = "snps,dwc2";
 +		reg = <0x101c0000 0x40000>;
 +		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 +		clocks = <&cru HCLK_OTG1>;
 +		clock-names = "otg";
 +		status = "disabled";
 +	};
 +
+ 	emac: ethernet at 10204000 {
+ 		compatible = "snps,arc-emac";
+ 		reg = <0x10204000 0x3c>;
+ 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+ 		#address-cells = <1>;
+ 		#size-cells = <0>;
+ 
+ 		rockchip,grf = <&grf>;
+ 
+ 		clocks = <&cru HCLK_EMAC>, <&cru SCLK_MAC>;
+ 		clock-names = "hclk", "macref";
+ 		max-speed = <100>;
+ 		phy-mode = "rmii";
+ 
+ 		status = "disabled";
+ 	};
+ 
  	mmc0: dwmmc at 10214000 {
  		compatible = "rockchip,rk2928-dw-mshc";
  		reg = <0x10214000 0x1000>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/0c27d643/attachment.sig>
