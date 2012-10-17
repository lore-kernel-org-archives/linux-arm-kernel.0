From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Oct 2012 20:13:01 +0100
Subject: [PATCH] usb: phy: samsung: Introducing usb phy driver for hsotg
In-Reply-To: <005801cdac56$8da0c120$a8e24360$%kim@samsung.com>
References: <1349256393-11741-1-git-send-email-p.paneri@samsung.com>
 <1350036934-6051-1-git-send-email-p.paneri@samsung.com>
 <005801cdac56$8da0c120$a8e24360$%kim@samsung.com>
Message-ID: <20121017191300.GL21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 08:00:00PM +0900, Kukjin Kim wrote:
> > +static int samsung_usbphy_get_refclk_freq(struct samsung_usbphy *sphy)
> > +{
> > +	struct clk *ref_clk;
> > +	int refclk_freq = 0;
> > +
> > +	ref_clk = clk_get(sphy->dev, "xusbxti");
> > +	if (IS_ERR(ref_clk)) {
> 
> IS_ERR_OR_NULL(ref_clk)?

For the N'th time, NO.  IS_ERR is correct here.

> > +		dev_err(sphy->dev, "Failed to get reference clock\n");
> > +		return PTR_ERR(ref_clk);

Look, it's the ABI.  Not only that but it's also TOTALLY AND UTTERLY WRONG
to use IS_ERR_OR_NULL(foo) and then follow it with return PTR_ERR(foo).
You end up returning ZERO.

Stop telling people to use IS_ERR_OR_NULL without properly thinking about
it first.  Virtually every single one of these done this way is a BUG.

Are we clear on this?
