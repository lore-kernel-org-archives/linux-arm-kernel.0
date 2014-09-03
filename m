From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 02 Sep 2014 17:13:46 -0700
Subject: [PATCH v8 6/7] clk: Add floor and ceiling constraints to clock
 rates
In-Reply-To: <1409585675-26894-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1409585377-26091-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409585675-26894-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409585675-26894-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20140903001346.5251.47709@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomeu Vizoso (2014-09-01 08:34:34)
> @@ -1633,6 +1636,13 @@ int clk_provider_set_rate(struct clk_core *clk, unsigned long rate)
>         /* prevent racing with updates to the clock topology */
>         clk_prepare_lock();
>  
> +       hlist_for_each_entry(clk_user, &clk->per_user_clks, child_node) {
> +               rate = max(rate, clk_user->floor_constraint);
> +
> +               if (clk_user->ceiling_constraint > 0)
> +                       rate = min(rate, clk_user->ceiling_constraint);

A ceiling_constraint from consumer_A could be less than a
floor_constraint from consumer_B. What should we do in this case?

In the code above the ceiling_constraint will always win. Is that by
design? We should document that behavior in Documentation/clk.txt.

This is the right place to check for the aforementioned corner case,
since we not only care about a single consumer having sane constraints
(e.g. min < max) but also mixing constraints across consumers.

However ...

> +       }
> +
>         /* bail early if nothing to do */
>         if (rate == clk_provider_get_rate(clk))
>                 goto out;
> @@ -1699,6 +1709,24 @@ int clk_set_rate(struct clk *clk_user, unsigned long rate)
>  }
>  EXPORT_SYMBOL_GPL(clk_set_rate);
>  
> +int clk_set_floor_rate(struct clk *clk_user, unsigned long rate)
> +{
> +       struct clk_core *clk = clk_to_clk_core(clk_user);
> +
> +       clk_user->floor_constraint = rate;
> +       return clk_provider_set_rate(clk, clk_provider_get_rate(clk));
> +}
> +EXPORT_SYMBOL_GPL(clk_set_floor_rate);
> +
> +int clk_set_ceiling_rate(struct clk *clk_user, unsigned long rate)
> +{
> +       struct clk_core *clk = clk_to_clk_core(clk_user);
> +
> +       clk_user->ceiling_constraint = rate;
> +       return clk_provider_set_rate(clk, clk_provider_get_rate(clk));
> +}
> +EXPORT_SYMBOL_GPL(clk_set_ceiling_rate);

... we should probably sanity-check constraints here to make sure that
ceiling_rates for a given consumer are higher than floor_constraints for
that same consumer. It's a bit extra overhead but a WARN would probably
be helpful in this case.

Rest of the patch looks good.

Regards,
Mike
