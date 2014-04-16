From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 15 Apr 2014 17:54:59 -0700
Subject: [PATCH] ARM: tegra: make Venice's +3.3V_RUN regulator always on
In-Reply-To: <1397600984-25198-1-git-send-email-swarren@wwwdotorg.org>
References: <1397600984-25198-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAL1qeaGek9H74s00T-O7P7F6Uraa9juW=3LCMjTUjCuQCZ0pBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 3:29 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> This regulator supplies power to pretty much everything on the board, so
> it doesn't make sense to allow it to turn off. Mark it boot-on and
> always-on so it doesn't get turned off. Without this, I see issues with
> the eMMC device; it can't be correctly detected during boot.

This actually isn't a complete fix.  +3V3_RUN will still toggle on a
cold boot because the GPIO1_INVERT bit is initialized by the PMIC to
1, but when the regulator core requests the GPIO as an output,
as3722_gpio_direction_output() first sets the output value to 1
(without considering the INVERT bit!) and then clears the invert bit
when setting the mode in as3722_pinctrl_gpio_set_direction().  The
as3722 driver should probably not touch the INVERT bit and instead
just take it into account when setting the GPIO value.

>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-venice2.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
> index c17283c04598..87537f499875 100644
> --- a/arch/arm/boot/dts/tegra124-venice2.dts
> +++ b/arch/arm/boot/dts/tegra124-venice2.dts
> @@ -1060,6 +1060,8 @@
>                         regulator-name = "+3.3V_RUN";
>                         regulator-min-microvolt = <3300000>;
>                         regulator-max-microvolt = <3300000>;
> +                       regulator-always-on;
> +                       regulator-boot-on;
>                         gpio = <&pmic 1 GPIO_ACTIVE_HIGH>;
>                         enable-active-high;
>                         vin-supply = <&vdd_3v3_sys>;
> --
> 1.8.1.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
