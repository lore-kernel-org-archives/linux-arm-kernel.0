From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 05 Jan 2015 18:06:58 +0100
Subject: [PATCH 3/3] ARM: mvebu: Add Armada 385 General Purpose Development
 Board support
In-Reply-To: <20141231113250.6ae98b19@free-electrons.com>
References: <1419678035-10658-1-git-send-email-gregory.clement@free-electrons.com>	<1419678035-10658-4-git-send-email-gregory.clement@free-electrons.com>
 <20141231113250.6ae98b19@free-electrons.com>
Message-ID: <54AAC4B2.8040401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 31/12/2014 11:32, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Sat, 27 Dec 2014 12:00:35 +0100, Gregory CLEMENT wrote:
> 
>> +				spi-flash at 0 {
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					compatible = "st,m25p128";
>> +					reg = <0>; /* Chip select 0 */
>> +					spi-max-frequency = <50000000>;
> 
> According to the m25p128 datasheet,  the max frequency is 54 Mhz.

It is the  max frequency for the 65nm devices, but the one on the GP board
is a M25P128-VMF6P. As there was no 'B' in the part number then it was a
130nm device which is limited to 50MHz.

> 
>> +			i2c at 11000 {
>> +				status = "okay";
>> +				clock-frequency = <100000>;
>> +
>> +				pca9555_0: pca9555 at 20 {
>> +					compatible = "nxp,pca9555";
>> +					pinctrl-names = "default";
>> +					pinctrl-0 = <&pca0_pins>;
>> +					interrupt-parent = <&gpio0>;
>> +					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
>> +					gpio-controller;
>> +					#gpio-cells = <2>;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +					reg = <0x20>;
>> +				};
>> +
>> +				pca9555_1: pca9555 at 21 {
>> +					compatible = "nxp,pca9555";
>> +					pinctrl-names = "default";
>> +					interrupt-parent = <&gpio0>;
>> +					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +					gpio-controller;
>> +					#gpio-cells = <2>;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +
>> +					reg = <0x21>;
>> +				};
> 
> It would be good to align both description in terms of empty new lines.
> 
> Also, in the second controller, you have pinctrl-names, but no
> pinctrl-0, so it doesn't make much sense.
> 

Yes it was a left over of from a previous version, I will remove it.

>> +			ethernet at 70000 {
>> +				status = "okay";
>> +				phy = <&phy1>;
>> +				phy-mode = "rgmii-id";
>> +			};
>> +
>> +
> 
> One too many empty new line.
> 
>> +			mdio at 72004 {
>> +				phy0: ethernet-phy at 0 {
>> +					reg = <0>;
>> +				};
>> +
>> +				phy1: ethernet-phy at 1 {
>> +					reg = <1>;
>> +				};
>> +			};
> 
> Maybe this is confusing, but it seems like the port 0 (i.e the one at
> 0x70000) is connected to the PHY at address 1, while the port 1 (i.e
> the one at 0x30000) is connected to the PHY at address 0. According to
> U-Boot:
> 
> | egiga0 |   RGMII   |     0x01     |
> | egiga1 |   RGMII   |     0x00     |
> 
> So maybe we should have:
> 
> 	ethernet at 30000 {
> 		phy = <&phy1>;
> 	};
> 
> 	ethernet at 70000 {
> 		phy = <&phy0>;
> 	};
> 
> 	mdio at 72004 {
> 		phy0: ethernet-phy at 1 {
> 			reg = <1>;
> 		};
> 
> 		phy1: ethernet-phy at 0 {
> 			reg = <0>;
> 		};
> 	};
> 
> To reflect this, no?



> 
>> +			sata at a8000 {
>> +				nr-ports = <2>;
>> +				status = "okay";
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				sata0: sata-port at 0 {
>> +					reg = <0>;
>> +					target-supply = <&reg_5v_sata0>;
>> +				};
>> +
>> +				sata1: sata-port at 1 {
>> +					reg = <1>;
>> +					target-supply = <&reg_5v_sata1>;
>> +				};
> 
> Doesn't this part depends on the patches you have submitted to the AHCI
> driver? If so, it would be good to state this in the cover letter, so
> that the dependencies are known. Or for the moment, to not handle the
> SATA part, until the DT binding for describing per-SATA port regulators
> is sorted out (I saw that the feedback from Mark Brown on your patches
> indicate that some rework will be needed).

It was the same kind of DT binding which was used for PHY that I used for
the regulator, I didn't imagine that it couldn't be accepted. But I was
wrong DT bindings seems to be really dependent of each maintainers.

I will move the regulator part of the SATA in a different patch.

> 
> Also, having a reg property into a child node that isn't part of a bus
> looks wrong.

But according to the binding documentation:
Documentation/devicetree/bindings/ata/ahci-platform.txt, the reg property is a
required property. If it is wrong that means that the bindings should be changed,
but it also should be stable.

> 
>> +			};
>> +
>> +			sata at e0000 {
>> +				nr-ports = <2>;
>> +				status = "okay";
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				sata2: sata-port at 0 {
>> +					reg = <0>;
>> +					target-supply = <&reg_5v_sata2>;
>> +				};
>> +
>> +				sata3: sata-port at 1 {
>> +					reg = <1>;
>> +					target-supply = <&reg_5v_sata3>;
>> +				};
>> +			};
> 
> Ditto.
> 
>> +			sdhci at d8000 {
>> +				clock-frequency = <200000000>;
> 
> Why? There is already a 'clocks' property in armada-38x.dtsi. However,
> the clock is actually 250 Mhz, not 200 Mhz. Any reason why you forced
> 200 Mhz here?
> 

It was copied from the 385 DB dts before the patch "ARM: mvebu: remove
clock-frequency from Armada 38x SDHCI Device Tree node" was applied. I will
remove it


>> +				cd-gpios = <&pca9555_0 5 GPIO_ACTIVE_LOW>;
>> +				no-1-8-v;
>> +				wp-inverted;
> 
> Why do you have a wp-inverted property, with no wp-gpios property? If I
> understand the DT binding correctly, wp-inverted only makes sense when
> wp-gpios is used.

This part came also from the 385 DB board as the connector was similar. I
thought you had introduced it on purpose so I kept it.


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
