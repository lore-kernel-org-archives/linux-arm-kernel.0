From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Nov 2013 13:39:44 -0600
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <52963AA4.6030007@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
 <5295B93A.3040400@ti.com> <20131127174140.GE8123@saruman.home>
 <52963AA4.6030007@ti.com>
Message-ID: <20131127193944.GA20344@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 01:32:04PM -0500, Santosh Shilimkar wrote:
> On Wednesday 27 November 2013 12:41 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Wed, Nov 27, 2013 at 02:49:54PM +0530, George Cherian wrote:
> >>> +	error = of_platform_populate(node, NULL, NULL, dev);
> >>> +	if (error) {
> >>> +		dev_err(&pdev->dev, "failed to create dwc3 core\n");
> >>> +		goto err_core;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +
> >>> +err_core:
> >>> +	kdwc3_disable_irqs(kdwc);
> >>> +err_irq:
> >>> +	kdwc3_disable(kdwc);
> >>> +
> >>> +	return error;
> >>> +}
> >>> +
> >>> +static int kdwc3_remove(struct platform_device *pdev)
> >>> +{
> >>> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> >>> +
> >>> +	if (kdwc) {
> >>> +		kdwc3_disable_irqs(kdwc);
> >>> +		kdwc3_disable(kdwc);
> >>> +		platform_set_drvdata(pdev, NULL);
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>
> >> You need to unregister the child nodes in remove.
> >> Also why can't the dwc3-omap driver be reused, Felipe??
> >> I believe the TI wrapper for Keystone is similar to that of AM437x or
> >> OMAP5.
> > 
> > it is very similar indeed, if it can be easily re-use that glue, I'd
> > rather not add another.
> > 
> Initial idea was actually to use same driver but the integration IP
> is quite different on Keystone vs OMAP which lead to have a separate
> glue layer. They look similar but there are differences in terms of phys,
> interrupts, register space. And also non OTG support, runtime PM
> vs clock etc for now.

All of those can be easily taken care of:

a) PHY -> different phy driver
b) non-OTG -> there's a register on dwc3 which we can use
c) runtime vs clock -> we can add optional clock support on dwc3-omap.c

what *really* prevents us from using the same, is register layout and
the fact that on OMAP, nobody wants drivers accessing SYS* registers (a
mistake IMO). That would be a lot more difficult to make generic.

BTW, OMAP isn't OTG either, it doesn't support the OTG specification
even though it can act in both roles. Same applies for keystone, if I'm
reading my docs correctly.

> After all the glue is really a very small code describes the integration
> details thanks to nice abstracted dwc3 core layer. So as discussed
> over irc, keeping the separate glue is preferred but do let us know
> if you think otherwise.

yeah, let's keep it separate. Keystone is, in general, an entire new SoC
architecture anyway.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/2cf1b300/attachment.sig>
