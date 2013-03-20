From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 21 Mar 2013 07:18:35 +1300
Subject: [Bulk] [PATCH V4 7/9] ARM: vt8500: Provide regulator to
 pwm-backlight
In-Reply-To: <1363719573-20926-8-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-8-git-send-email-achew@nvidia.com>
Message-ID: <1363803515.4635.7.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-19 at 11:59 -0700, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> ---
>  arch/arm/boot/dts/wm8850-w70v2.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/wm8850-w70v2.dts b/arch/arm/boot/dts/wm8850-w70v2.dts
> index fcc660c..47a0b1a 100644
> --- a/arch/arm/boot/dts/wm8850-w70v2.dts
> +++ b/arch/arm/boot/dts/wm8850-w70v2.dts
> @@ -37,11 +37,17 @@
>  		};
>  	};
>  
> +	bl_en: fixed-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "bl-en-supply";
> +	};
> +
>  	backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pwm 0 50000 1>;	/* duty inverted */
>  
>  		brightness-levels = <0 40 60 80 100 130 190 255>;
>  		default-brightness-level = <5>;
> +		enable-supply = <&bl_en>;
>  	};
>  };

This board will use either <&gpio 0 7 0> or <&pinctrl 7 0>, dependant on
the pinctrl driver patchset going through.

If you want it to 'work', feel free to add a regulator for the <&gpio 0
7 0> case - otherwise just leave the dummy and I'll patch it later once
the pinctrl driver is finished.

I only know of one user who is disabling the backlight gpio at present,
and he is doing it with a gpio-led node.

The backlight is enabled by uboot on all boards with an LCD present, so
this is just a power-saving feature for us - nothing breaks by having a
dummy.

Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony P
