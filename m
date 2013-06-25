From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:06:50 +0300
Subject: [PATCH v2 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
In-Reply-To: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130625150649.GA21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 25, 2013 at 04:21:46PM +0200, Sylwester Nawrocki wrote:
> +enum phy_id {
> +	PHY_CSIS0,
> +	PHY_DSIM0,
> +	PHY_CSIS1,
> +	PHY_DSIM1,
> +	NUM_PHYS

please prepend these with EXYNOS_PHY_ or EXYNOS_MIPI_PHY_

> +struct exynos_video_phy {
> +	spinlock_t slock;
> +	struct phy *phys[NUM_PHYS];

more than one phy ? This means you should instantiate driver multiple
drivers. Each phy id should call probe again.

> +static int __set_phy_state(struct exynos_video_phy *state,
> +				enum phy_id id, unsigned int on)
> +{
> +	void __iomem *addr;
> +	unsigned long flags;
> +	u32 reg, reset;
> +
> +	if (WARN_ON(id > NUM_PHYS))
> +		return -EINVAL;

you don't want to do this, actually. It'll bug you everytime you want to
add another phy ID :-)

> +	addr = state->regs + EXYNOS_MIPI_PHY_CONTROL(id / 2);
> +
> +	if (id == PHY_DSIM0 || id == PHY_DSIM1)
> +		reset = EXYNOS_MIPI_PHY_MRESETN;
> +	else
> +		reset = EXYNOS_MIPI_PHY_SRESETN;
> +
> +	spin_lock_irqsave(&state->slock, flags);
> +	reg = readl(addr);
> +	if (on)
> +		reg |= reset;
> +	else
> +		reg &= ~reset;
> +	writel(reg, addr);
> +
> +	/* Clear ENABLE bit only if MRESETN, SRESETN bits are not set. */
> +	if (on)
> +		reg |= EXYNOS_MIPI_PHY_ENABLE;
> +	else if (!(reg & EXYNOS_MIPI_PHY_RESET_MASK))
> +		reg &= ~EXYNOS_MIPI_PHY_ENABLE;
> +
> +	writel(reg, addr);
> +	spin_unlock_irqrestore(&state->slock, flags);
> +
> +	pr_debug("%s(): id: %d, on: %d, addr: %#x, base: %#x\n",
> +		 __func__, id, on, (u32)addr, (u32)state->regs);

use dev_dbg() instead.

> +
> +	return 0;
> +}
> +
> +static int exynos_video_phy_power_on(struct phy *phy)
> +{
> +	struct exynos_video_phy *state = dev_get_drvdata(&phy->dev);

looks like we should have phy_get_drvdata() helper :-) Kishon ?

> +static struct phy *exynos_video_phy_xlate(struct device *dev,
> +					struct of_phandle_args *args)
> +{
> +	struct exynos_video_phy *state = dev_get_drvdata(dev);
> +
> +	if (WARN_ON(args->args[0] > NUM_PHYS))
> +		return NULL;

please remove this check.

> +	return state->phys[args->args[0]];

and your xlate is 'wrong'.

> +}
> +
> +static struct phy_ops exynos_video_phy_ops = {
> +	.power_on	= exynos_video_phy_power_on,
> +	.power_off	= exynos_video_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int exynos_video_phy_probe(struct platform_device *pdev)
> +{
> +	struct exynos_video_phy *state;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct phy_provider *phy_provider;
> +	int i;
> +
> +	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	state->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(state->regs))
> +		return PTR_ERR(state->regs);
> +
> +	dev_set_drvdata(dev, state);

you can use platform_set_drvdata(pdev, state);

same thing though, no strong feelings.

> +	phy_provider = devm_of_phy_provider_register(dev,
> +					exynos_video_phy_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	for (i = 0; i < NUM_PHYS; i++) {
> +		char label[8];
> +
> +		snprintf(label, sizeof(label), "%s.%d",
> +				i == PHY_DSIM0 || i == PHY_DSIM1 ?
> +				"dsim" : "csis", i / 2);
> +
> +		state->phys[i] = devm_phy_create(dev, i, &exynos_video_phy_ops,
> +								label, state);
> +		if (IS_ERR(state->phys[i])) {
> +			dev_err(dev, "failed to create PHY %s\n", label);
> +			return PTR_ERR(state->phys[i]);
> +		}
> +	}

this really doesn't look correct to me. It looks like you have multiple
PHYs, one for each ID. So your probe should be called for each PHY ID
and you have several phy_providers too.

> +static const struct of_device_id exynos_video_phy_of_match[] = {
> +	{ .compatible = "samsung,s5pv210-mipi-video-phy" },

and this should contain all PHY IDs:

	{ .compatible = "samsung,s5pv210-mipi-video-dsim0-phy",
		.data = (const void *) DSIM0, },
	{ .compatible = "samsung,s5pv210-mipi-video-dsim1-phy",
		.data = (const void *) DSIM1, },
	{ .compatible = "samsung,s5pv210-mipi-video-csi0-phy"
		.data = (const void *) CSI0, },
	{ .compatible = "samsung,s5pv210-mipi-video-csi1-phy"
		.data = (const void *) CSI1, },

then on your probe you can fetch that data field and use it as phy->id.

> +static struct platform_driver exynos_video_phy_driver = {
> +	.probe	= exynos_video_phy_probe,

you *must* provide a remove method. drivers with NULL remove are
non-removable :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/ead349d6/attachment.sig>
