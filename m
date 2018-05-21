From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 May 2018 20:21:10 +0530
Subject: [PATCH V7] ARM: dts: da850-evm: Enable LCD and Backlight
In-Reply-To: <20180518203335.13878-1-aford173@gmail.com>
References: <20180518203335.13878-1-aford173@gmail.com>
Message-ID: <2d52e1f8-d321-4465-fdfa-fd0d718c67cf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 May 2018 02:03 AM, Adam Ford wrote:
> When using the board files the LCD works, but not with the DT.
> This adds enables the original da850-evm to work with the same
> LCD in device tree mode.
> 
> The EVM has a gpio for the regulator and a PWM for dimming the
> backlight.  The LCD and the vpif display pins are mutually
> exclusive, so if using the LCD, do not load the vpif driver.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 0e82bb988fde..a76c2ddfd23e 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -27,6 +27,60 @@
>  		spi0 = &spi1;
>  	};
>  
> +	backlight: backlight-pwm {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ecap2_pins>;
> +		power-supply = <&backlight_lcd>;
> +		compatible = "pwm-backlight";
> +		pwms = <&ecap2 0 50000 0>;

It will be nice to add a comment here: "The PWM here corresponds to 
production hardware. The schematic needs to be 1015171 (15 March 2010), 
Rev A or newer."

> +		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
> +		default-brightness-level = <7>;
> +	};
> +
> +	panel {
> +		compatible = "ti,tilcdc,panel";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_pins>;
> +		/*
> +		 * The vpif and the LCD are mutually exclusive.
> +		 * To enable VPIF, change the status below to 'disabled' then
> +		 * then change the status of the vpif below to 'okay'
> +		*/

This results in checkpatch warning:
 
[PATCH V7] ARM: dts: da850-evm: Enable LCD and Backlight.eml:153: WARNING: Block comments should align the * on each line
[PATCH V7] ARM: dts: da850-evm: Enable LCD and Backlight.eml:239: WARNING: Block comments should align the * on each line

>  &vpif {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
> -	status = "okay";
> +	/*
> +	 * The vpif and the LCD are mutually exclusive.
> +	 * To enable VPIF, disable the ti,tilcdc,panel then
> +	 * changed the status below to 'okay'
> +	*/
> +	status = "disabled";

Are you able to see VPIF is disabled after this? Trying your patch, I 
still see VPIF probing[1]. Also, only VPIF display has a conflict with 
LCD, correct (capture should be fine)?

Thanks,
Sekhar

[1]
[   34.739314] adv7343 0-002a: chip found @ 0x54 (DaVinci I2C adapter)
[   34.881422] vpif_display vpif_display: Pixel details: Width = 720,Height = 480
[   34.881506] vpif_display vpif_display: channel=5bf2d970,channel->video_dev=5bf2d970
[   34.883374] vpif_display vpif_display: Pixel details: Width = 720,Height = 480
[   34.883450] vpif_display vpif_display: channel=16041996,channel->video_dev=16041996
[   35.370777] tvp514x 0-005d: tvp514x 0-005d decoder driver registered !!
[   35.470088] vpif_capture vpif_capture: registered sub device tvp514x-0
[   35.827492] tvp514x 0-005c: tvp514x 0-005c decoder driver registered !!
[   35.866031] vpif_capture vpif_capture: registered sub device tvp514x-1
[   35.953752] vpif_capture vpif_capture: VPIF capture driver initialized

# ls /dev/video
video0  video1  video2  video3  
