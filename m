From: B18965@freescale.com (Wang Huan-B18965)
Date: Wed, 7 Aug 2013 08:07:34 +0000
Subject: [PATCH 4/5] fb: Add DCU framebuffer driver for Vybrid VF610
 platform
In-Reply-To: <1375778859.4276.25.camel@weser.hi.pengutronix.de>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
 <1373609276-14566-5-git-send-email-b18965@freescale.com>
 <1375778859.4276.25.camel@weser.hi.pengutronix.de>
Message-ID: <81BA6E5E0BC2344391CABCEE22D1B6D83D1805@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Am Freitag, den 12.07.2013, 14:07 +0800 schrieb Alison Wang:
> > The Display Controller Unit (DCU) module is a system master that
> > fetches graphics stored in internal or external memory and displays
> > them on a TFT LCD panel. A wide range of panel sizes is supported and
> > the timing of the interface signals is highly configurable.
> > Graphics are read directly from memory and then blended in real-time,
> > which allows for dynamic content creation with minimal CPU
> intervention.
> >
> > The features:
> >
> > (1) Full RGB888 output to TFT LCD panel.
> > (2) For the current LCD panel, WQVGA "480x272" is tested.
> > (3) Blending of each pixel using up to 4 source layers dependent on
> size of panel.
> > (4) Each graphic layer can be placed with one pixel resolution in
> either axis.
> > (5) Each graphic layer support RGB565 and RGB888 direct colors
> without
> > alpha channel and BGRA8888 direct colors with an alpha channel.
> > (6) Each graphic layer support alpha blending with 8-bit resolution.
> >
> > This driver has been tested on Vybrid VF610 TOWER board.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com>
> > ---
> > Changes in v2: None
> >
> >  drivers/video/Kconfig      |    9 +
> >  drivers/video/Makefile     |    1 +
> >  drivers/video/fsl-dcu-fb.c | 1091
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1101 insertions(+)
> >  create mode 100644 drivers/video/fsl-dcu-fb.c
> >
> [...]
> > +enum mfb_index {
> > +	LAYER0 = 0,
> > +	LAYER1,
> > +	LAYER2,
> > +	LAYER3,
> > +};
> Why are there only 4 layers here? I thought the controller supports at
> least 6 simultaneous layers?
[Alison Wang] I used 4 layers for the customer's requirement before. Anyway, I will change it to 6 in next version.
BTW, according to the RM, it said "Blending of each pixel using up to 6 source layers dependent on size of panel". So I think the most simultaneous layers is 6.
> 
> > +
> > +static struct mfb_info mfb_template[] = {
> > +	{
> > +	.index = LAYER0,
> > +	.id = "Layer0",
> > +	.alpha = 0xff,
> > +	.blend = 0,
> > +	.count = 0,
> > +	.x_layer_d = 0,
> > +	.y_layer_d = 0,
> > +	},
> > +	{
> > +	.index = LAYER1,
> > +	.id = "Layer1",
> > +	.alpha = 0xff,
> > +	.blend = 0,
> > +	.count = 0,
> > +	.x_layer_d = 50,
> > +	.y_layer_d = 50,
> > +	},
> > +	{
> > +	.index = LAYER2,
> > +	.id = "Layer2",
> > +	.alpha = 0xff,
> > +	.blend = 0,
> > +	.count = 0,
> > +	.x_layer_d = 100,
> > +	.y_layer_d = 100,
> > +	},
> > +	{
> > +	.index = LAYER3,
> > +	.id = "Layer3",
> > +	.alpha = 0xff,
> > +	.blend = 0,
> > +	.count = 0,
> > +	.x_layer_d = 150,
> > +	.y_layer_d = 150,
> > +	},
> > +};
> [...]
> > +static int fsl_dcu_release(struct fb_info *info, int user) {
> > +	struct mfb_info *mfbi = info->par;
> > +	int ret = 0;
> > +
> > +	mfbi->count--;
> > +	if (mfbi->count == 0) {
> > +		ret = disable_panel(info);
> > +		if (ret < 0)
> > +			mfbi->count++;
> > +	}
> > +
> > +	return ret;
> > +}
> Could this be replaced by runtime pm?
[Alison Wang] Yes, I will use runtime pm.
> [...]
> > +static int bypass_tcon(struct device_node *np) {
> > +	struct device_node *tcon_np;
> > +	struct platform_device *tcon_pdev;
> > +	struct clk *tcon_clk;
> > +	void __iomem *tcon_reg;
> > +	int ret = 0;
> > +
> > +	tcon_np = of_parse_phandle(np, "tcon-controller", 0);
> > +	if (!tcon_np)
> > +		return -EINVAL;
> > +
> > +	tcon_pdev = of_find_device_by_node(tcon_np);
> > +	if (!tcon_pdev)
> > +		return -EINVAL;
> > +
> > +	tcon_clk = devm_clk_get(&tcon_pdev->dev, "tcon");
> > +	if (IS_ERR(tcon_clk)) {
> > +		ret = PTR_ERR(tcon_clk);
> > +		goto failed_getclock;
> > +	}
> > +	clk_prepare_enable(tcon_clk);
> > +
> > +	tcon_reg = of_iomap(tcon_np, 0);
> > +	if (!tcon_reg) {
> > +		ret = -ENOMEM;
> > +		goto failed_ioremap;
> > +	}
> > +	writel(TCON_BYPASS_ENABLE, tcon_reg + TCON_CTRL1);
> > +
> > +	return 0;
> > +
> > +failed_ioremap:
> > +	clk_disable_unprepare(tcon_clk);
> > +failed_getclock:
> > +	of_node_put(tcon_np);
> > +	return ret;
> > +}
> > +
> Is the framebuffer driver the only user of tcon? If not you should not
> map the memory here, but rather use something like regmap syscon.
[Alison Wang] Yes, the fb driver is the only user of tcon.

Thanks for your comments!


Best Regards,
Alison Wang
