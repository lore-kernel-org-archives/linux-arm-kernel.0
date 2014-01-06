From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 06 Jan 2014 13:59:27 -0700
Subject: [PATCH] ARM: tegra: Remove 3.3V supply and modem regulators
In-Reply-To: <1389021933-6675-1-git-send-email-treding@nvidia.com>
References: <1389021933-6675-1-git-send-email-treding@nvidia.com>
Message-ID: <52CB192F.2020700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 08:25 AM, Thierry Reding wrote:
> GPIO 1 and 2 of the PMIC are not used for the described purpose, so
> remove them.

As far as I can tell, this patch is correct, since those GPIOs are in
fact used to discharge the rails after disabling them, rather than to
enable/disable the rails.

Equally, these GPIOs affect multiple rails at once, so listing the GPIO
as a property of a single regulator seems wrong either way.

However, PMU_REGEN1 does seem to feed the "EN" pin of U13C1, a DC/DC
switcher for power rail 3.3v_modem, so perhaps there's more going on
here than I see?

In summary, I need Laxman to comment on this and ack the change, and
explain why these GPIOs were listed as regulator enables when it doesn't
seem that they are.

> Note: Removing these makes the work-in-progress eDP support work again.

> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts

> -		vdd_3v3_reg: regulator at 1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "vdd_3v3";
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3300000>;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			enable-active-high;
> -			gpio = <&as3722 1 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		vdd_3v3_modem_reg: regulator at 2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			regulator-name = "vdd-modem-3v3";
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3300000>;
> -			enable-active-high;
> -			gpio = <&as3722 2 GPIO_ACTIVE_HIGH>;
> -		};

Don't you want to simply remove the "enable-active-high" and "gpio"
properties, but leave the regulator definitions present, in case
something wants to reference these fixed(?) rails as their supply?
