From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 25 Aug 2016 09:27:39 +0200
Subject: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
In-Reply-To: <20160819235653.26355-4-nm@ti.com>
References: <20160819235653.26355-1-nm@ti.com>
 <20160819235653.26355-4-nm@ti.com>
Message-ID: <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Jon

[...]

> +
> +static int ti_sci_pm_domains_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct ti_sci_genpd_data *ti_sci_genpd;
> +
> +       ti_sci_genpd = devm_kzalloc(dev, sizeof(*ti_sci_genpd), GFP_KERNEL);
> +       if (!ti_sci_genpd)
> +               return -ENOMEM;
> +
> +       ti_sci_genpd->ti_sci = devm_ti_sci_get_handle(dev);
> +       if (IS_ERR(ti_sci_genpd->ti_sci))
> +               return PTR_ERR(ti_sci_genpd->ti_sci);
> +
> +       ti_sci_genpd->dev = dev;
> +
> +       INIT_LIST_HEAD(&ti_sci_genpd->pd_list);
> +       mutex_init(&ti_sci_genpd->pd_list_mutex);
> +
> +       return __of_genpd_add_provider(np, of_ti_sci_genpd_xlate_onecell,
> +                                      ti_sci_genpd);

Jon Hunter are working on adding robust method to be able to remove
initialized genpds [1].

In that series we intend to remove the __of_genpd_add_provider() API,
and instead only have of_genpd_add_provider_onecell() and
of_genpd_add_provider_simple(). Could you please convert to use any of
these APIs instead?

Kind regards
Uffe

[1]
http://www.spinics.net/lists/arm-kernel/msg524151.html
