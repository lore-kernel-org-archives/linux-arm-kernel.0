From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 11:53:37 +0200
Subject: [PATCH V2 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <519DE2EE.1050006@freescale.com>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <20130523092344.GF32299@pengutronix.de> <519DE2EE.1050006@freescale.com>
Message-ID: <201305231153.38111.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Huang Shijie wrote:
> ? 2013?05?23? 17:23, Sascha Hauer ??:
> > On Thu, May 23, 2013 at 04:16:13PM +0800, Huang Shijie wrote:
> >> +			<cs-number>  0<physical address of mapping>  <size>
> >> +
> >> +Timing property for child nodes. It is mandatory, not optional.
> >> +
> >> + - fsl,weim-cs-timing:	The timing array, contains 6 timing values for the
> >> +			child node. We can get the CS index from the child
> >> +			node's "reg" property.
> > This should be more detailed, something like:
> >
> > This contains the values for the registers EIM_CSnGCR1, EIM_CSnGCR2,
> > EIM_CSnRCR1, EIM_CSnRCR2, EIM_CSnWCR1, EIM_CSnWCR2 in this order.
> >
> 
> 
> do you mean i should add some new properties, such as
> "fsl,eim_csnrcr1", "fsl,eim_csnrcr2" ...

No, the property is fine, just update the documentation the way that
Sascha suggested.

> >> +static int weim_remove(struct platform_device *pdev)
> >> +{
> >> +	struct imx_weim *weim = platform_get_drvdata(pdev);
> >> +
> >> +	clk_disable_unprepare(weim->clk);
> > Once again: Is this clock needed for the child devices? If yes, you
> > can't disable it here and leave the child devices registered.
> >

But weim_remove will not be called as long as there are children
registered, right?

	Arnd
