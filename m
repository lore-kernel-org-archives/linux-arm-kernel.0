From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 17:06:19 +0100
Subject: [PATCH 2/3] ARM: dts: mbimxsd53 Add backlight and LCD regulator.
In-Reply-To: <1385566771-366-2-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
 <1385566771-366-2-git-send-email-denis@eukrea.com>
Message-ID: <20131128160618.GE23201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 04:39:30PM +0100, Denis Carikli wrote:
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-pwm at vger.kernel.org
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi       |    7 +++
>  .../imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts  |   64 ++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts

This could probably use a more verbose commit description.

> diff --git a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts
[...]
> +#include "imx53-eukrea-mbimxsd53-baseboard.dts"
> +
> +/ {
> +	backlight {
> +		compatible = "pwm-backlight";
> +		power-supply = <&reg_lvds_backlight_3v3>;
> +		pwms = <&mc13xxx_pwm 0 16000>;
> +		brightness-levels = <0 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +	};
> +
> +	mc13xxx_pwm: pwm {
> +		compatible = "fsl,mc34708-pwm";
> +		mfd = <&pmic>;
> +		#pwm-cells = <2>;
> +	};
> +
> +	reg_lvds_backlight_3v3: lvds-backlight-en {
> +		  compatible = "regulator-fixed";
> +		  pinctrl-names = "default";
> +		  pinctrl-0 = <&pinctrl_reg_lvds_backlight>;
> +		  regulator-name = "lvds-3v3";
> +		  regulator-min-microvolt = <3300000>;
> +		  regulator-max-microvolt = <3300000>;
> +		  gpios = <&gpio4 4 0>;
> +		  enable-active-high;
> +	};
> +
> +	reg_lcd_3v3: lcd-en {
> +		  compatible = "regulator-fixed";
> +		  pinctrl-names = "default";
> +		  pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
> +		  regulator-name = "lcd-3v3";
> +		  regulator-min-microvolt = <3300000>;
> +		  regulator-max-microvolt = <3300000>;
> +		  gpios = <&gpio4 20 0>;
> +		  enable-active-high;
> +	  };

These both look like purely enable signals, in which case it might be
more appropriate to not use regulators, but rather pass them to the
backlight via the enable-gpios property. At least for the backlight
enable pin.

The LCD enable pin is a slightly different story because you can't
currently wire up panels via DT. However since we should be describing
hardware here that's something I think we'll have to live with for now
and not work around the lack of bindings by tweaking things using
existing bindings.

Also the indentation in the above mixes tabs and spaces.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/ddd7d778/attachment.sig>
