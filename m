From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Feb 2014 16:54:54 +0000
Subject: [PATCH 4/4] phy: miphy365x: Provide support for the MiPHY356x
 Generic PHY
In-Reply-To: <1392220985-28189-4-git-send-email-lee.jones@linaro.org>
References: <1392220985-28189-1-git-send-email-lee.jones@linaro.org>
 <1392220985-28189-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20140212165454.GF25957@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 04:03:05PM +0000, Lee Jones wrote:
> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> devices. It has 2 ports which it can use for either; both SATA, both
> PCIe or one of each in any configuration.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/phy/Kconfig         |   8 +
>  drivers/phy/Makefile        |   1 +
>  drivers/phy/phy-miphy365x.c | 634 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 643 insertions(+)
>  create mode 100644 drivers/phy/phy-miphy365x.c
>

[...]

> +static int miphy365x_phy_get_base_addr(struct platform_device *pdev,
> +                                      struct miphy365x_phy *phy, u8 port)
> +{
> +       struct resource *res;
> +       char sata[16];
> +       char pcie[16];

Isn't 6 enough for either of these? There are at most two ports IIUC, so
we only need a single character for the port number.

> +
> +       sprintf(sata, "sata%d", port);
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, sata);
> +       if (!res)
> +               return -ENODEV;
> +
> +       phy->sata = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +       if (!phy->sata)
> +               return -ENOMEM;
> +
> +       sprintf(pcie, "pcie%d", port);
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, pcie);
> +       if (!res)
> +               return -ENODEV;
> +
> +       phy->pcie = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +       if (!phy->pcie)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static int miphy365x_phy_of_probe(struct device_node *np,
> +                                 struct miphy365x_dev *phy_dev)
> +{
> +       const char *sata_gen;
> +
> +       phy_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
> +       if (IS_ERR(phy_dev->regmap)) {
> +               dev_err(phy_dev->dev, "No syscfg phandle specified\n");
> +               return PTR_ERR(phy_dev->regmap);
> +       }
> +
> +       /* Default */
> +       phy_dev->sata_gen = SATA_GEN1;
> +
> +       of_property_read_string(np, "st,sata_gen", &sata_gen);

This wasn't in the binding documentation. It also violates dt style;
s/_/-/

Could these not be numbers, or can this not come from elsewhere?

Or are there some crazy SATA generations to support?

> +       if (sata_gen) {
> +               if (!strcmp(sata_gen, "gen3"))
> +                       phy_dev->sata_gen = SATA_GEN3;
> +               else if (!strcmp(sata_gen, "gen2"))
> +                       phy_dev->sata_gen = SATA_GEN2;
> +       }
> +
> +       phy_dev->pcie_tx_pol_inv =
> +               of_property_read_bool(np, "st,pcie_tx_pol_inv");
> +
> +       phy_dev->sata_tx_pol_inv =
> +               of_property_read_bool(np, "st,sata_tx_pol_inv");

Likewise for both of these on the first two points.

> +
> +       return 0;
> +}
> +
> +static int miphy365x_phy_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct miphy365x_dev *phy_dev;
> +       struct device *dev = &pdev->dev;
> +       struct phy_provider *provider;
> +       u8 port;
> +       int ret;
> +
> +       if (!np) {
> +               dev_err(dev, "No DT found\n");

s/DT/node/ ?

Cheers,
Mark.
