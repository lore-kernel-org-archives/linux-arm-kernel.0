From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 02 Sep 2015 11:28:13 -0700
Subject: [PATCH v17 3/4] soc: rockchip: power-domain: Add power domain
 driver
In-Reply-To: <1441184380-13827-4-git-send-email-wxt@rock-chips.com> (Caesar
 Wang's message of "Wed, 2 Sep 2015 16:59:39 +0800")
References: <1441184380-13827-1-git-send-email-wxt@rock-chips.com>
 <1441184380-13827-4-git-send-email-wxt@rock-chips.com>
Message-ID: <7hbndkptfm.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar Wang <wxt@rock-chips.com> writes:

> This driver is found on RK3288 SoCs.
>
> In order to meet high performance and low power requirements, a power
> management unit is designed or saving power when RK3288 in low power
> mode.
> The RK3288 PMU is dedicated for managing the power of the whole chip.
>
> PMU can work in the Low Power Mode by setting bit[0] of PMU_PWRMODE_CON
> register. After setting the register, PMU would enter the Low Power mode.
> In the low power mode, pmu will auto power on/off the specified power
> domain, send idle req to specified power domain, shut down/up pll and
> so on. All of above are configurable by setting corresponding registers.
>
> Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

[...]

> +static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
> +{
> +	int i;
> +
> +	for (i = 0; i < pd->num_clks; i++) {
> +		clk_unprepare(pd->clks[i]);
> +		clk_put(pd->clks[i]);
> +	}


You don't set pd->num_clks = 0 here, which means other places that
iterate over the clocks might race with this and try to use clocks that
have been unprepared/put.

This might be over-paranoid, but in particular, this could race with
rockchip_pd_power().

Also not setting the pd->num_clks to zero would be a problem for a
power-controller that is configured as a module which could be unloaded
and reloaded (I know that doesn't really work now, but it will
eventually, I hope.)

Maybe use the mutex here?  It should at least protect the zeroing of
pm->num_clks.

Kevin
