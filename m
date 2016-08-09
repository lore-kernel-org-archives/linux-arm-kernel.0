From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Tue, 9 Aug 2016 08:07:35 +0000
Subject: [RFC PATCH v4 2/2] net: phy: Add gmiitorgmii converter support
In-Reply-To: <1470640505-8279-2-git-send-email-appanad@xilinx.com>
References: <1470640505-8279-1-git-send-email-appanad@xilinx.com>
 <1470640505-8279-2-git-send-email-appanad@xilinx.com>
Message-ID: <03CA77BA8AF6F1469AEDFBDA1322A7B74A1C3E6C@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,

> -----Original Message-----
> From: Kedareswara rao Appana [mailto:appana.durga.rao at xilinx.com]
> Sent: Monday, August 08, 2016 12:45 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; f.fainelli at gmail.com;
> andrew at lunn.ch; Punnaiah Choudary Kalluri <punnaia@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org
> Subject: [RFC PATCH v4 2/2] net: phy: Add gmiitorgmii converter support
> 
> This patch adds support for gmiitorgmii converter.
> 
> The GMII to RGMII IP core provides the Reduced Gigabit Media
> Independent Interface (RGMII) between Ethernet physical media
> Devices and the Gigabit Ethernet controller. This core can
> Switch dynamically between the three different speed modes of
> Operation by configuring the converter register through mdio write.
> 
> MDIO interface is used to set operating speed of Ethernet MAC.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Thanks a lot Andrew for your inputs.
> Changes for v4:
> --> Updated phydev speed for all 3 speeds as suggested by zhuyj.
> Changes for v3:
> --> Updated the driver as suggested by Andrew.
> Changes for v2:
> --> Passed struct xphy pointer directly to the fix_mac_speed
> API as suggested by the Florian.
> --> Added checks for the phy-node fail case as suggested
> by the Florian
> 
> +
> +#define XILINX_GMII2RGMII_REG	0x10
> +#define BMCR_SPEED10		0x00

Move this macro to mii.h

> +
> +struct gmii2rgmii {
> +	struct phy_device *phy_dev;
> +	struct phy_driver *phy_drv;
> +	struct phy_driver conv_phy_drv;
> +	int addr;
> +};
> +
> +static int xgmiitorgmii_read_status(struct phy_device *phydev)
> +{
> +	struct gmii2rgmii *priv = (struct gmii2rgmii *)phydev->priv;
> +	u16 val = 0;
> +
> +	priv->phy_drv->read_status(phydev);
> +
> +	val = mdiobus_read(phydev->mdio.bus, priv->addr,
> XILINX_GMII2RGMII_REG);
> +

    Since its read and then modify, you should mask the speed field
With zero and then write new value.
           

> +	switch (phydev->speed) {
> +	case SPEED_1000:
> +		val |= BMCR_SPEED1000;
> +	case SPEED_100:
> +		val |= BMCR_SPEED100;
> +	case SPEED_10:
> +		val |= BMCR_SPEED10;
> +	}
> +
> +	mdiobus_write(phydev->mdio.bus, priv->addr,
> XILINX_GMII2RGMII_REG, val);
> +
> +	return 0;
> +}
> +
> +int xgmiitorgmii_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct device_node *np = dev->of_node, *phy_node;
> +	struct gmii2rgmii *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phy_node = of_parse_phandle(np, "phy-handle", 0);
> +	if (IS_ERR(phy_node)) {
> +		dev_err(dev, "Couldn't parse phy-handle\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	priv->phy_dev = of_phy_find_device(phy_node);
> +	if (!priv->phy_dev) {
> +		ret = -EPROBE_DEFER;
> +		dev_info(dev, "Couldn't find phydev\n");
> +		goto out;
> +	}
> +
> +	priv->addr = mdiodev->addr;
> +	priv->phy_drv = priv->phy_dev->drv;
> +	memcpy(&priv->conv_phy_drv, priv->phy_dev->drv,
> +	       sizeof(struct phy_driver));
> +	priv->conv_phy_drv.read_status = xgmiitorgmii_read_status;
> +	priv->phy_dev->priv = priv;
> +	priv->phy_dev->drv = &priv->conv_phy_drv;
> +
> +	return 0;
> +out:
> +	return ret;

Since there is no resource cleaning here, you could consider
Return from this function in above conditions and avoid goto here.

Regards,
Punnaiah

> +}
> +
> +static const struct of_device_id xgmiitorgmii_of_match[] = {
> +	{ .compatible = "xlnx,gmii-to-rgmii-1.0" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xgmiitorgmii_of_match);
> +
> +static struct mdio_driver xgmiitorgmii_driver = {
> +	.probe	= xgmiitorgmii_probe,
> +	.mdiodrv.driver = {
> +		.name = "xgmiitorgmii",
> +		.of_match_table = xgmiitorgmii_of_match,
> +	},
> +};
> +
> +static int __init xgmiitorgmii_init(void)
> +{
> +	return mdio_driver_register(&xgmiitorgmii_driver);
> +}
> +module_init(xgmiitorgmii_init);
> +
> +static void __exit xgmiitorgmii_cleanup(void)
> +{
> +	mdio_driver_unregister(&xgmiitorgmii_driver);
> +}
> +module_exit(xgmiitorgmii_cleanup);
> +
> +MODULE_DESCRIPTION("Xilinx GMII2RGMII converter driver");
> +MODULE_LICENSE("GPL");
> --
> 2.1.2
