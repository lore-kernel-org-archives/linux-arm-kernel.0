From: mturquette@linaro.org (Michael Turquette)
Date: Wed, 29 Jul 2015 18:02:13 -0700
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20150730010213.642.10831@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

+ linux-clk ml

Quoting Lee Jones (2015-07-22 06:04:13)
> These new API calls will firstly provide a mechanisms to tag a clock as
> critical and secondly allow any knowledgeable driver to (un)gate clocks,
> even if they are marked as critical.
> 
> Suggested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/clk.c            | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk-provider.h |  2 ++
>  include/linux/clk.h          | 30 +++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 61c3fc5..486b1da 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -46,6 +46,21 @@ static struct clk_core *clk_core_lookup(const char *name);
>  
>  /***    private data structures    ***/
>  
> +/**
> + * struct critical -   Provides 'play' over critical clocks.  A clock can be
> + *                     marked as critical, meaning that it should not be
> + *                     disabled.  However, if a driver which is aware of the
> + *                     critical behaviour wants to control it, it can do so
> + *                     using clk_enable_critical() and clk_disable_critical().
> + *
> + * @enabled    Is clock critical?  Once set, doesn't change
> + * @leave_on   Self explanatory.  Can be disabled by knowledgeable drivers

Not self explanatory. I need this explained to me. What does leave_on
do? Better yet, what would happen if leave_on did not exist?

> + */
> +struct critical {
> +       bool enabled;
> +       bool leave_on;
> +};
> +
>  struct clk_core {
>         const char              *name;
>         const struct clk_ops    *ops;
> @@ -75,6 +90,7 @@ struct clk_core {
>         struct dentry           *dentry;
>  #endif
>         struct kref             ref;
> +       struct critical         critical;
>  };
>  
>  struct clk {
> @@ -995,6 +1011,10 @@ static void clk_core_disable(struct clk_core *clk)
>         if (WARN_ON(clk->enable_count == 0))
>                 return;
>  
> +       /* Refuse to turn off a critical clock */
> +       if (clk->enable_count == 1 && clk->critical.leave_on)
> +               return;

How do we get to this point? clk_enable_critical actually calls
clk_enable, thus incrementing the enable_count. The only time that we
could hit the above case is if,

a) there is an imbalance in clk_enable and clk_disable calls. If this is
the case then the drivers need to be fixed. Or better yet some
infrastructure to catch that, now that we have per-user struct clk
cookies.

b) a driver knowingly calls clk_enable_critical(foo) and then regular,
old clk_disable(foo). But why would a driver do that?

It might be that I am missing the point here, so please feel free to
clue me in.

Regards,
Mike

> +
>         if (--clk->enable_count > 0)
>                 return;
>  
> @@ -1037,6 +1057,13 @@ void clk_disable(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_disable);
>  
> +void clk_disable_critical(struct clk *clk)
> +{
> +       clk->core->critical.leave_on = false;
> +       clk_disable(clk);
> +}
> +EXPORT_SYMBOL_GPL(clk_disable_critical);
> +
>  static int clk_core_enable(struct clk_core *clk)
>  {
>         int ret = 0;
> @@ -1100,6 +1127,15 @@ int clk_enable(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);
>  
> +int clk_enable_critical(struct clk *clk)
> +{
> +       if (clk->core->critical.enabled)
> +               clk->core->critical.leave_on = true;
> +
> +       return clk_enable(clk);
> +}
> +EXPORT_SYMBOL_GPL(clk_enable_critical);
> +
>  static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
>                                                 unsigned long rate,
>                                                 unsigned long min_rate,
> @@ -2482,6 +2518,15 @@ fail_out:
>  }
>  EXPORT_SYMBOL_GPL(clk_register);
>  
> +void clk_init_critical(struct clk *clk)
> +{
> +       struct critical *critical = &clk->core->critical;
> +
> +       critical->enabled = true;
> +       critical->leave_on = true;
> +}
> +EXPORT_SYMBOL_GPL(clk_init_critical);
> +
>  /*
>   * Free memory allocated for a clock.
>   * Caller must hold prepare_lock.
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 5591ea7..15ef8c9 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -563,6 +563,8 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
>  void clk_unregister(struct clk *clk);
>  void devm_clk_unregister(struct device *dev, struct clk *clk);
>  
> +void clk_init_critical(struct clk *clk);
> +
>  /* helper functions */
>  const char *__clk_get_name(struct clk *clk);
>  struct clk_hw *__clk_get_hw(struct clk *clk);
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 8381bbf..9807f3b 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -231,6 +231,19 @@ struct clk *devm_clk_get(struct device *dev, const char *id);
>  int clk_enable(struct clk *clk);
>  
>  /**
> + * clk_enable_critical - inform the system when the clock source should be
> + *                      running, even if clock is critical.
> + * @clk: clock source
> + *
> + * If the clock can not be enabled/disabled, this should return success.
> + *
> + * May be called from atomic contexts.
> + *
> + * Returns success (0) or negative errno.
> + */
> +int clk_enable_critical(struct clk *clk);
> +
> +/**
>   * clk_disable - inform the system when the clock source is no longer required.
>   * @clk: clock source
>   *
> @@ -247,6 +260,23 @@ int clk_enable(struct clk *clk);
>  void clk_disable(struct clk *clk);
>  
>  /**
> + * clk_disable_critical - inform the system when the clock source is no
> + *                       longer required, even if clock is critical.
> + * @clk: clock source
> + *
> + * Inform the system that a clock source is no longer required by
> + * a driver and may be shut down.
> + *
> + * May be called from atomic contexts.
> + *
> + * Implementation detail: if the clock source is shared between
> + * multiple drivers, clk_enable_critical() calls must be balanced
> + * by the same number of clk_disable_critical() calls for the clock
> + * source to be disabled.
> + */
> +void clk_disable_critical(struct clk *clk);
> +
> +/**
>   * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
>   *               This is only valid once the clock source has been enabled.
>   * @clk: clock source
> -- 
> 1.9.1
> 
