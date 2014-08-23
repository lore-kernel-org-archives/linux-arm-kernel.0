From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Sat, 23 Aug 2014 12:35:49 +0200
Subject: [PATCH 2/3] ARM: dts: Add DT changes for display on peach_pit
In-Reply-To: <1406317464-7525-3-git-send-email-ajaykumar.rs@samsung.com>
References: <1406317464-7525-1-git-send-email-ajaykumar.rs@samsung.com>
 <1406317464-7525-3-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <53F86E85.3050200@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.07.2014 21:44, schrieb Ajay Kumar:
> Add DT nodes for ps8622 bridge chip and panel-simple panel.

"simple-panel"

> Add backlight power supply for pwm-backlight.
> Also add bridge phandle needed by dp to enable display on peach_pit.

Note that peach_pi[t] is inconsistent with the file names being
peach-pi[t] here and in the two subjects.

> 
> Note that, peach_pit doesn't support "chunghwa,claa101wb01" panel,
> but still we choose to reuse the binding since "chunghwa,claa101wb01"
> has similar LCD timings.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   36 +++++++++++++++-------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 228a6b1..79beba8 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -30,11 +30,12 @@
>  		i2c20 = "/spi at 12d40000/cros-ec at 0/i2c-tunnel";
>  	};
>  
> -	backlight {
> +	backlight: backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pwm 0 1000000 0>;
>  		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
>  		default-brightness-level = <7>;
> +		power-supply = <&tps65090_fet1>;
>  		pinctrl-0 = <&pwm0_out>;
>  		pinctrl-names = "default";
>  	};
> @@ -100,6 +101,12 @@
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	panel: panel-simple {

Just "panel"? (AF)

> +		compatible = "chunghwa,claa101wb01", "simple-panel";

Drop "simple-panel" (Thierry)

> +		power-supply = <&tps65090_fet6>;
> +		backlight = <&backlight>;
> +	};
>  };
>  
>  &dp {
> @@ -113,22 +120,7 @@
>  	samsung,link-rate = <0x06>;
>  	samsung,lane-count = <2>;
>  	samsung,hpd-gpio = <&gpx2 6 0>;
> -
> -	display-timings {
> -		native-mode = <&timing1>;
> -
> -		timing1: timing at 1 {
> -			clock-frequency = <70589280>;
> -			hactive = <1366>;
> -			vactive = <768>;
> -			hfront-porch = <40>;
> -			hback-porch = <40>;
> -			hsync-len = <32>;
> -			vback-porch = <10>;
> -			vfront-porch = <12>;
> -			vsync-len = <6>;
> -		};
> -	};
> +	bridge = <&ps8625>;
>  };
>  
>  &fimd {
> @@ -155,6 +147,16 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&max98090_irq>;
>  	};
> +
> +	ps8625: ps8625-bridge at 48 {

"lvds-bridge"? (AF)

> +		compatible = "parade,ps8625";
> +		reg = <0x48>;
> +		sleep-gpios = <&gpx3 5 0>;
> +		reset-gpios = <&gpy7 7 0>;
> +		lane-count = <2>;
> +		panel = <&panel>;
> +		backlight = <&backlight>;
> +	};
>  };
>  
>  &hsi2c_9 {

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
