From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Oct 2014 22:12:28 +0100
Subject: [PATCH 1/2] ARM: socfpga: Add driver for the L3 interconnect
In-Reply-To: <20141029205103.GF10262@pengutronix.de>
References: <1414582436-12772-1-git-send-email-s.trumtrar@pengutronix.de>
 <alpine.DEB.2.02.1410291521290.29374@atx-linux-37>
 <20141029205103.GF10262@pengutronix.de>
Message-ID: <20141029211228.GS8316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steffen,

On Wed, Oct 29, 2014 at 09:51:03PM +0100, Steffen Trumtrar wrote:
> > > +
> > > +int socfpga_l3nic_regmap_by_phandle(struct device_node *np,
> > > +				    struct regmap **regmap,
> > > +				    const char *name)
> > > +{
> > 
> > This could return the regmap or ERR_PTR(-ENODEV) and just
> > have the np and name parameter, similar to 
> > syscon_regmap_lookup_by_phandle.
> >
> 
> I wanted to do that, but I also want to propagate the return
> value of socfpga_gpv_device_by_phandle and this doesn't
> seem to work than. Open for suggestions, though.
Doesn't the following work:

	struct regmap *socfpga_l3nic_regmap_by_phandle(struct device_node *np,
						       const char *name)
	{
		struct socfpga_l3nic *l3nic;
		struct platform_device *pdev;

		pdev = socfpga_gpv_device_by_phandle(np, name);
		if (!pdev)
			/* it's wrong to apply ERR_PTR to NULL */
			return ERR_PTR(-ENODEV);

		l3nic = dev_get_drvdata(&pdev->dev);
		if (!l3nic)
			return ERR_PTR(-EINVAL);

		/* do you need to check l3nic->regmap for being != NULL? */
		return l3nic->regmap;
	}

?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
