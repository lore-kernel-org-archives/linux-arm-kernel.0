From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 9 Aug 2016 09:36:14 +0000
Subject: [RFC PATCH v4 2/2] net: phy: Add gmiitorgmii converter support
In-Reply-To: <03CA77BA8AF6F1469AEDFBDA1322A7B74A1C3E6C@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1470640505-8279-1-git-send-email-appanad@xilinx.com>
 <1470640505-8279-2-git-send-email-appanad@xilinx.com>
 <03CA77BA8AF6F1469AEDFBDA1322A7B74A1C3E6C@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5E0880@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Punnaiah,

	Thanks for the review...

> > +
> > +#define XILINX_GMII2RGMII_REG	0x10
> > +#define BMCR_SPEED10		0x00
> 
> Move this macro to mii.h

Sure will fix in the next version...

> 
> > +
> > +struct gmii2rgmii {
> > +	struct phy_device *phy_dev;
> > +	struct phy_driver *phy_drv;
> > +	struct phy_driver conv_phy_drv;
> > +	int addr;
> > +};
> > +
> > +static int xgmiitorgmii_read_status(struct phy_device *phydev) {
> > +	struct gmii2rgmii *priv = (struct gmii2rgmii *)phydev->priv;
> > +	u16 val = 0;
> > +
> > +	priv->phy_drv->read_status(phydev);
> > +
> > +	val = mdiobus_read(phydev->mdio.bus, priv->addr,
> > XILINX_GMII2RGMII_REG);
> > +
> 
>     Since its read and then modify, you should mask the speed field With zero and
> then write new value.
> 

Sure will fix in the next version...

> 
> > +	switch (phydev->speed) {
> > +	case SPEED_1000:
> > +		val |= BMCR_SPEED1000;
> > +	case SPEED_100:
> > +		val |= BMCR_SPEED100;
> > +	case SPEED_10:
> > +		val |= BMCR_SPEED10;
> > +	}
> > +
> > +	mdiobus_write(phydev->mdio.bus, priv->addr,
> > XILINX_GMII2RGMII_REG, val);
> > +
> > +	return 0;
> > +}
> > +
> > +int xgmiitorgmii_probe(struct mdio_device *mdiodev) {
> > +	struct device *dev = &mdiodev->dev;
> > +	struct device_node *np = dev->of_node, *phy_node;
> > +	struct gmii2rgmii *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	phy_node = of_parse_phandle(np, "phy-handle", 0);
> > +	if (IS_ERR(phy_node)) {
> > +		dev_err(dev, "Couldn't parse phy-handle\n");
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	priv->phy_dev = of_phy_find_device(phy_node);
> > +	if (!priv->phy_dev) {
> > +		ret = -EPROBE_DEFER;
> > +		dev_info(dev, "Couldn't find phydev\n");
> > +		goto out;
> > +	}
> > +
> > +	priv->addr = mdiodev->addr;
> > +	priv->phy_drv = priv->phy_dev->drv;
> > +	memcpy(&priv->conv_phy_drv, priv->phy_dev->drv,
> > +	       sizeof(struct phy_driver));
> > +	priv->conv_phy_drv.read_status = xgmiitorgmii_read_status;
> > +	priv->phy_dev->priv = priv;
> > +	priv->phy_dev->drv = &priv->conv_phy_drv;
> > +
> > +	return 0;
> > +out:
> > +	return ret;
> 
> Since there is no resource cleaning here, you could consider Return from this
> function in above conditions and avoid goto here.
> 

Sure will fix in the next version...

Regards,
Kedar.

> Regards,
> Punnaiah
