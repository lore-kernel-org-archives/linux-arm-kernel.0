From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 2 Apr 2016 18:16:39 +0200
Subject: [PATCH] ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500
In-Reply-To: <1459601753-31193-1-git-send-email-bert@biot.com>
References: <1459601753-31193-1-git-send-email-bert@biot.com>
Message-ID: <20160402161639.GF32554@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2016 at 02:55:52PM +0200, Bert Vermeulen wrote:
> This platform is based on a Marvell 88E6282 SoC and 88E6171 switch.

Hi Bert

Thanks for contributing this. I have a few comments.
 
> The DSA port labels follow the switchdev convention.

I've generally been using the labels on the case for the port names,
if they have labels. I think this is more useful than some abstract
names which are hard to match to the real hardware. A quick look at
images on Amazon suggests ethernet1, ethernet2, ... internet.

> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  arch/arm/boot/dts/kirkwood-candyhouse.dts | 228 ++++++++++++++++++++++++++++++
>  1 file changed, 228 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-candyhouse.dts
> 
> diff --git a/arch/arm/boot/dts/kirkwood-candyhouse.dts b/arch/arm/boot/dts/kirkwood-candyhouse.dts
> new file mode 100644
> index 0000000..1d16cef
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-candyhouse.dts
> @@ -0,0 +1,228 @@
> +/*
> + * kirkwood-candyhouse.dts - Device Tree file for Linksys Candyhouse (E4200v2 / EA4500)
> + *
> + * (c) 2013 Jonas Gorski <jogo@openwrt.org>
> + * (c) 2013 Deutsche Telekom Innovation Laboratories
> + * (c) 2014 Luka Perkov <luka@openwrt.org>
> + * (c) 2014 Randy C. Will <randall.will@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */

Could you dual license this under X11 as well? You will need agreement
from the copyright holders above, if they wrote DT fragments.

Not many kirkwood boards are, but we encourage most Marvell SoCs DT
files to be dual license.

> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6282.dtsi"
> +
> +/ {
> +	model = "Linksys Candyhouse (E4200v2 / EA4500)";
> +	compatible = "linksys,ea4500", "linksys,e4200v2", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x8000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";

Please change this to stdout-path = "serial0:115200n8";

> +	};
> +

> +		/* There is no battery on the boards, so the RTC does not keep
> +		   time when there is no power, making it useless. */
> +		rtc at 10300 {
> +			status = "disabled";
> +		};
> +
> +		serial at 12000 {
> +			status = "okay";
> +		};

rtc and serial have labels, so you can take these out of the hierarchy.
See kirkwood-dir665.dts for an example how it does rtc, mdio, etc.

> +	dsa at 0 {

No need for the @0 here. I need to go fix that in a few different .dts
files, which i think will soon cause warnings from the compiler.

> +		compatible = "marvell,dsa";
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		dsa,ethernet = <&eth0port>;
> +		dsa,mii-bus = <&mdio>;
> +
> +		switch at 0 {

The reg is <0x10,0>, so this @0 is wrong. I don't actually know how
you are supposed to represent a two part address....

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x10 0>;	/* MDIO address 16, switch 0 in tree */
> +
> +			port at 0 {
> +				reg = <0>;
> +				label = "sw0p0";
> +			};
> +
> +			port at 1 {
> +				reg = <1>;
> +				label = "sw0p1";
> +			};
> +
> +			port at 2 {
> +				reg = <2>;
> +				label = "sw0p2";
> +			};
> +
> +			port at 3 {
> +				reg = <3>;
> +				label = "sw0p3";
> +			};
> +
> +			port at 4 {
> +				reg = <4>;
> +				label = "sw0p4";
> +			};
> +
> +			port at 5 {
> +				reg = <5>;
> +				label = "cpu";
> +			};

The 6171 is a 7 port device. Is the last port also a 'cpu' port? At
the moment we cannot use it, but it would be nice to have a comment if
it is. Ah, you have a comment at the end. 

> +		};
> +	};
> +};
> +
> +&nand {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_nand>;
> +	pinctrl-names = "default";
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0 0x80000>;
> +	};

Please read Documentation/devicetree/bindings/mtd/partition.txt, in
particular the partitions node. I'm never quite sure when it works, i
know i've asked somebody to use it in a situation when it did not
actually work...

> +
> +	partition at 80000 {
> +		label = "u_env";
> +		reg = <0x80000 0x20000>;
> +	};
> +
> +	partition at A0000 {
> +		label = "s_env";
> +		reg = <0xA0000 0x20000>;
> +	};
> +
> +	partition at 200000 {
> +		label = "kernel";
> +		reg = <0x200000 0x2A0000>;
> +	};

Do we have a hole between s_env and kernel? We have seen that before
with Linksys devices, e.g. armada-xp-linksys-mamba.dts. Maybe put a
partition at the end to cover this hole.

	  Andrew
