From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Feb 2011 23:51:28 +0800
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and card detection
In-Reply-To: <20110224081803.GA29530@S2100-06.ap.freescale.net>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	<20110224081803.GA29530@S2100-06.ap.freescale.net>
Message-ID: <20110224155126.GA1466@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24, 2011 at 04:18:05PM +0800, Shawn Guo wrote:
> Hi Wolfram,
> 
> On Wed, Feb 23, 2011 at 02:51:53PM +0100, Wolfram Sang wrote:
> > Take #3, changes:
> > 
> > * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> > * remove unconditional BROKEN_CARD_DETECTION (leftover)
> > * improved kernel-doc about unused GPIO
> > * added tags from Eric
> > 
> > Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> > chance to retest on mx51? What about the FSL guys? :)
> > 
> I'm testing it on mx25 3ds and mx51 babbage. Both card-detect and
> write-protect are working on mx25 3ds, but write-protect has some
> problem on babbage, and I need some time to figure it out.
> 
I just figured out why wp_gpio does not work on mx51.

+       if (cpu_is_mx25() || cpu_is_mx35()) {
+               /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
                host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
+               /* write_protect can't be routed to controller, use gpio */
+               sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
+       }

Would it make sense to do the same for mx51?  On babbage board,
SD1_WP is routed to controller, but SD2_WP is not, so we have to use
gpio for SD2 write_protect.

-- 
Regards,
Shawn
