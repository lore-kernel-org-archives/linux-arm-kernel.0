From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 5 Nov 2013 10:48:45 +0100
Subject: [BUG?] ARM: mvebu: is second PCIe unit of Armada XP mv78230 x1
 or x4?
In-Reply-To: <87ppqgyrmc.fsf@natisbad.org>
References: <87ppqgyrmc.fsf@natisbad.org>
Message-ID: <20131105104845.4fc9e216@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Mon, 04 Nov 2013 19:00:11 +0100, Arnaud Ebalard wrote:

> Then, I took a look at the [laconic] public documentation on the various
> flavours of the Armada XP (mv7823, mv78260 and mv78460) regarding PCIe
> aspects. I noticed that [1] reports a x1 second PCIe unit for mv78230
> when [2] reports one x4 second unit for mv78230. FWIW, armada-xp-mv78230.dtsi
> currently states the second unit is x4/x1.

Thanks for the great investigation! There is indeed something wrong in
our .dts files, and the datasheet doesn't make everything entirely
clear.

The functional datasheet (which covers the three SoC variants 78230,
78260 and 78460) says:

MV78230 2 PCIe units Gen2.0.

	One unit can be configured as x4 or quad x1 lanes. The other
	unit is x1.

MV78260 3 PCIe units Gen2.0

	Two units can be configured as x4 or quad x1 lanes.
	One unit is x4/x1.

MV78460 4 PCIe units Gen2.0

	Two of those units can be configured as x4 or quad x1 lanes. The
	other 2 units are x4 or x1.

but for those variants (78230 and 78260) that don't have *all* PCIe
interfaces, it doesn't say *which* ones are available from the set of
10 possibles interfaces in 78460, and therefore the 10 register areas
that are available.

The only place where we (Gregory pointed me in the right direction)
could find some relation between the SoC variants and the available PCIe
interfaces is in the hardware manual of each SoC variant, where the
SERDES lanes are described.

For MV78230, it says:

	PCIe 0.0, 0.1, 0.2, 0.3, 1.0, 1.1 and 1.2

For MV78260, it says:

	PCIe 0.0, 0.1, 0.2, 0.3, 1.0, 1.1, 1.2, 1.3 and 2 x4

For MV78460, it says

	PCIe 0.0, 0.1, 0.2, 0.3, 1.0, 1.1, 1.2, 1.3, 2 x4 and 3 x4

What it says for 78230 it a bit weird, because I don't see why it
mentions 1.1 and 1.2 since the second PCIe interface on 78230 is said
to be x1. Maybe that's a mistake in the datasheet, I'll try to get a
confirmation about this.

But indeed it seems like the second PCIe interface on 78230 is 1.0 and
not 2.0, as you found out. So your patch below looks correct to me, and
the mv78260.dtsi should also be modified to expose the correct PCIe
interfaces.

(We've mostly had access to 78460 hardware until now, and the only
78260 hardware I had access to only exposes the PCIe 0.0 interface, so
I couldn't test the other ones).

> diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> index 0358a33..9dc7381 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
> @@ -47,7 +47,7 @@
>  		/*
>  		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
>  		 * configured as x4 or quad x1 lanes. One unit is
> -		 * x4/x1.
> +		 * x1 only.

Ack.

>  		 */
>  		pcie-controller {
>  			compatible = "marvell,armada-xp-pcie";
> @@ -61,10 +61,10 @@
>  
>  			ranges =
>  			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
> -				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
>  				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
>  				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
>  				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
> +				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */

Ack.

>  				0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
>  				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
>  				0x82000000 0x2 0       MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
> @@ -73,8 +73,8 @@
>  				0x81000000 0x3 0       MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
>  				0x82000000 0x4 0       MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
>  				0x81000000 0x4 0       MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
> -				0x82000000 0x9 0       MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
> -				0x81000000 0x9 0       MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */>;
> +				0x82000000 0x5 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
> +				0x81000000 0x5 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */>;

Ack.

>  
>  			pcie at 1,0 {
>  				device_type = "pci";
> @@ -144,20 +144,20 @@
>  				status = "disabled";
>  			};
>  
> -			pcie at 9,0 {
> +			pcie at 5,0 {
>  				device_type = "pci";
> -				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
> -				reg = <0x4800 0 0 0 0>;
> +				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
> +				reg = <0x2800 0 0 0 0>;
>  				#address-cells = <3>;
>  				#size-cells = <2>;
>  				#interrupt-cells = <1>;
> -				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
> -					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
> +				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
> +					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &mpic 99>;
> -				marvell,pcie-port = <2>;
> +				interrupt-map = <0 0 0 0 &mpic 62>;
> +				marvell,pcie-port = <1>;
>  				marvell,pcie-lane = <0>;
> -				clocks = <&gateclk 26>;
> +				clocks = <&gateclk 9>;
>  				status = "disabled";
>  			};
>  		};

This all looks good. Would you mind submitting a proper patch with your
SoB ? Of course, if you also want to fix 78260, feel free to do so. If
not, then please let me know so I can send a patch.

Again, thanks a lot for your investigation!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
