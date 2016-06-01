From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 1 Jun 2016 19:47:10 +0900
Subject: [RFC PATCH 3/4] PM / devfreq: rockchip: add devfreq driver for
 rk3399 dmc
In-Reply-To: <1464773739-18152-4-git-send-email-hl@rock-chips.com>
References: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
 <1464773739-18152-4-git-send-email-hl@rock-chips.com>
Message-ID: <CAJ0PZbQaPm1YjgAgEzGbPYSzfi7kk5NG=zAj80t4XmBV5MqEqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 6:35 PM, Lin Huang <hl@rock-chips.com> wrote:
> there is dfi controller on rk3399 platform, it can monitor
> ddr load, register this controller to devfreq framework, and
> default to use simple_ondeamnd policy, and do ddr frequency
> scaling base on this result.
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
>  drivers/devfreq/Kconfig                 |   2 +-
>  drivers/devfreq/Makefile                |   1 +
>  drivers/devfreq/rockchip/Kconfig        |  14 +
>  drivers/devfreq/rockchip/Makefile       |   2 +
>  drivers/devfreq/rockchip/rk3399_dmc.c   | 438 ++++++++++++++++++++++++++++++++
>  drivers/devfreq/rockchip/rockchip_dmc.c | 132 ++++++++++
>  include/soc/rockchip/rockchip_dmc.h     |  44 ++++
>  7 files changed, 632 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/devfreq/rockchip/Kconfig
>  create mode 100644 drivers/devfreq/rockchip/Makefile
>  create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c
>  create mode 100644 drivers/devfreq/rockchip/rockchip_dmc.c
>  create mode 100644 include/soc/rockchip/rockchip_dmc.h
>
> +
> +       /* check the rate we get whether correct */
> +       dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);
> +       if (dmcfreq->rate != target_rate) {
> +               dev_err(dev, "get wrong ddr frequency, Request freq %lu,\
> +                       Current freq %lu\n", target_rate, dmcfreq->rate);
> +               regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
> +                                     dmcfreq->volt);

Why do you need to check this and
more importantly, why do you assume that dmvfreq->volt
will be safe in this case? (what if the new dmcfreq->rate is
larger than the old dmcfreq->rate after clk_get_rate?)
Note that you didn't update dmcfreq->volt after clk_get_rate()


> +EXPORT_SYMBOL_GPL(dmc_event);
> +EXPORT_SYMBOL_GPL(rockchip_dmc_enabled);
> +EXPORT_SYMBOL_GPL(rockchip_dmc_enable);
> +EXPORT_SYMBOL_GPL(rockchip_dmc_disable);
> +EXPORT_SYMBOL_GPL(dmc_register_notifier);
> +EXPORT_SYMBOL_GPL(dmc_unregister_notifier);
> +EXPORT_SYMBOL_GPL(rockchip_dmc_get);
> +EXPORT_SYMBOL_GPL(rockchip_dmc_put);

Do you really need to export all these device driver specific
functions? Looks like a design flaw here.



Cheers,
MyungJoo


-- 
MyungJoo Ham, Ph.D.
S/W R&D Center, Samsung Electronics
