From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 14 Jun 2012 09:12:12 +0800
Subject: [Patch v5 05/13] usb: otg: add basic mxs phy driver support
In-Reply-To: <201206132356.16093.marex@denx.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-6-git-send-email-richard.zhao@freescale.com>
 <20120613213312.GD30400@pengutronix.de>
 <201206132356.16093.marex@denx.de>
Message-ID: <20120614011211.GB29684@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 11:56:15PM +0200, Marek Vasut wrote:
> Dear Sascha Hauer,
> 
> > On Wed, Jun 13, 2012 at 08:34:15PM +0800, Richard Zhao wrote:
> > > mxs phy is used in Freescale i.MX SoCs, for example
> > > imx23, imx28, imx6Q. This patch adds the basic host
> > > support.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Peter Chen <peter.chen@freescale.com>
> > > Acked-by: Felipe Balbi <balbi@ti.com>
> [...]
> 
> > > +	/* Remove CLKGATE and SFTRST */
> > > +	writel_relaxed(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL_SFTRST,
> > > +			base + HW_USBPHY_CTRL_CLR);
> > > +	udelay(10);
> > 
> > Is stmp_reset_block() suitable for what you want to do here?
> 
> IIRC it is.
Thanks.
> 
> > > +	base = devm_request_and_ioremap(&pdev->dev, res);
> > > +	if (!base)
> > > +		return -EBUSY;
> > > +
> > > +	clk = devm_clk_get(&pdev->dev, NULL);
> > > +	if (IS_ERR(clk)) {
> > > +		dev_err(&pdev->dev, "can't get the clock!");
> > 
> > Please add the return value to these kind of messages.
Make sense.
> > 
> > > +		return PTR_ERR(clk);
> > > +	}
> > > +
> > > +	mxs_phy = devm_kzalloc(&pdev->dev, sizeof(*mxs_phy), GFP_KERNEL);
> > > +	if (!mxs_phy) {
> > > +		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");
> > 
> > This message is rather useless. It is really not expected for kzalloc
> > to fail. If it fails here you really have problems elsewhere and this
> > message won't help you debugging it.
At least it shows the point it fails and people can look back what code
has been run.

Thanks
Richard
> 
> It's not useless, but it'll hardly ever be displayed if you run out of memory so 
> badly this kzalloc() will fail.
> 
> > Sascha
> 
> Best regards,
> 
