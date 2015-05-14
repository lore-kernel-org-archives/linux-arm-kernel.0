From: yh.huang@mediatek.com (YH Huang)
Date: Thu, 14 May 2015 22:52:03 +0800
Subject: [PATCH 2/2] pwm: add Mediatek display PWM driver support
In-Reply-To: <20150512130005.GS6325@pengutronix.de>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
 <20150512130005.GS6325@pengutronix.de>
Message-ID: <1431615123.15140.36.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-12 at 15:00 +0200, Sascha Hauer wrote:
> On Mon, May 11, 2015 at 05:26:22PM +0800, YH Huang wrote:
> > +
> > +static int mtk_disp_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct mtk_disp_pwm_chip *pwm;
> 
> The struct mtk_disp_pwm_chip * is named 'mpc' in the other functions.
> For consistency reasons you should do that here aswell.
> 

I miss it! Maybe 'mdpc' is a better name for mtk_disp_pwm_chip.

> > +	struct resource *r;
> > +	int ret;
> > +
> > +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> > +	if (!pwm)
> > +		return -ENOMEM;
> > +
> > +	pwm->dev = &pdev->dev;
> > +
> > +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> > +	if (IS_ERR(pwm->mmio_base))
> > +		return PTR_ERR(pwm->mmio_base);
> > +
> > +	pwm->clk_main = devm_clk_get(&pdev->dev, "main");
> > +	if (IS_ERR(pwm->clk_main))
> > +		return PTR_ERR(pwm->clk_main);
> > +	pwm->clk_mm = devm_clk_get(&pdev->dev, "mm");
> > +	if (IS_ERR(pwm->clk_mm))
> > +		return PTR_ERR(pwm->clk_mm);
> > +
> > +	ret = clk_prepare_enable(pwm->clk_main);
> > +	if (ret < 0)
> > +		return ret;
> > +	ret = clk_prepare_enable(pwm->clk_mm);
> > +	if (ret < 0) {
> > +		clk_disable_unprepare(pwm->clk_main);
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, pwm);
> > +
> > +	pwm->chip.dev = &pdev->dev;
> > +	pwm->chip.ops = &mtk_disp_pwm_ops;
> > +	pwm->chip.base = -1;
> > +	pwm->chip.npwm = NUM_PWM;
> > +
> > +	ret = pwmchip_add(&pwm->chip);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> > +		return ret;
> 
> This error path leaves the clocks enabled.
> 

I forgot this one. I will fix it.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct mtk_disp_pwm_chip *pc = platform_get_drvdata(pdev);
> > +
> > +	if (WARN_ON(!pc))
> > +		return -ENODEV;
> > +
> > +	clk_disable_unprepare(pc->clk_main);
> > +	clk_disable_unprepare(pc->clk_mm);
> > +
> > +	return pwmchip_remove(&pc->chip);
> 
> You should first remove the pwmchip and disable the clocks afterwards.
> Also note that this function can fail.
> 

OK.

> Sascha
> 

Thank for your suggestion.

Regards,
YH Huang
