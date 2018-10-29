From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 29 Oct 2018 12:43:19 +0100
Subject: [PATCH V8 5/5] firmware: imx: add SCU power domain driver
In-Reply-To: <1540739690-23750-6-git-send-email-aisheng.dong@nxp.com>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
 <1540739690-23750-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAPDyKFp=ajE5gh5KnfKjm31x1oKDu3O56Yki1CvrTEf0SysS7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

}
> +
> +static struct imx_sc_pm_domain *
> +imx_scu_add_pm_domain(struct device *dev, int idx,
> +                     const struct imx_sc_pd_range *pd_ranges)
> +{
> +       struct imx_sc_pm_domain *sc_pd;
> +       int ret;
> +
> +       sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
> +       if (!sc_pd)
> +               return ERR_PTR(-ENOMEM);
> +
> +       sc_pd->rsrc = pd_ranges->rsrc + idx;
> +       sc_pd->pd.power_off = imx_sc_pd_power_off;
> +       sc_pd->pd.power_on = imx_sc_pd_power_on;

So, this means you are going to register one genpd per device (one for
each uart, pwm etc), but there is actually a better option.

What you seems to be needing is a way to "power on/off" devices,
rather than the PM domain. Right? The PM domain, is managed internally
by the FW, no?

In any case, it looks like what you should do is to implement the
->attach|detach_dev() callback for the genpd and use the regular
of_genpd_add_provider_simple(). From within the ->attach_dev(), you
should get the OF node for the device that is being attached and then
parse the power-domain cell containing the "resource id" and store
that in the per device struct generic_pm_domain_data (we have void
pointer there for storing these kind of things).

Additionally, you need to implement the ->stop() and ->start()
callbacks of genpd, which is where you "power on/off" devices, rather
than using the above ->power_on|off() callbacks.

Please have a look a drivers/soc/ti/ti_sci_pm_domains.c. Apologize, I
should have pointed you towards that reference already in the earlier
version.

> +
> +       if (pd_ranges->postfix)
> +               snprintf(sc_pd->name, sizeof(sc_pd->name),
> +                        "%s%i", pd_ranges->name, idx);
> +       else
> +               snprintf(sc_pd->name, sizeof(sc_pd->name),
> +                        "%s", pd_ranges->name);
> +
> +       sc_pd->pd.name = sc_pd->name;
> +
> +       if (sc_pd->rsrc >= IMX_SC_R_LAST) {
> +               dev_warn(dev, "invalid pd %s rsrc id %d found",
> +                        sc_pd->name, sc_pd->rsrc);
> +
> +               devm_kfree(dev, sc_pd);
> +               return NULL;
> +       }
> +
> +       ret = pm_genpd_init(&sc_pd->pd, NULL, true);
> +       if (ret) {
> +               dev_warn(dev, "failed to init pd %s rsrc id %d",
> +                        sc_pd->name, sc_pd->rsrc);
> +               devm_kfree(dev, sc_pd);
> +               return NULL;
> +       }
> +
> +       return sc_pd;
> +}

[...]

Kind regards
Uffe
