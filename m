From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 30 Jun 2014 11:59:40 +0200
Subject: [PATCH v7 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <53AB1CFD.4040500@cogentembedded.com>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403530783-17180-2-git-send-email-antoine.tenart@free-electrons.com>
 <53AB1CFD.4040500@cogentembedded.com>
Message-ID: <20140630095940.GB10058@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

On Wed, Jun 25, 2014 at 11:03:25PM +0400, Sergei Shtylyov wrote:
> On 06/23/2014 05:39 PM, Antoine T?nart wrote:
> 
> >The Berlin SoC has a two SATA ports. Add a PHY driver to handle them.
> 
> >The mode selection can let us think this PHY can be configured to fit
> >other purposes. But there are reasons to think the SATA mode will be
> >the only one usable: the PHY registers are only accessible indirectly
> >through two registers in the SATA range, the PHY seems to be integrated
> >and no information tells us the contrary. For these reasons, make the
> >driver a SATA PHY driver.
> 
>    I'm not even sure why you want to make it a separate driver if
> the registers are mapped to SATA controller's range.

We discussed this before and decided to move all the PHY related
functions to a dedicated PHY driver. This allows to have a generic
ahci_platform driver only using the common functions defined in the
libahci. And the PHY subsystem is there to handle PHYs, so it's a good
idea to use it, right?

> [...]
> 
> >diff --git a/drivers/phy/phy-berlin-sata.c b/drivers/phy/phy-berlin-sata.c
> >new file mode 100644
> >index 000000000000..317f62358165
> >--- /dev/null
> >+++ b/drivers/phy/phy-berlin-sata.c
> >@@ -0,0 +1,246 @@
> [...]
> +#define HOST_VSA_ADDR		0x0
> +#define HOST_VSA_DATA		0x4
> +#define PORT_VSR_ADDR		0x78
> +#define PORT_VSR_DATA		0x7c
> +#define PORT_SCR_CTL		0x2c
> 
>    Could you keep this list sorted?

Sure.

> 
> [...]
> 
> +struct phy_berlin_desc {
> +	struct phy	*phy;
> +	u32		val;
> 
>    Hm, aren't these power down bits? Why not call the field accordingly?

Yes. I'll update.

> 
> [...]
> 
> >+static int phy_berlin_sata_power_on(struct phy *phy)
> >+{
> >+	struct phy_berlin_desc *desc = phy_get_drvdata(phy);
> >+	struct phy_berlin_priv *priv = to_berlin_sata_phy_priv(desc);
> >+	void __iomem *ctrl_reg = priv->base + 0x60 + (desc->index * 0x80);
> >+	int ret = 0;
> >+	u32 regval;
> >+
> >+	clk_prepare_enable(priv->clk);
> >+
> >+	spin_lock(&priv->lock);
> >+
> >+	/* Power on PHY */
> >+	writel(CONTROL_REGISTER, priv->base + HOST_VSA_ADDR);
> >+	regval = readl(priv->base + HOST_VSA_DATA);
> >+	regval &= ~(desc->val);
> 
>    Parens not needed here.
> 
> >+	writel(regval, priv->base + HOST_VSA_DATA);
> >+
> >+	/* Configure MBus */
> >+	writel(MBUS_SIZE_CONTROL, priv->base + HOST_VSA_ADDR);
> >+	regval = readl(priv->base + HOST_VSA_DATA);
> >+	regval |= MBUS_WRITE_REQUEST_SIZE_128 | MBUS_READ_REQUEST_SIZE_128;
> >+	writel(regval, priv->base + HOST_VSA_DATA);
> 
>    It probably makes sense to factor these address/data register
> writes into a separate function like phy_berlin_sata_reg_setbits().

I'm not sure. phy_berlin_sata_reg_setbits() is there for common access,
but the way to configure MBus and p[ower on the PHY is specific to them.
It would add functions only used once.

> 
> [...]
> >+	/* set the controller speed */
> >+	writel(0x31, ctrl_reg + PORT_SCR_CTL);
> 
>    Value undocumented? Or is this the SATA SControl register by chance?

Some magic is still there...

> 
> [...]
> 
> >+static int phy_berlin_sata_probe(struct platform_device *pdev)
> >+{
> >+	struct device *dev = &pdev->dev;
> >+	struct phy *phy;
> >+	struct phy_provider *phy_provider;
> >+	struct phy_berlin_priv *priv;
> >+	struct resource *res;
> >+	int i;
> >+
> >+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >+	if (!priv)
> >+		return -ENOMEM;
> >+
> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	if (!res)
> >+		return -EINVAL;
> >+
> >+	priv->base = devm_ioremap(dev, res->start, resource_size(res));
> 
>    Can't you use devm_ioremap_resource()?

The SATA PHY registers are inside the SATA ones. We can't use
devm_ioremap_resource() then.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
