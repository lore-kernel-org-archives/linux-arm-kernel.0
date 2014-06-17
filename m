From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 17 Jun 2014 15:33:05 -0700
Subject: [PATCH] clkdev: Don't print errors on probe defer
In-Reply-To: <1402702591-21087-1-git-send-email-sboyd@codeaurora.org>
References: <1402702591-21087-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140617223305.32686.15540@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-06-13 16:36:31)
> This error message can spam the logs if you have lots of probe
> deferals due to missing clocks. Just silence the error in this
> case because the driver should try again later.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Looks OK to me. Russell?

Regards,
Mike

> ---
>  drivers/clk/clkdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index f890b901c6bc..da4bda8b7fc7 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -101,8 +101,9 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
>                 if (!IS_ERR(clk))
>                         break;
>                 else if (name && index >= 0) {
> -                       pr_err("ERROR: could not get clock %s:%s(%i)\n",
> -                               np->full_name, name ? name : "", index);
> +                       if (PTR_ERR(clk) != -EPROBE_DEFER)
> +                               pr_err("ERROR: could not get clock %s:%s(%i)\n",
> +                                       np->full_name, name ? name : "", index);
>                         return clk;
>                 }
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
