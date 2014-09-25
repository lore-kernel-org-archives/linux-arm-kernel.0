From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 25 Sep 2014 14:00:54 -0500
Subject: [PATCH v3 1/3] watchdog: qcom: add support for KPSS WDT
In-Reply-To: <20140925183857.GA12340@roeck-us.net>
References: <cover.1411667144.git.joshc@codeaurora.org>
 <ae171484ae036b331f06814251872c7602a54996.1411667144.git.joshc@codeaurora.org>
 <20140925183857.GA12340@roeck-us.net>
Message-ID: <20140925190054.GJ868@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:38:57AM -0700, Guenter Roeck wrote:
> On Thu, Sep 25, 2014 at 12:48:51PM -0500, Josh Cartwright wrote:
> > Add a driver for the watchdog timer block found in the Krait Processor
> > Subsystem (KPSS) on the MSM8960, APQ8064, and IPQ8064.
> > 
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> 
> Hi Josh,
> 
> just a couple of minor comments this time (yes, I know,
> I am being difficult ;-).

Difficult, maybe, but at least someone's taking a look!  Thanks, again.

[..]
> > +++ b/drivers/watchdog/qcom-wdt.c
[..]
> > +static int qcom_wdt_probe(struct platform_device *pdev)
> > +{
> > +	struct qcom_wdt *wdt;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > +	if (!wdt)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	wdt->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(wdt->base)) {
> > +		ret = PTR_ERR(wdt->base);
> > +		goto err_out;
> 
> This is really unnecessary. Just return PTR_ERR((wdt->base) as you did before.
> No need to make the code more complicated than necessary.
> 
> Basic rule is: If you can return immediately, do it. Otherwise use goto
> and have a single error handler.
> 
> > +	}
> > +
> > +	wdt->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(wdt->clk)) {
> > +		ret = PTR_ERR(wdt->clk);
> > +		goto err_out;
> 
> Same here.
> 
> > +	}
> > +
> > +	ret = clk_prepare_enable(wdt->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to setup clock\n");
> > +		goto err_out;
> 
> and here.

Okay, I can fix these up.

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
