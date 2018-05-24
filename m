From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 24 May 2018 08:37:07 +0000
Subject: [PATCH 2/2] soc: imx: add SCU power domains driver
In-Reply-To: <CAPDyKFowdpxwNMmDjdD3qcqnAcQZA9-MYWnTcZL-oSbwg8WYMg@mail.gmail.com>
References: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
 <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFowdpxwNMmDjdD3qcqnAcQZA9-MYWnTcZL-oSbwg8WYMg@mail.gmail.com>
Message-ID: <AM0PR04MB42114331A1E75B3B90B07E56806A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

Thanks for the review.

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> Sent: Wednesday, May 9, 2018 3:16 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>; Dong Aisheng
> <dongas86@gmail.com>; Sascha Hauer <kernel@pengutronix.de>; Shawn
> Guo <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>;
> dl-linux-imx <linux-imx@nxp.com>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> Kevin Hilman <khilman@kernel.org>; Linux PM <linux-pm@vger.kernel.org>
> Subject: Re: [PATCH 2/2] soc: imx: add SCU power domains driver
> 
> [...]
> 
> > +
> > +static int __init imx_sc_init_pm_domains(void) {
> > +       struct generic_pm_domain *pd;
> > +       struct device_node *np;
> > +       sc_err_t sci_err;
> > +
> > +       if (!of_machine_is_compatible("fsl,imx8qxp"))
> > +               return 0;
> > +
> > +       sci_err = sc_ipc_get_handle(&pm_ipc_handle);
> > +       if (sci_err != SC_ERR_NONE) {
> > +               pr_err("imx_sc_pd: can't get sc ipc handle\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       for_each_matching_node(np, imx_sc_pm_domain_of_match) {
> > +               pd = imx_sc_pm_add_one_domain(np, NULL);
> > +               if (!IS_ERR(pd))
> > +                       imx_sc_pm_add_subdomains(np, pd);
> > +       }
> 
> Perhaps using of_genpd_add_subdomain() may help here and possibly could
> avoid some open coding!?
> 

Thanks for the suggestion. I thought of it a lot and the result is that I'm not sure
If it's quite suitable for i.MX cases. Currently seems there's only one user, Samsung,
 in kernel using that API which takes two struct of_phandle_args as arguments,
parent and child. It looks needs special handling in code before using it, e.g.
register both parent and child domain first, which is somehow not like i.MX flow
of registration. It looks like to me not see much benefits to enforce a big
change to switch to it. Or am I missed anything?

If you have better idea please let me know.

> > +
> > +       return 0;
> > +}
> > +early_initcall(imx_sc_init_pm_domains);
> 
> Otherwise this looks good to me!
> 

Thanks

Regards
Dong Aisheng

> Kind regards
> Uffe
