From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 3 Jul 2015 09:02:31 +0800
Subject: [PATCH v2 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
In-Reply-To: <CAJ+vNU3me-qBZT7h1e+54UNRJw-2SH=nofnTRM4GEn0j9jh3ig@mail.gmail.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
 <20150629011737.GG10332@tiger>
 <CAJ+vNU3me-qBZT7h1e+54UNRJw-2SH=nofnTRM4GEn0j9jh3ig@mail.gmail.com>
Message-ID: <20150703010231.GA28488@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 09:49:20AM -0700, Tim Harvey wrote:
> On Sun, Jun 28, 2015 at 6:17 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Thu, Jun 04, 2015 at 01:15:59PM -0700, Tim Harvey wrote:
> >> @@ -90,6 +92,11 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
> >>       struct imx2_wdt_device *wdev = container_of(this,
> >>                                                   struct imx2_wdt_device,
> >>                                                   restart_handler);
> >> +
> >> +     /* Use external reset */
> >> +     if (wdev->ext_reset)
> >> +             wcr_enable |= IMX2_WDT_WCR_SRS;
> >> +
> >
> > The existing code simply writes the register with only WDE (Watchdog
> > Enable) bit set.  That said, bit WDA and SRS are cleared at the same
> > time.  What's the result of that?  Both internal reset and external
> > reset will be asserted?  If this is the case, it's unsafe per your reply
> > to Frank's comment, right?  So we should only clear one bit between
> > these two based on ext_reset flag to avoid asserting both internal and
> > external reset?
> >
> > Shawn
> 
> Shawn,
> 
> Correct.
> 
> Are you saying that you think we should change the above to something
> like the following to ensure in the internal reset case external reset
> is not also being asserted?:

Yes, that's what I'm saying.

> 
> +     /* Use external reset */
> +     if (wdev->ext_reset)
> +             wcr_enable |= IMX2_WDT_WCR_SRS; /* do not assert
> internal system reset */
> +     else
> +             wcr_enable |= IMX2_WDT_WCR_WDA; /* do not assert external reset */
> 
> I was not worried about the else case above because if you hit that
> path your device-tree is saying you are not using external reset
> anyway.

It's a safeguard for platforms which have WDOG_B signal routed to some
hardware, while their device trees haven't specified ext_reset_output
property.

Shawn
