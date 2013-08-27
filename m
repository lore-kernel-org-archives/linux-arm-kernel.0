From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Aug 2013 18:29:35 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20130827182935.ff4005b60cc1ce80d32d5e46@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/tegra20-trimslice.dts between commit 30ca2226bea6
("ARM: tegra: always enable USB VBUS regulators") from Linus' tree and
commit 23f95ef2d951 ("ARM: tegra: use TEGRA_GPIO() in a couple more
places") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/tegra20-trimslice.dts
index 1e9d33a,22e227f..0000000
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@@ -310,8 -310,19 +310,18 @@@
  		nvidia,sys-clock-req-active-high;
  	};
  
+ 	pcie-controller {
+ 		status = "okay";
+ 		pex-clk-supply = <&pci_clk_reg>;
+ 		vdd-supply = <&pci_vdd_reg>;
+ 
+ 		pci at 1,0 {
+ 			status = "okay";
+ 		};
+ 	};
+ 
  	usb at c5000000 {
  		status = "okay";
 -		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
  	};
  
  	usb-phy at c5000000 {
@@@ -410,10 -421,26 +420,28 @@@
  			regulator-min-microvolt = <5000000>;
  			regulator-max-microvolt = <5000000>;
  			enable-active-high;
- 			gpio = <&gpio 170 0>; /* PV2 */
+ 			gpio = <&gpio TEGRA_GPIO(V, 2) 0>;
 +			regulator-always-on;
 +			regulator-boot-on;
  		};
+ 
+ 		pci_clk_reg: regulator at 3 {
+ 			compatible = "regulator-fixed";
+ 			reg = <3>;
+ 			regulator-name = "pci_clk";
+ 			regulator-min-microvolt = <3300000>;
+ 			regulator-max-microvolt = <3300000>;
+ 			regulator-always-on;
+ 		};
+ 
+ 		pci_vdd_reg: regulator at 4 {
+ 			compatible = "regulator-fixed";
+ 			reg = <4>;
+ 			regulator-name = "pci_vdd";
+ 			regulator-min-microvolt = <1050000>;
+ 			regulator-max-microvolt = <1050000>;
+ 			regulator-always-on;
+ 		};
  	};
  
  	sound {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/2a89a771/attachment-0001.sig>
