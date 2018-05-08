From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 8 May 2018 21:15:52 +0200
Subject: [PATCH 2/2] soc: imx: add SCU power domains driver
In-Reply-To: <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
References: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
 <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAPDyKFowdpxwNMmDjdD3qcqnAcQZA9-MYWnTcZL-oSbwg8WYMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +
> +static int __init imx_sc_init_pm_domains(void)
> +{
> +       struct generic_pm_domain *pd;
> +       struct device_node *np;
> +       sc_err_t sci_err;
> +
> +       if (!of_machine_is_compatible("fsl,imx8qxp"))
> +               return 0;
> +
> +       sci_err = sc_ipc_get_handle(&pm_ipc_handle);
> +       if (sci_err != SC_ERR_NONE) {
> +               pr_err("imx_sc_pd: can't get sc ipc handle\n");
> +               return -ENODEV;
> +       }
> +
> +       for_each_matching_node(np, imx_sc_pm_domain_of_match) {
> +               pd = imx_sc_pm_add_one_domain(np, NULL);
> +               if (!IS_ERR(pd))
> +                       imx_sc_pm_add_subdomains(np, pd);
> +       }

Perhaps using of_genpd_add_subdomain() may help here and possibly
could avoid some open coding!?

> +
> +       return 0;
> +}
> +early_initcall(imx_sc_init_pm_domains);

Otherwise this looks good to me!

Kind regards
Uffe
