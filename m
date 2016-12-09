From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Dec 2016 09:07:53 +0100
Subject: [PATCH] ARM: dts: sun8i-q8-common: enable bluetooth on SDIO Wi-Fi
In-Reply-To: <20161206080838.7523-1-icenowy@aosc.xyz>
References: <20161206080838.7523-1-icenowy@aosc.xyz>
Message-ID: <20161209080753.jmtbt6or2zylxtza@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 04:08:38PM +0800, Icenowy Zheng wrote:
> Some SDIO Wi-Fi chips (such as RTL8703AS) have a UART bluetooth, which
> has a dedicated enable pin (PL8 in the reference design).
> 
> Enable the pin in the same way as the WLAN enable pins.
> 
> Tested on an A33 Q8 tablet with RTL8703AS.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> 
> This patch should be coupled with the uart1 node patch I send before:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/471997.html
> 
> For RTL8703AS, the rtl8723bs bluetooth code is used, which can be retrieve from:
> https://github.com/lwfinger/rtl8723bs_bt
> 
>  arch/arm/boot/dts/sun8i-q8-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
> index c676940..4aeb5bb 100644
> --- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
> +++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
> @@ -88,7 +88,7 @@
>  
>  &r_pio {
>  	wifi_pwrseq_pin_q8: wifi_pwrseq_pin at 0 {
> -		pins = "PL6", "PL7", "PL11";
> +		pins = "PL6", "PL7", "PL8", "PL11";
>  		function = "gpio_in";
>  		bias-pull-up;
>  	};

There's several things wrong here. The first one is that you rely
solely on the pinctrl state to maintain a reset line. This is very
fragile (especially since the GPIO pinctrl state are likely to go away
at some point), but it also means that if your driver wants to recover
from that situation at some point, it won't work.

The other one is that the bluetooth and wifi chips are two devices in
linux, and you assign that pin to the wrong device (wifi).

rfkill-gpio is made just for that, so please use it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161209/8ee44e83/attachment.sig>
