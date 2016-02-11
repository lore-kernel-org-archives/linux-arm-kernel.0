From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 10 Feb 2016 16:43:27 -0800
Subject: [PATCH 2/3] clk: WARN_ON about to disable a critical clock
In-Reply-To: <1453127331-20616-3-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20160211004327.26445.27416@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2016-01-18 06:28:50)
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me.

Regards,
Mike

> ---
>  drivers/clk/clk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 835cb85..178b364 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -575,6 +575,9 @@ static void clk_core_unprepare(struct clk_core *core)
>         if (WARN_ON(core->prepare_count == 0))
>                 return;
>  
> +       if (WARN_ON(core->prepare_count == 1 && core->flags & CLK_IS_CRITICAL))
> +               return;
> +
>         if (--core->prepare_count > 0)
>                 return;
>  
> @@ -680,6 +683,9 @@ static void clk_core_disable(struct clk_core *core)
>         if (WARN_ON(core->enable_count == 0))
>                 return;
>  
> +       if (WARN_ON(core->enable_count == 1 && core->flags & CLK_IS_CRITICAL))
> +               return;
> +
>         if (--core->enable_count > 0)
>                 return;
>  
> -- 
> 1.9.1
> 
