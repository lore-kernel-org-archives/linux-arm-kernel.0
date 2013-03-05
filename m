From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 6 Mar 2013 08:48:33 +0900
Subject: [PATCH v3 2/3] ARM: dts: Add i2c-arbitrator bus for
 exynos5250-snow
In-Reply-To: <1360957573-864-2-git-send-email-dianders@chromium.org>
References: <1360887677-20758-1-git-send-email-dianders@chromium.org>
 <1360957573-864-1-git-send-email-dianders@chromium.org>
 <1360957573-864-2-git-send-email-dianders@chromium.org>
Message-ID: <CAHfPSqAtxjYV79VvQZDLtzfyRxkYoMEc4=S2fN=KRNtYOEQ7ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2013 04:46, Doug Anderson <dianders@chromium.org> wrote:
> We need to use the i2c-arbitrator to talk to any of the devices on i2c
> bus 4 on exynos5250-snow so that we don't confuse the embedded
> controller (EC).  Add the i2c-arbitrator to the device tree.  As we
> add future devices (keyboard, sbs, tps65090) we'll add them on top of
> this.
>
> The arbitrated bus is numbered 104 simply as a convenience to make it
> easier for people poking around to guess that it might have something
> to do with the physical bus 4.
>
> The addition is split between the cros5250-common and the snow device
> tree file since not all cros5250-class devices use arbitration.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
Tested-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
The patch set [v3] is tested on snow with test case which uses i2c-4 from both
EC and AP side continuously for a more than a couple of minutes.

> ---
> Changes in v3: None
> Changes in v2:
> - Use new device tree property names / compatible string.
> - Include that the GPIOs for arbitration are active low.
>
>  arch/arm/boot/dts/cros5250-common.dtsi |  5 ++++-
>  arch/arm/boot/dts/exynos5250-snow.dts  | 25 +++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
> index 46c0980..f451375 100644
> --- a/arch/arm/boot/dts/cros5250-common.dtsi
> +++ b/arch/arm/boot/dts/cros5250-common.dtsi
> @@ -58,7 +58,10 @@
>         };
>
>         i2c at 12CA0000 {
> -               status = "disabled";
> +               samsung,i2c-sda-delay = <100>;
> +               samsung,i2c-max-bus-freq = <66000>;
> +               gpios = <&gpa2 0 3 3 0>,
> +                       <&gpa2 1 3 3 0>;
>         };
>
>         i2c at 12CB0000 {
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 17dd951..d2d4b48 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -16,6 +16,10 @@
>         model = "Google Snow";
>         compatible = "google,snow", "samsung,exynos5250";
>
> +       aliases {
> +               i2c104 = &i2c_104;
> +       };
> +
>         gpio-keys {
>                 compatible = "gpio-keys";
>
> @@ -29,6 +33,27 @@
>                 };
>         };
>
> +       i2c-arbitrator {
> +               compatible = "i2c-arbitrator-cros-ec";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c-parent = <&{/i2c@12CA0000}>;
> +
> +               ap-claim-gpio = <&gpf0 3 1 0x10000 0>;
> +               ec-claim-gpio = <&gpe0 4 0 0x10003 0>;
> +               slew-delay-us = <10>;
> +               wait-retry-us = <3000>;
> +               wait-free-us = <50000>;
> +
> +               /* Use ID 104 as a hint that we're on physical bus 4 */
> +               i2c_104: i2c at 0 {
> +                       reg = <0>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +       };
> +
>         /*
>          * On Snow we've got SIP WiFi and so can keep drive strengths low to
>          * reduce EMI.
> --
> 1.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--
Shine bright,
(: Nav :)
