From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 13:41:52 -0600
Subject: [PATCH v3 1/2] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <52AA1021.2010505@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-2-git-send-email-w-kwok2@ti.com>
 <20131210025110.GA20090@saruman.home> <52A72F28.10909@ti.com>
 <20131212174838.GE1939@saruman.home> <52AA1021.2010505@ti.com>
Message-ID: <20131212194152.GQ1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 02:36:01PM -0500, Santosh Shilimkar wrote:
> On Thursday 12 December 2013 12:48 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Dec 10, 2013 at 10:11:36AM -0500, Santosh Shilimkar wrote:
> >>>> +static int kdwc3_remove(struct platform_device *pdev)
> >>>> +{
> >>>> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> >>>> +
> >>>> +	kdwc3_disable_irqs(kdwc);
> >>>> +	clk_disable_unprepare(kdwc->clk);
> >>>
> >>> I hope the clock isn't shared between core and wrapper, otherwise you
> >>> could run into some troubles here. Can you confirm ?
> >>>
> >> Yes. the clock isn't shared. Thanks for taking care of other parts.
> > 
> > so clock for core is always running too ?
> > 
> I take that back. The clock is actually common so we should disable
> it after removing the  kdwc3_remove_core() as you suggested.
> 
> You won't see issue since the  kdwc3_remove_core() not doing
> any register access but moving the clock disable after
> the core remove is right thing to do.

the problem is not kdwc3_remove_core() accessing registers, but
dwc3_remove() _does_ access registers during remove. If you just
mopdrobe -r dwc3-keystone without removing dwc3.ko first, then
kdwc3_remove_core() will cause dwc3.ko to be removed (because of
platform_driver_unregister()) and, since clocks have already been
disabled, then we'd die :-)

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/fe9d8c4c/attachment.sig>
