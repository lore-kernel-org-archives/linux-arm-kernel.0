From: karl.beldan@gmail.com (Karl Beldan)
Date: Thu, 29 Sep 2016 18:40:20 +0000
Subject: [PATCH 3/6] ARM: dts: da850-lcdk: enable the LCD controller
In-Reply-To: <1475166715-7857-4-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20160929184001.yooxkwulqgioak6a@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 29, 2016 at 06:31:52PM +0200, Bartosz Golaszewski wrote:
> From: Karl Beldan <kbeldan@baylibre.com>
> 
> This adds the pins used by the LCD controller, and uses 'tilcdc,panel'
> with some default timings for 800x600.
> 
> Tested on an LCDK connected on the VGA port (the LCDC is connected to
> this port via a THS8135).
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> [Bartosz:
>   - fixed whitespace errors
>   - tweaked the description

The description tweak you mention is the removal of an erratum which is
in the mentioned commit I put on github @
(https://github.com/kbeldan/linux/commit/b7720bc983c00a083dece119f68ea9d2f522c6c4)
it included an erratum wrt FIFO threshold I think is worth keeping:
{
There is an erratum (fifo-th) "LCDC: Underflow During Initialization":
[...]
"This problem may occur if the LCDC FIFO threshold size (
LCDDMA_CTRL[TH_FIFO_READY]) is left at its default value after reset.
Increasing the FIFO threshold size will reduce or eliminate underflows.
Setting the threshold size to 256 double words or larger is
recommended."
}

>   - fixed the incorrect hback-porch value

It can't be a fix, this value depends on the monitor connected.

>   - other minor tweaks]

I didn't see any other change while diffing.

Regards, 
Karl Beldan

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 60 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 7b8ab21..6ca5d48 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -50,6 +50,40 @@
>  			system-clock-frequency = <24576000>;
>  		};
>  	};
> +
> +	panel {
> +		compatible = "ti,tilcdc,panel";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_pins>;
> +		status = "okay";
> +
> +		panel-info {
> +			ac-bias           = <0>;
> +			ac-bias-intrpt    = <0>;
> +			dma-burst-sz      = <16>;
> +			bpp               = <16>;
> +			fdd               = <255>;
> +			sync-edge         = <0>;
> +			sync-ctrl         = <0>;
> +			raster-order      = <0>;
> +			fifo-th           = <5>;
> +		};
> +
> +		display-timings {
> +			native-mode = <&svga_timings>;
> +			svga_timings: 800x600 {
> +				clock-frequency = <37500000>;
> +				hactive = <800>;
> +				hback-porch = <140>;
> +				hfront-porch = <40>;
> +				hsync-len = <128>;
> +				vactive = <600>;
> +				vback-porch = <23>;
> +				vfront-porch = <1>;
> +				vsync-len = <4>;
> +			};
> +		};
> +	};
>  };
>  
>  &pmx_core {
> @@ -84,6 +118,28 @@
>  			0x30 0x01100000  0x0ff00000
>  		>;
>  	};
> +
> +	lcd_pins: pinmux_lcd_pins {
> +		pinctrl-single,bits = <
> +			/*
> +			 * LCD_D[2], LCD_D[3], LCD_D[4], LCD_D[5],
> +			 * LCD_D[6], LCD_D[7]
> +			 */
> +			0x40 0x22222200 0xffffff00
> +			/*
> +			 * LCD_D[10], LCD_D[11], LCD_D[12], LCD_D[13],
> +			 * LCD_D[14], LCD_D[15], LCD_D[0], LCD_D[1]
> +			 */
> +			0x44 0x22222222 0xffffffff
> +			/* LCD_D[8], LCD_D[9] */
> +			0x48 0x00000022 0x000000ff
> +
> +			/* LCD_PCLK */
> +			0x48 0x02000000 0x0f000000
> +			/* LCD_AC_ENB_CS, LCD_VSYNC, LCD_HSYNC */
> +			0x4c 0x02000022 0x0f0000ff
> +		>;
> +	};
>  };
>  
>  &serial2 {
> @@ -219,3 +275,7 @@
>  		};
>  	};
>  };
> +
> +&lcdc {
> +	status = "okay";
> +};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
