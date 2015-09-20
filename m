From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 20 Sep 2015 22:46:56 +0800
Subject: [PATCH 5/5] ARM: dts: sun5i: Add backlight node to
 sun5i-q8-common.dtsi
In-Reply-To: <1442752251-20744-6-git-send-email-hdegoede@redhat.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
 <1442752251-20744-6-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66Bg60p8T3dzF6ymo-rTEMK4yUVZsuaOjCXapPBQRn6eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2015 at 8:30 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> All A13 based q8 formfactor tablets use the same backlight setup, add
> a backlight devicetree node for controlling the backlight on these devices.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i-q8-common.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
> index 0641d68..76a5204 100644
> --- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
> +++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
> @@ -41,11 +41,22 @@
>   */
>  #include "sunxi-q8-common.dtsi"
>
> +#include <dt-bindings/pwm/pwm.h>
> +
>  / {
>         aliases {
>                 serial0 = &uart1;
>         };
>
> +       backlight: backlight {
> +               compatible = "pwm-backlight";
> +               pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> +               brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
> +               default-brightness-level = <8>;
> +               /* TODO: backlight uses axp gpio1 as enable pin */
> +               /* TODO: backlight is powered by AXP209 DCDC1SW */

There's no DCDC1SW on AXP209. The reference design shows the backlight
regulator is powered directly from IPSOUT, but the PWM pullup is powered
by LCD-VCC, which itself is enabled by AXP209 GPIO0.

Would that be the case, or maybe closer, given we don't have schematics?


Regards
ChenYu

> +       };
> +
>         chosen {
>                 stdout-path = "serial0:115200n8";
>         };
> --
> 2.4.3
>
