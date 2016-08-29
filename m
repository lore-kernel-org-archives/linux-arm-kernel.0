From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Aug 2016 08:49:04 +0200
Subject: [PATCH v2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <20160828005521.58221-1-icenowy@aosc.xyz>
References: <20160828005521.58221-1-icenowy@aosc.xyz>
Message-ID: <20160829064904.GB7612@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 28, 2016 at 08:55:21AM +0800, Icenowy Zheng wrote:
> UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
> on iNet D978 Rev2 board.
> 
> Enable the UART1 to make it possible to use the modified hciattach by
> Realtek to drive the BT part of RTL8723BS.
> 
> On the board no r_uart pins are found now (the onboard RX/TX pins are
> wired to PF2/PF4, which is muxed with mmc0), so also disabled it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes since v1:
> - Deleted r_uart.
> - Added the pinmux of uart1 at PG.
> 
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi           | 14 ++++++++++++++
>  arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 20 ++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index 7e05e09..d236104 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -361,6 +361,20 @@
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
>  
> +			uart1_pins_a: uart1 at 0 {
> +				allwinner,pins = "PG6", "PG7";
> +				allwinner,function = "uart1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			uart1_pins_cts_rts_a: uart1_cts_rts at 0 {
> +				allwinner,pins = "PG8", "PG9";
> +				allwinner,function = "uart1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +

This should be in a different patch.

>  			mmc0_pins_a: mmc0 at 0 {
>  				allwinner,pins = "PF0", "PF1", "PF2",
>  						 "PF3", "PF4", "PF5";
> diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> index 0f52cd9..a1f654a8 100644
> --- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> +++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> @@ -49,6 +49,15 @@
>  	model = "INet-D978 Rev 02";
>  	compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
>  
> +	aliases {
> +		/delete-property/serial0;
> +		serial1 = &uart1;

And to restate what I said, there's exactly *no* reason to have it a
serial0.

Every device in Linux is enumerated from 0 (or equivalent). The hard
disks are (if you have only one, it will be /dev/sda or /dev/hda), the
MMC cards are, the SPI buses are, the framebuffers are, why would the
UART be a special case?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/c83f542b/attachment.sig>
