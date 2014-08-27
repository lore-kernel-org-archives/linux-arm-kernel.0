From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Aug 2014 13:54:10 -0700
Subject: [PATCH v7 7/8] clk: per-user clock accounting for debug
In-Reply-To: <1408375833-10703-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408375833-10703-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20140827205410.5251.27621@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomeu Vizoso (2014-08-18 08:30:32)
> @@ -936,10 +939,25 @@ EXPORT_SYMBOL_GPL(clk_provider_disable);
>   */
>  void clk_disable(struct clk *clk_user)
>  {
> +       struct clk_core *clk;
> +       unsigned long flags;
> +
>         if (IS_ERR_OR_NULL(clk_user))
>                 return;
>  
> -       clk_provider_disable(clk_to_clk_core(clk_user));
> +       clk = clk_to_clk_core(clk_user);
> +
> +       flags = clk_enable_lock();
> +       if (!WARN(clk_user->enable_count == 0,
> +                 "incorrect disable clk dev %s con %s last disabler %pF\n",
> +                 clk_user->dev_id, clk_user->con_id, clk_user->last_disable)) {
> +
> +               clk_user->last_disable = __builtin_return_address(0);
> +               clk_user->enable_count--;
> +
> +               __clk_disable(clk);
> +       }
> +       clk_enable_unlock(flags);
>  }
>  EXPORT_SYMBOL_GPL(clk_disable);
>  
> @@ -1000,10 +1018,22 @@ EXPORT_SYMBOL_GPL(clk_provider_enable);
>   */
>  int clk_enable(struct clk *clk_user)
>  {
> +       struct clk_core *clk;
> +       unsigned long flags;
> +       int ret;
> +
>         if (!clk_user)
>                 return 0;
>  
> -       return clk_provider_enable(clk_to_clk_core(clk_user));
> +       clk = clk_to_clk_core(clk_user);
> +
> +       flags = clk_enable_lock();
> +       ret = __clk_enable(clk);
> +       if (!ret)
> +               clk_user->enable_count++;
> +       clk_enable_unlock(flags);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);
>  

While we're at it, why not do per-using accounting for clk_{un}prepare?

Regards,
Mike
