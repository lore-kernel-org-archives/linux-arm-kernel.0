From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Dec 2014 23:22:59 +0100
Subject: [PATCHv2 3/3]  ARM:dts:sunxi:ps2 dt nodes for A10/A20 PS2
 controller.
In-Reply-To: <1417907719-26775-4-git-send-email-VishnuPatekar0510@gmail.com>
References: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
 <1417907719-26775-4-git-send-email-VishnuPatekar0510@gmail.com>
Message-ID: <20141208222259.GN8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Your commit title should be less that 80 chars.

It should also be formatted using "ARM: sunxi: dts:" as a prefix (More
specific to less specific).

On Sun, Dec 07, 2014 at 04:45:19AM +0530, vishnupatekar wrote:
>  Added ps2 nodes in lime2 board dts. By default ps20 and ps21 nodes are
>  commented as ps20 pins conflict with HDMI connector
>  on Lime2 Board.
> 
> Signed-off-by: vishnupatekar <VishnuPatekar0510@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi                |   27 +++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   13 ++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi                |   29 +++++++++++++++++++++++
>  3 files changed, 69 insertions(+)

This patch should also be split into three different patches:
  - The one adding the nodes for the controller to the DTSI
  - The one adding the pinctrl nodes
  - The one enabling the controller on the board.

> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 5e2ec2d..4726e8d 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -615,6 +615,19 @@
>  				allwinner,drive = <0>;
>  				allwinner,pull = <0>;
>  			};

A newline here please.

> +			ps2_0_pins: ps2_0 at 0 {

You called the node ps20, you probably want to call it the same way
here. And we usually have a suffix like pins_a whenever we have
several muxing options (as it's probably the case).

> +				    allwinner,pins = "PI20","PI21";

A whitespace after the comma please.

> +				    allwinner,function = "ps2";
> +				    allwinner,drive = <0>;
> +				    allwinner,pull = <0>;
> +			};

Newline.

> +			ps2_1_pins: ps2_1 at 0 {
> +				    allwinner,pins = "PH12","PH13";
> +				    allwinner,function = "ps2";
> +				    allwinner,drive = <0>;
> +				    allwinner,pull = <0>;
> +			};
> +
>  		};
>  
>  		timer at 01c20c00 {
> @@ -781,5 +794,19 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};

Newline.

> +		ps20: ps2 at 0x01c2a000 {

Drop the 0x

> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a000 0x400>;
> +			interrupts = <0 62 4>;
> +			clocks = <&apb1_gates 6>;
> +			status = "disabled";
> +		};

Newline

> +		ps21: ps2 at 0x01c2a400 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a400 0x400>;
> +			interrupts = <0 63 4>;
> +			clocks = <&apb1_gates 7>;
> +			status = "disabled";
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index ed364d5..5624e63 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -112,6 +112,19 @@
>  			pinctrl-0 = <&uart0_pins_a>;
>  			status = "okay";
>  		};
> +		/* PS2 0 and PS2 1 are disabled by default
> +		To enable PS2 0 and PS2 1 uncomment below ps20 and ps21 nodes
> +		Please note that ps20 pins conflict with HDMI on Lime2 Board*/
> +		/*ps20: ps2 at 0x01c2a000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ps2_0_pins>;
> +			status = "okay";
> +		};
> +		ps21: ps2 at 0x01c2a400 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ps2_1_pins>;
> +			status = "okay";
> +		};*/

Hmmm, no, no comments in the DTS.

Especially when it's that trivial to enable.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/a7b6da6c/attachment.sig>
