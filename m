From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 13 Jan 2016 12:07:55 -0800
Subject: [PATCH V2 2/4] clk: bcm2835: enable fractional and mash support
In-Reply-To: <1452542157-2387-3-git-send-email-kernel@martin.sperl.org>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
 <1452542157-2387-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160113200755.1168.19225@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Quoting kernel at martin.sperl.org (2016-01-11 11:55:54)
> @@ -1274,9 +1283,50 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
>         struct bcm2835_cprman *cprman = clock->cprman;
>         const struct bcm2835_clock_data *data = clock->data;
>         u32 div = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
> +       u32 ctl, mash;
> +       bool enabled;
> 
> +       spin_lock(&cprman->regs_lock);
> +       /* check if divider is identical, then return */
> +       if (div == cprman_read(cprman, data->div_reg))
> +               goto unlock;
> +
> +       /* it is recommended to only set clock registers when disabled */
> +       ctl = cprman_read(cprman, data->ctl_reg);
> +       enabled = ctl & CM_ENABLE;
> +       if (enabled) {
> +               /* disable clock */
> +               cprman_write(cprman, data->ctl_reg, ctl);

This seems unsafe to me. Any IP block consuming this signal will have
its clock cut without warning!

If you need to enforce this behavior we provide the CLK_SET_RATE_GATE
flag to handle it at the framework level.

Regards,
Mike
