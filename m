From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 1 Dec 2017 18:27:14 -0200
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add DRM panel, power-enable and
 backlight support
In-Reply-To: <1512046929-18597-1-git-send-email-marco.franchi@nxp.com>
References: <1512046929-18597-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAOMZO5D4FMcLuGoh8JPRpdXaqPTOGgvWd39OV7qkZqVzptr87A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Subject could be improved to something like: Convert from fbdev to
drm bindings

On Thu, Nov 30, 2017 at 11:02 AM, Marco Franchi <marco.franchi@nxp.com> wrote:
> It is preferred to use the panel compatible string rather than passing
> the LCD timming in the device tree.

Typo: timing

>
> So pass the "sii,43wvf1g" compatible string, a new driver for the Seiko
> Panel, which describes the parallel LCD.

Please remove the "a new driver for the Seiko Panel".

>
> This new driver needs two power supply, so pass 'dvdd-supply' and
> 'avdd-supply', which makes the kernel to turn on the LCD on is own.

I would remove this too.

>
> Also, pass the 'backlight' property as described in
> Documentation/devicetree/bindings/display/panel/simple-panel.txt
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dtsi | 49 ++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> index da81552..3a597a4 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> @@ -24,7 +24,7 @@
>                 reg = <0x80000000 0x40000000>;
>         };
>
> -       backlight {
> +       backlight_display: backlight-display {
>                 compatible = "pwm-backlight";
>                 pwms = <&pwm3 0 5000000>;
>                 brightness-levels = <0 4 8 16 32 64 128 255>;
> @@ -129,6 +129,14 @@
>                         regulator-max-microvolt = <3300000>;
>                         gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
>                 };
> +
> +               reg_lcd_5v: regulator at 7 {
> +                       compatible = "regulator-fixed";
> +                       reg = <7>;
> +                       regulator-name = "lcd-5v0";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +               };

I have sent a patch that removes the regulators from simple-panel.

Please use linux-next when you send a v2.
