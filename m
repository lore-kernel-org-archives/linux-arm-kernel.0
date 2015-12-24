From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 24 Dec 2015 13:33:22 -0300
Subject: [PATCH v2 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
In-Reply-To: <1450971335-15961-4-git-send-email-uri.mashiach@compulab.co.il>
References: <1450971335-15961-1-git-send-email-uri.mashiach@compulab.co.il>
 <1450971335-15961-4-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <CABxcv=kjwE2JJ_NDWEF7goHaYpsbP5gMV4P_bHdwyj5iDk-SqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uri,

On Thu, Dec 24, 2015 at 12:35 PM, Uri Mashiach
<uri.mashiach@compulab.co.il> wrote:
> Device tree modifications:
> - Pinmux for SPI0 and WiFi GPIOs.
> - SPI0 node with wlcore as a child node.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
> Acked-by: Igor Grinberg <grinberg@complab.co.il>
> ---
> v1 -> v2: replace interrupts and interrupt-parent with interrupts-extended.
>
>  arch/arm/boot/dts/am335x-cm-t335.dts | 57 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
> index 42e9b66..31f8371 100644
> --- a/arch/arm/boot/dts/am335x-cm-t335.dts
> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
> @@ -11,6 +11,7 @@
>  /dts-v1/;
>
>  #include "am33xx.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
>         model = "CompuLab CM-T335";
> @@ -40,6 +41,15 @@
>                 regulator-max-microvolt = <3300000>;
>         };
>
> +       /* Regulator for WiFi */
> +       vwlan_fixed: fixedregulator at 2 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vwlan_fixed";
> +               gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>; /* gpio0_20 */
> +               enable-active-high;
> +               regulator-boot-off;
> +       };
> +
>         backlight {
>                 compatible = "pwm-backlight";
>                 pwms = <&ecap0 0 50000 0>;
> @@ -50,7 +60,10 @@
>
>  &am33xx_pinmux {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&bluetooth_pins>;
> +       pinctrl-0 = <
> +                 &bluetooth_pins
> +                 &wifi_pins
> +       >;

The pinctrl lines should be in the device node that needs the pin
muxing (unless there isn't a device node) so I think is better if you
mofe the pinctrl-0 = <&wifi_pins> to the wlcore dev node.

Best regards,
Javier
