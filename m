From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Jan 2016 00:23:24 -0800
Subject: [PATCH 2/2] clk: defer clk_gets on orphan clocks
In-Reply-To: <1453385958-11366-1-git-send-email-emilio.lopez@collabora.co.uk>
References: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1453385958-11366-1-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <20160128082324.GG12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21, Emilio L?pez wrote:
> @@ -3059,7 +3069,25 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
>   */
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
>  {
> -	return __of_clk_get_from_provider(clkspec, NULL, __func__);
> +	return __of_clk_get_from_provider(clkspec, NULL, __func__, false);
> +}
> +
> +/**
> + * of_clk_get_from_provider_with_orphans() - Lookup clock from a clock provider
> + * @clkspec: pointer to a clock specifier data structure
> + *
> + * This function looks up a struct clk from the registered list of clock
> + * providers, an input is a clock specifier data structure as returned
> + * from the of_parse_phandle_with_args() function call.
> + *
> + * The difference to of_clk_get_from_provider() is that this function will
> + * also successfully lookup orphan-clocks, as it in some cases may be
> + * necessary to access such orphan-clocks as well.
> + */
> +struct clk *
> +of_clk_get_from_provider_with_orphans(struct of_phandle_args *clkspec)

Dislike. In fact, the whole clk conf approach is odd here. When
we're doing of_clk_init() we do a best effort loop around
parent_ready(), waiting for clk providers to register as long as
we have a clocks property in our provider node. We should do
something similar in the non of_clk_init() case too, because
of_clk_init() isn't special.

Furthermore, the assigned parents and rates feature doesn't need
the clocks that we're assigning parents and rates to to even be
provided or consumed by the provider that's probing, so I'm lost
why we're checking the provider's node for a clocks property. It
would be better to check the assigned-clocks and assigned-parents
properties and make sure that those are all non-orphans. If
they're orphaned, we should delay until another clk provider is
registered. Eventually we'll unstick the orphans and then the
tree can be configured. Running the configuration at the end of
of_clk_init() even if we still can't get the clocks doesn't make
any sense to me.

To be really nice, we could build up a set of configuration
actions (set this parent, set this rate), and run those actions
when we drop the orphan flag. If some clock is orphaned that
we're trying to configure, we can attach the action to a list in
the clk_core structure. Otherwise we'll run the action
immediately. This way, we do a best effort to run as much of the
configuration as possible when the provider is registered the
first time and skip the overhead of cycling through a potentially
long list of provider actions to see if we can run them now. This
last part may be over-engineered though. I'm not sure if we
really have any such scenario today.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
