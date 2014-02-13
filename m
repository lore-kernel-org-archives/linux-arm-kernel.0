From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Feb 2014 10:47:47 +0000
Subject: [PATCH 4/4] phy: miphy365x: Provide support for the MiPHY356x
 Generic PHY
In-Reply-To: <20140212165454.GF25957@e106331-lin.cambridge.arm.com>
References: <1392220985-28189-1-git-send-email-lee.jones@linaro.org>
 <1392220985-28189-4-git-send-email-lee.jones@linaro.org>
 <20140212165454.GF25957@e106331-lin.cambridge.arm.com>
Message-ID: <20140213104747.GG32508@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> > devices. It has 2 ports which it can use for either; both SATA, both
> > PCIe or one of each in any configuration.
> >
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/phy/Kconfig         |   8 +
> >  drivers/phy/Makefile        |   1 +
> >  drivers/phy/phy-miphy365x.c | 634 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 643 insertions(+)
> >  create mode 100644 drivers/phy/phy-miphy365x.c
> >
> 
> [...]
> 
> > +static int miphy365x_phy_get_base_addr(struct platform_device *pdev,
> > +                                      struct miphy365x_phy *phy, u8 port)
> > +{
> > +       struct resource *res;
> > +       char sata[16];
> > +       char pcie[16];
> 
> Isn't 6 enough for either of these? There are at most two ports IIUC, so
> we only need a single character for the port number.

Yep, being a bit overzealous there, will fix.

<snip>

> > +
> > +       of_property_read_string(np, "st,sata_gen", &sata_gen);
> 
> This wasn't in the binding documentation. It also violates dt style;
> s/_/-/

No problem, will fix.

> Could these not be numbers, or can this not come from elsewhere?
> 
> Or are there some crazy SATA generations to support?

Nope, just [1|2|3] I think. Can be numbers, will fix.

> > +       if (sata_gen) {
> > +               if (!strcmp(sata_gen, "gen3"))
> > +                       phy_dev->sata_gen = SATA_GEN3;
> > +               else if (!strcmp(sata_gen, "gen2"))
> > +                       phy_dev->sata_gen = SATA_GEN2;
> > +       }
> > +
> > +       phy_dev->pcie_tx_pol_inv =
> > +               of_property_read_bool(np, "st,pcie_tx_pol_inv");
> > +
> > +       phy_dev->sata_tx_pol_inv =
> > +               of_property_read_bool(np, "st,sata_tx_pol_inv");
> 
> Likewise for both of these on the first two points.

1. Roger will fix.

2. Not probeable I'm afraid.

> > +
> > +       return 0;
> > +}
> > +
> > +static int miphy365x_phy_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct miphy365x_dev *phy_dev;
> > +       struct device *dev = &pdev->dev;
> > +       struct phy_provider *provider;
> > +       u8 port;
> > +       int ret;
> > +
> > +       if (!np) {
> > +               dev_err(dev, "No DT found\n");
> 
> s/DT/node/ ?

s/DT/DT node/

Will fix, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
