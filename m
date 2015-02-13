From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Feb 2015 12:49:04 +0100
Subject: [PATCH 04/14] reset: Add reset_controller_of_init() function
In-Reply-To: <1423763164-5606-5-git-send-email-mcoquelin.stm32@gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-5-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1423828144.4182.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Donnerstag, den 12.02.2015, 18:45 +0100 schrieb Maxime Coquelin:
> Some platforms need to initialize the reset controller before the timers.
> 
> This patch introduces a reset_controller_of_init() function that can be
> called before the timers intialization.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  drivers/reset/core.c              | 20 ++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h |  4 +++-
>  include/linux/reset-controller.h  |  6 ++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 7955e00..18ee579 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -86,6 +86,26 @@ void reset_controller_unregister(struct reset_controller_dev *rcdev)
>  }
>  EXPORT_SYMBOL_GPL(reset_controller_unregister);
>  
> +extern struct of_device_id __reset_ctrl_of_table[];
> +
> +static const struct of_device_id __reset_ctrl_of_table_sentinel
> +	__used __section(__reset_ctrl_of_table_end);
> +
> +void __init reset_controller_of_init(void)

The patch looks fine to me, but this function is missing a kerneldoc
comment.

> +{
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +	of_init_fn_1 init_func;
> +
> +	for_each_matching_node_and_match(np, __reset_ctrl_of_table, &match) {
> +		if (!of_device_is_available(np))
> +			continue;
> +
> +		init_func = match->data;
> +		init_func(np);
> +	}
> +}
> +
>  /**
>   * reset_control_reset - reset the controlled device
>   * @rstc: reset controller

regards
Philipp
