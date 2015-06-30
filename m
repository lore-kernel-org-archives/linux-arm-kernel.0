From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 30 Jun 2015 12:49:47 +0300
Subject: [PATCH 1/7] ARM: shmobile: r8a73a4 dtsi: Add missing
 "gpio-ranges" to gpio node
In-Reply-To: <1435650327-2542-2-git-send-email-geert+renesas@glider.be>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
 <1435650327-2542-2-git-send-email-geert+renesas@glider.be>
Message-ID: <32630741.rNENluEsDE@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Tuesday 30 June 2015 09:45:21 Geert Uytterhoeven wrote:
> If a GPIO driver uses gpiochip_add_pin_range() (which is usually the
> case for GPIO/PFC combos), the GPIO hogging mechanism configured from DT
> doesn't work:
> 
>     requesting hog GPIO led1-high (chip r8a73a4_pfc, offset 28) failed
> 
> The actual error code is -517 == -EPROBE_DEFER.
> 
> The problem is that PFC+GPIO registration is handled in multiple steps:
>   1. pinctrl_register(),
>   2. gpiochip_add(),
>   3. gpiochip_add_pin_range().
> 
> Configuration of the hogs is handled in gpiochip_add():
> 
>     gpiochip_add
>         of_gpiochip_add
>             of_gpiochip_scan_hogs
>                 gpiod_hog
>                     gpiochip_request_own_desc
>                         __gpiod_request
>                             chip->request
>                                 pinctrl_request_gpio
>                                     pinctrl_get_device_gpio_range
> 
> However, at this point the GPIO controller hasn't been added to
> pinctrldev_list yet, so the range can't be found, and the operation fails
> with -EPROBE_DEFER.
> 
> To fix this, add a "gpio-ranges" property to the gpio device node, so
> the ranges are added by of_gpiochip_add_pin_range(), which is called by
> of_gpiochip_add() before the call to of_gpiochip_scan_hogs().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This looks sane to me, even though referencing the same DT node seems a bit 
dodgy. I'll let Linus comment on that, but for the implementation itself,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 5090d1a8f652e8be..cb4f7b2798fe23be 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -207,6 +207,13 @@
>  		reg = <0 0xe6050000 0 0x9000>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		gpio-ranges =
> +			<&pfc 0 0 31>, <&pfc 32 32 9>,
> +			<&pfc 64 64 22>, <&pfc 96 96 31>,
> +			<&pfc 128 128 7>, <&pfc 160 160 19>,
> +			<&pfc 192 192 31>, <&pfc 224 224 27>,
> +			<&pfc 256 256 28>, <&pfc 288 288 21>,
> +			<&pfc 320 320 10>;
>  		interrupts-extended =
>  			<&irqc0  0 0>, <&irqc0  1 0>, <&irqc0  2 0>, <&irqc0  3 0>,
>  			<&irqc0  4 0>, <&irqc0  5 0>, <&irqc0  6 0>, <&irqc0  7 0>,

-- 
Regards,

Laurent Pinchart
