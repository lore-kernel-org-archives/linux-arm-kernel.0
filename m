From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 23:54:52 +0300
Subject: [PATCH v2 1/5] phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs
In-Reply-To: <51C9D714.4000703@samsung.com>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <20130625150649.GA21334@arwen.pp.htv.fi>
 <51C9D714.4000703@samsung.com>
Message-ID: <20130625205452.GC9748@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 25, 2013 at 07:44:52PM +0200, Sylwester Nawrocki wrote:
> >> +struct exynos_video_phy {
> >> +	spinlock_t slock;
> >> +	struct phy *phys[NUM_PHYS];
> > 
> > more than one phy ? This means you should instantiate driver multiple
> > drivers. Each phy id should call probe again.
> 
> Why ? This single PHY _provider_ can well handle multiple PHYs.
> I don't see a good reason to further complicate this driver like
> this. Please note that MIPI-CSIS 0 and MIPI DSIM 0 share MMIO
> register, so does MIPI CSIS 1 and MIPI DSIM 1. There are only 2
> registers for those 4 PHYs. I could have the involved object
> multiplied, but it would have been just a waste of resources
> with no difference to the PHY consumers.

alright, I misunderstood your code then. When I looked over your id
usage I missed the "/2" part and assumed that you would have separate
EXYNOS_MIPI_PHY_CONTROL() register for each ;-)

My bad, you can disregard the other comments.

> >> +static int exynos_video_phy_probe(struct platform_device *pdev)
> >> +{
> >> +	struct exynos_video_phy *state;
> >> +	struct device *dev = &pdev->dev;
> >> +	struct resource *res;
> >> +	struct phy_provider *phy_provider;
> >> +	int i;
> >> +
> >> +	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> >> +	if (!state)
> >> +		return -ENOMEM;
> >> +
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +
> >> +	state->regs = devm_ioremap_resource(dev, res);
> >> +	if (IS_ERR(state->regs))
> >> +		return PTR_ERR(state->regs);
> >> +
> >> +	dev_set_drvdata(dev, state);
> > 
> > you can use platform_set_drvdata(pdev, state);
> 
> I had it in the previous version, but changed for symmetry with
> dev_set_drvdata(). I guess those could be replaced with
> phy_{get, set}_drvdata as you suggested.

hmm, you do need to set the drvdata() to the phy object, but also to the
pdev object (should you need it on a suspend/resume callback, for
instance). Those are separate struct device instances.

> >> +static const struct of_device_id exynos_video_phy_of_match[] = {
> >> +	{ .compatible = "samsung,s5pv210-mipi-video-phy" },
> > 
> > and this should contain all PHY IDs:
> > 
> > 	{ .compatible = "samsung,s5pv210-mipi-video-dsim0-phy",
> > 		.data = (const void *) DSIM0, },
> > 	{ .compatible = "samsung,s5pv210-mipi-video-dsim1-phy",
> > 		.data = (const void *) DSIM1, },
> > 	{ .compatible = "samsung,s5pv210-mipi-video-csi0-phy"
> > 		.data = (const void *) CSI0, },
> > 	{ .compatible = "samsung,s5pv210-mipi-video-csi1-phy"
> > 		.data = (const void *) CSI1, },
> > 
> > then on your probe you can fetch that data field and use it as phy->id.
> 
> This looks wrong to me, it doesn't look like a right usage of 'compatible'
> property. MIPI-CSIS0/MIPI-DSIM0, MIPI-CSIS1/MIPI-DSIM1 are identical pairs,
> so one compatible property would need to be used for them. We don't use
> different compatible strings for different instances of same device.
> And MIPI DSIM and MIPI CSIS share one MMIO register, so they need to be
> handled by one provider, to synchronize accesses. That's one of the main
> reasons I turned to the generic PHY framework for those devices.

understood :-)

> >> +static struct platform_driver exynos_video_phy_driver = {
> >> +	.probe	= exynos_video_phy_probe,
> > 
> > you *must* provide a remove method. drivers with NULL remove are
> > non-removable :-)
> 
> Oops, my bad. I've forgotten to update this, after enabling build
> as module. Will update and test that. It will be an empty callback
> though.

right, because of devm.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/8ce9aa04/attachment.sig>
