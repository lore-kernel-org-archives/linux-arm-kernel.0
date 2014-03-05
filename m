From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 5 Mar 2014 18:37:17 +0000
Subject: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140305183717.GD23149@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 04:02:06PM +0000, Tomasz Figa wrote:

[...]

> +/**
> + * genpd_bind_domain - Bind device to its power domain using Device Tree.
> + * @dev: Device to bind to its power domain.
> + *
> + * Tries to parse power domain specifier from device's OF node and if succeeds
> + * attaches the device to retrieved power domain.
> + *
> + * Returns 0 on success or negative error code otherwise.
> + */
> +int genpd_bind_domain(struct device *dev)
> +{
> +       struct of_phandle_args pd_args;
> +       struct generic_pm_domain *pd;
> +       int ret;
> +
> +       if (!dev->of_node)
> +               return 0;

Returning 0 (ie success) is deliberate here right ? It is a bit misleading
but I can see why (if a device has no backing DT node, it is up to
platform code to bind it). Probably deserves a comment.

> +
> +       ret = of_parse_phandle_with_args(dev->of_node, "power-domain",
> +                                       "#power-domain-cells", 0, &pd_args);
> +       if (ret < 0) {
> +               if (ret != -ENOENT)
> +                       return ret;
> +
> +               /*
> +                * Try legacy Samsung-specific bindings
> +                * (for backwards compatibility of DT ABI)
> +                */
> +               pd_args.args_count = 0;
> +               pd_args.np = of_parse_phandle(dev->of_node,
> +                                               "samsung,power-domain", 0);
> +               if (!pd_args.np)
> +                       return 0;

Same here.

> +       }
> +
> +       pd = of_genpd_get_from_provider(&pd_args);
> +       if (IS_ERR(pd)) {
> +               if (PTR_ERR(pd) != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to find power domain: %ld\n",
> +                               PTR_ERR(pd));
> +               return PTR_ERR(pd);
> +       }
> +
> +       dev_dbg(dev, "adding to power domain %s\n", pd->name);
> +
> +       while (1) {
> +               ret = pm_genpd_add_device(pd, dev);
> +               if (ret != -EAGAIN)
> +                       break;
> +               cond_resched();
> +       }
> +
> +       if (ret < 0) {
> +               dev_err(dev, "failed to add to power domain %s: %d",
> +                       pd->name, ret);
> +               return ret;
> +       }
> +
> +       pm_genpd_dev_need_restore(dev, true);
> +
> +       return 0;
> +}
> +
> +/**
> + * genpd_unbind_domain - Unbind device from its power domain.
> + * @dev: Device to unbind from its power domain.
> + *
> + * Unbinds device from power domain previously bound to it.
> + *
> + * Returns 0 on success or negative error code otherwise.
> + */
> +int genpd_unbind_domain(struct device *dev)
> +{
> +       struct generic_pm_domain *pd = dev_to_genpd(dev);
> +       int ret;
> +
> +       if (!dev->of_node || IS_ERR(pd))
> +               return 0;

And here.

Thanks for posting it,
Lorenzo
