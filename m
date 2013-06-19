From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 19 Jun 2013 11:47:38 -0400 (EDT)
Subject: [RFC PATCH v1 4/6] USB: EHCI: don't release ehci->lock if URB
 giveback in tasklet context
In-Reply-To: <CACVXFVOc9GhZSX5vtgxN3u9+wMVv2SkXW6jyCtb1eYTzRXahWA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306191144230.2026-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jun 2013, Ming Lei wrote:

> On Wed, Jun 19, 2013 at 12:43 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 18 Jun 2013, Ming Lei wrote:
> >
> >> If HCD_BH is set for HC driver's flags, URB giveback will be
> >> done in tasklet context instead of interrupt context, so the
> >> ehci->lock needn't to be released any more before calling
> >> usb_hcd_giveback_urb().
> >
> > It is premature to do this now.  This should be part of the 6/6 patch,
> 
> It is fine since HCD_BH isn't enabled.

It's not "fine".  It will work -- nothing will crash -- but that 
doesn't mean it is good style.

> > when it won't be necessary to test hcd_giveback_urb_in_bh().
> 
> Keeping it is easy to compare test results between running complete()
> in tasklet and in hard irq handler.

It's just as easy to do your tests by keeping two copies of ehci-hcd.ko 
lying around; one with your changes and one without.  You can insmod 
whichever one you want to test.

> Also it might be helpful for out of tree drivers.
> 
> But it isn't a big deal, I can merge it to 6/6 if you care.

Yes, please.

Alan Stern
