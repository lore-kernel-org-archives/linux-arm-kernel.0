From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 17 Jan 2014 14:08:53 +1100
Subject: linux-next: manual merge of the devicetree tree with the arm-soc tree
Message-ID: <20140117140853.6faf2c053617c5e66648526f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Today's linux-next merge of the devicetree tree got a conflict in
arch/arm/boot/dts/dove.dtsi between commits 40aad3c1a9b6 ("dt/bindings:
Remove all references to device_type "ethernet-phy"") and b31b32119abe
("ARM: dove: sort DT nodes by address") from the devicetree tree and
commit 351291754df3 ("dt/bindings: remove device_type "network"
references") from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/dove.dtsi
index 8de1031233ae,39ffabe04cc5..000000000000
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@@ -170,224 -192,34 +170,222 @@@
  				status = "disabled";
  			};
  
 -			gpio0: gpio-ctrl at d0400 {
 -				compatible = "marvell,orion-gpio";
 -				#gpio-cells = <2>;
 -				gpio-controller;
 -				reg = <0xd0400 0x20>;
 -				ngpios = <32>;
 +			spi1: spi-ctrl at 14600 {
 +				compatible = "marvell,orion-spi";
 +				#address-cells = <1>;
 +				#size-cells = <0>;
 +				cell-index = <1>;
 +				interrupts = <5>;
 +				reg = <0x14600 0x28>;
 +				clocks = <&core_clk 0>;
 +				status = "disabled";
 +			};
 +
 +			mbusc: mbus-ctrl at 20000 {
 +				compatible = "marvell,mbus-controller";
 +				reg = <0x20000 0x80>, <0x800100 0x8>;
 +			};
 +
 +			bridge_intc: bridge-interrupt-ctrl at 20110 {
 +				compatible = "marvell,orion-bridge-intc";
  				interrupt-controller;
 -				#interrupt-cells = <2>;
 -				interrupts = <12>, <13>, <14>, <60>;
 +				#interrupt-cells = <1>;
 +				reg = <0x20110 0x8>;
 +				interrupts = <0>;
 +				marvell,#interrupts = <5>;
  			};
  
 -			gpio1: gpio-ctrl at d0420 {
 -				compatible = "marvell,orion-gpio";
 -				#gpio-cells = <2>;
 -				gpio-controller;
 -				reg = <0xd0420 0x20>;
 -				ngpios = <32>;
 +			intc: main-interrupt-ctrl at 20200 {
 +				compatible = "marvell,orion-intc";
  				interrupt-controller;
 -				#interrupt-cells = <2>;
 -				interrupts = <61>;
 +				#interrupt-cells = <1>;
 +				reg = <0x20200 0x10>, <0x20210 0x10>;
  			};
  
 -			gpio2: gpio-ctrl at e8400 {
 -				compatible = "marvell,orion-gpio";
 -				#gpio-cells = <2>;
 -				gpio-controller;
 -				reg = <0xe8400 0x0c>;
 -				ngpios = <8>;
 +			timer: timer at 20300 {
 +				compatible = "marvell,orion-timer";
 +				reg = <0x20300 0x20>;
 +				interrupt-parent = <&bridge_intc>;
 +				interrupts = <1>, <2>;
 +				clocks = <&core_clk 0>;
 +			};
 +
 +			crypto: crypto-engine at 30000 {
 +				compatible = "marvell,orion-crypto";
 +				reg = <0x30000 0x10000>,
 +				      <0xffffe000 0x800>;
 +				reg-names = "regs", "sram";
 +				interrupts = <31>;
 +				clocks = <&gate_clk 15>;
 +				status = "okay";
 +			};
 +
 +			ehci0: usb-host at 50000 {
 +				compatible = "marvell,orion-ehci";
 +				reg = <0x50000 0x1000>;
 +				interrupts = <24>;
 +				clocks = <&gate_clk 0>;
 +				status = "okay";
 +			};
 +
 +			ehci1: usb-host at 51000 {
 +				compatible = "marvell,orion-ehci";
 +				reg = <0x51000 0x1000>;
 +				interrupts = <25>;
 +				clocks = <&gate_clk 1>;
 +				status = "okay";
 +			};
 +
 +			xor0: dma-engine at 60800 {
 +				compatible = "marvell,orion-xor";
 +				reg = <0x60800 0x100
 +				       0x60a00 0x100>;
 +				clocks = <&gate_clk 23>;
 +				status = "okay";
 +
 +				channel0 {
 +					interrupts = <39>;
 +					dmacap,memcpy;
 +					dmacap,xor;
 +				};
 +
 +				channel1 {
 +					interrupts = <40>;
 +					dmacap,memcpy;
 +					dmacap,xor;
 +				};
 +			};
 +
 +			xor1: dma-engine at 60900 {
 +				compatible = "marvell,orion-xor";
 +				reg = <0x60900 0x100
 +				       0x60b00 0x100>;
 +				clocks = <&gate_clk 24>;
 +				status = "okay";
 +
 +				channel0 {
 +					interrupts = <42>;
 +					dmacap,memcpy;
 +					dmacap,xor;
 +				};
 +
 +				channel1 {
 +					interrupts = <43>;
 +					dmacap,memcpy;
 +					dmacap,xor;
 +				};
 +			};
 +
 +			sdio1: sdio-host at 90000 {
 +				compatible = "marvell,dove-sdhci";
 +				reg = <0x90000 0x100>;
 +				interrupts = <36>, <38>;
 +				clocks = <&gate_clk 9>;
 +				pinctrl-0 = <&pmx_sdio1>;
 +				pinctrl-names = "default";
 +				status = "disabled";
 +			};
 +
 +			eth: ethernet-ctrl at 72000 {
 +				compatible = "marvell,orion-eth";
 +				#address-cells = <1>;
 +				#size-cells = <0>;
 +				reg = <0x72000 0x4000>;
 +				clocks = <&gate_clk 2>;
 +				marvell,tx-checksum-limit = <1600>;
 +				status = "disabled";
 +
 +				ethernet-port at 0 {
- 					device_type = "network";
 +					compatible = "marvell,orion-eth-port";
 +					reg = <0>;
 +					interrupts = <29>;
 +					/* overwrite MAC address in bootloader */
 +					local-mac-address = [00 00 00 00 00 00];
 +					phy-handle = <&ethphy>;
 +				};
 +			};
 +
 +			mdio: mdio-bus at 72004 {
 +				compatible = "marvell,orion-mdio";
 +				#address-cells = <1>;
 +				#size-cells = <0>;
 +				reg = <0x72004 0x84>;
 +				interrupts = <30>;
 +				clocks = <&gate_clk 2>;
 +				status = "disabled";
 +
 +				ethphy: ethernet-phy {
- 					device_type = "ethernet-phy";
 +					/* set phy address in board file */
 +				};
 +			};
 +
 +			sdio0: sdio-host at 92000 {
 +				compatible = "marvell,dove-sdhci";
 +				reg = <0x92000 0x100>;
 +				interrupts = <35>, <37>;
 +				clocks = <&gate_clk 8>;
 +				pinctrl-0 = <&pmx_sdio0>;
 +				pinctrl-names = "default";
 +				status = "disabled";
 +			};
 +
 +			sata0: sata-host at a0000 {
 +				compatible = "marvell,orion-sata";
 +				reg = <0xa0000 0x2400>;
 +				interrupts = <62>;
 +				clocks = <&gate_clk 3>;
 +				phys = <&sata_phy0>;
 +				phy-names = "port0";
 +				nr-ports = <1>;
 +				status = "disabled";
 +			};
 +
 +			sata_phy0: sata-phy at a2000 {
 +				compatible = "marvell,mvebu-sata-phy";
 +				reg = <0xa2000 0x0334>;
 +				clocks = <&gate_clk 3>;
 +				clock-names = "sata";
 +				#phy-cells = <0>;
 +				status = "ok";
 +			};
 +
 +			audio0: audio-controller at b0000 {
 +				compatible = "marvell,dove-audio";
 +				reg = <0xb0000 0x2210>;
 +				interrupts = <19>, <20>;
 +				clocks = <&gate_clk 12>;
 +				clock-names = "internal";
 +				status = "disabled";
 +			};
 +
 +			audio1: audio-controller at b4000 {
 +				compatible = "marvell,dove-audio";
 +				reg = <0xb4000 0x2210>;
 +				interrupts = <21>, <22>;
 +				clocks = <&gate_clk 13>;
 +				clock-names = "internal";
 +				status = "disabled";
 +			};
 +
 +			thermal: thermal-diode at d001c {
 +				compatible = "marvell,dove-thermal";
 +				reg = <0xd001c 0x0c>, <0xd005c 0x08>;
 +			};
 +
 +			gate_clk: clock-gating-ctrl at d0038 {
 +				compatible = "marvell,dove-gating-clock";
 +				reg = <0xd0038 0x4>;
 +				clocks = <&core_clk 0>;
 +				#clock-cells = <1>;
 +			};
 +
 +			pmu_intc: pmu-interrupt-ctrl at d0050 {
 +				compatible = "marvell,dove-pmu-intc";
 +				interrupt-controller;
 +				#interrupt-cells = <1>;
 +				reg = <0xd0050 0x8>;
 +				interrupts = <33>;
 +				marvell,#interrupts = <7>;
  			};
  
  			pinctrl: pin-ctrl at d0200 {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/26a27b17/attachment.sig>
