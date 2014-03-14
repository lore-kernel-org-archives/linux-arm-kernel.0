From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 14 Mar 2014 16:07:05 -0700
Subject: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com> (Tomasz
 Figa's message of "Mon, 3 Mar 2014 17:02:06 +0100")
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <7h38ikgz1i.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa <tomasz.figa@gmail.com> writes:

> This patch introduces generic code to perform power domain look-up using
> device tree and automatically bind devices to their power domains.
> Generic device tree binding is introduced to specify power domains of
> devices in their device tree nodes.
>
> Backwards compatibility with legacy Samsung-specific power domain
> bindings is provided, but for now the new code is not compiled when
> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
> will change as soon as Exynos power domain code gets converted to use
> the generic framework in further patch.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Reviewed-by: Kevin Hilman <khilman@linaro.org>

The approach and binding both look good to me, other than a few minor
nits on comments and question on the locking below...

[...]

> @@ -2177,3 +2181,297 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  	list_add(&genpd->gpd_list_node, &gpd_list);
>  	mutex_unlock(&gpd_list_lock);
>  }
> +
> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +/*
> + * DEVICE TREE BASED POWER DOMAIN PROVIDERS

why all caps?

[...]

> +/* See of_genpd_get_from_provider(). */
> +static struct generic_pm_domain *__of_genpd_get_from_provider(
> +					struct of_phandle_args *genpdspec)
> +{
> +	struct of_genpd_provider *provider;
> +	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
> +
> +	/* Check if we have such a provider in our array */

I think you want to take the mutex here...

> +	list_for_each_entry(provider, &of_genpd_providers, link) {
> +		if (provider->node == genpdspec->np)
> +			genpd = provider->xlate(genpdspec, provider->data);
> +		if (!IS_ERR(genpd))
> +			break;
> +	}

...and release it here, right?

[...]

> +/*
> + * DEVICE<->DOMAIN BINDING USING DEVICE TREE LOOK-UP

hmm, more yelling?


Otherwise, looks good to me.

Kevin
