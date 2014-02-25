From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Feb 2014 22:16:14 -0800
Subject: [PATCH] clk: Correct handling of NULL clk in __clk_{get, put}
In-Reply-To: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
References: <1389096223-23934-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140225061614.22529.61524@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2014-01-07 04:03:43)
> Ensure clk->kref is dereferenced only when clk is not NULL.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Taken into clk-fixes toward -rc5.

Thanks!
Mike

> ---
> Hi Sachin,
> 
> please try if this patch fixes the exyno5420 boot crash.
> 
> Thanks,
> Sylwester
> 
>  drivers/clk/clk.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e3e0327..a1fe86f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2179,24 +2179,25 @@ EXPORT_SYMBOL_GPL(devm_clk_unregister);
>   */
>  int __clk_get(struct clk *clk)
>  {
> -       if (clk && !try_module_get(clk->owner))
> -               return 0;
> +       if (clk) {
> +               if (!try_module_get(clk->owner))
> +                       return 0;
> 
> -       kref_get(&clk->ref);
> +               kref_get(&clk->ref);
> +       }
>         return 1;
>  }
> 
>  void __clk_put(struct clk *clk)
>  {
> -       if (WARN_ON_ONCE(IS_ERR(clk)))
> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>                 return;
> 
>         clk_prepare_lock();
>         kref_put(&clk->ref, __clk_release);
>         clk_prepare_unlock();
> 
> -       if (clk)
> -               module_put(clk->owner);
> +       module_put(clk->owner);
>  }
> 
>  /***        clk rate change notifiers        ***/
> --
> 1.7.9.5
> 
