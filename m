From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Jul 2015 14:28:21 -0700
Subject: [PATCH 2/4] ARM: dts: rockchip: add shared rk3288-veyron files
In-Reply-To: <1436574562-16308-3-git-send-email-heiko@sntech.de>
References: <1436574562-16308-1-git-send-email-heiko@sntech.de>
 <1436574562-16308-3-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=U37Yx8Mqk75_x05zxonvdc3qRMhqp8TyTDPWGHqSuRqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Jul 10, 2015 at 5:29 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> +&rk808 {
> +       vcc11-supply = <&vcc_5v>;
> +
> +       regulators {
> +               vcc33_ccd: LDO_REG8 {
> +                       regulator-name = "vcc33_ccd";
> +                       regulator-always-on;
> +                       regulator-boot-on;
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-state-mem {
> +                               regulator-on-in-suspend;
> +                               regulator-suspend-microvolt = <3300000>;
> +                       };

Technically I think vcc33_ccd can be off since we have
'needs-reset-on-resume' down in the EHCI port (this regulator is for
the USB webcam that's connected to the EHCI port).

...but leaving it on for now seems fine until we get suspend/resume more solid.

> +       gpio-restart {
> +               compatible = "gpio-restart";
> +               gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&ap_warm_reset_h>;
> +               priority = /bits/ 8 <200>;

In downstream Chrome OS tree, the "/bits/ 8" is there.  Not in upstream.

> +&pinctrl {
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-0 = <
> +               /* Common for sleep and wake, but no owners */
> +               &global_pwroff
> +
> +               /* Wake only */
> +               &bt_dev_wake_awake
> +       >;
> +       pinctrl-1 = <
> +               /* Common for sleep and wake, but no owners */
> +               &global_pwroff
> +
> +               /* Sleep only */
> +               &bt_dev_wake_sleep

Optional: the bt_dev_wake_awake and bt_dev_wake_sleep are sorta hacks
that are there till Broadcom gets an LPM driver.  From upstream these
hacks could be safely removed and you'd just notice a 50mW hit in
power in S3.  Since upstream S3 is awful in power anyway, it's
probably worth it to leave the hacks out.


Upon fixing the gpio-restart, you can add my reviewed-by tag.

-Doug
