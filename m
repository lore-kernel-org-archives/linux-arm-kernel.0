From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 23 Mar 2017 15:35:49 +0100
Subject: [PATCH v7 2/2] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <20170324062451.GB12604@b29396-OptiPlex-7040>
References: <20170321145004.21265-1-andrew.smirnov@gmail.com>
 <20170321145004.21265-3-andrew.smirnov@gmail.com>
 <20170324062451.GB12604@b29396-OptiPlex-7040>
Message-ID: <1490279749.29056.33.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

Am Freitag, den 24.03.2017, 14:24 +0800 schrieb Dong Aisheng:
[...]
> > +static struct platform_driver imx7_pgc_domain_driver = {
> > +	.driver = {
> > +		.name = "imx7-pgc",
> > +	},
> > +	.probe    = imx7_pgc_domain_probe,
> > +	.remove   = imx7_pgc_domain_remove,
> > +	.id_table = imx7_pgc_domain_id,
> > +};
> > +builtin_platform_driver(imx7_pgc_domain_driver)
> 
> Again, i have a fundamental question about this patch implementation
> that why we choose above way to register the power domain?
> 
> I'm sorry that i did not know too much history.
> Would you guys please help share some information?
> 
> Because AFAIK this way will register each domain as a power domain
> provider which is a bit violate the real HW and current power domain
> framework design. And it is a bit more complicated to use than before.
> 
> IMHO i would rather prefer the old traditional and simpler way that one
> provider (GPC) supplies multiple domains (PCIE/MIPI/HSIC PHY domain)
> than this patch does.
> 
> However, i might be wrong. Please help to clear.

This way we can properly describe each power domain with the regulator
supplying the domain and the clocks of the devices inside the domain in
the device tree.

This is needed as for the upstream version we are controlling the
regulator from the GPC driver, as opposed to the downstream version,
where each device has to implement the regulator handling and power
up/down sequencing.

See the rationale in the commits adding the multidomain support to the
i.MX6 GPC.

Regards,
Lucas
