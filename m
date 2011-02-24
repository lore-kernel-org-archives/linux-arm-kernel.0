From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Feb 2011 20:45:57 +0100
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and card detection
In-Reply-To: <20110224160300.GA1483@S2100-06.ap.freescale.net>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	<20110224081803.GA29530@S2100-06.ap.freescale.net>
	<20110224155126.GA1466@S2100-06.ap.freescale.net>
	<20110224160300.GA1483@S2100-06.ap.freescale.net>
Message-ID: <20110224194557.GA20877@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 25, 2011 at 12:03:01AM +0800, Shawn Guo wrote:
> On Thu, Feb 24, 2011 at 11:51:28PM +0800, Shawn Guo wrote:
> > On Thu, Feb 24, 2011 at 04:18:05PM +0800, Shawn Guo wrote:
> > > Hi Wolfram,
> > > 
> > > On Wed, Feb 23, 2011 at 02:51:53PM +0100, Wolfram Sang wrote:
> > > > Take #3, changes:
> > > > 
> > > > * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> > > > * remove unconditional BROKEN_CARD_DETECTION (leftover)
> > > > * improved kernel-doc about unused GPIO
> > > > * added tags from Eric
> > > > 
> > > > Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> > > > chance to retest on mx51? What about the FSL guys? :)
> > > > 
> > > I'm testing it on mx25 3ds and mx51 babbage. Both card-detect and
> > > write-protect are working on mx25 3ds, but write-protect has some
> > > problem on babbage, and I need some time to figure it out.
> > > 
> > I just figured out why wp_gpio does not work on mx51.
> > 
> > +       if (cpu_is_mx25() || cpu_is_mx35()) {
> > +               /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
> >                 host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
> > +               /* write_protect can't be routed to controller, use gpio */
> > +               sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
> > +       }
> > 
> > Would it make sense to do the same for mx51?  On babbage board,
> > SD1_WP is routed to controller, but SD2_WP is not, so we have to use
> > gpio for SD2 write_protect.
> > 
> We should probably have esdhc_pltfm_get_ro whenever platform provides
> a wp_gpio, and fall on controller SD_WP only when platform does not
> provide the wp_gpio.

OK, will think about it. Thanks for testing!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110224/1e00e5e7/attachment.sig>
