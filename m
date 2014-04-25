From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 25 Apr 2014 15:08:49 +0200
Subject: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
In-Reply-To: <20140425124945.GM26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
 <20140425123820.GA15179@pengutronix.de>
 <20140425124945.GM26756@n2100.arm.linux.org.uk>
Message-ID: <20140425130849.GB15179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 01:49:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 25, 2014 at 02:38:20PM +0200, Markus Pargmann wrote:
> > Hi,
> > 
> > On Wed, Apr 23, 2014 at 08:07:57PM +0100, Russell King wrote:
> > > Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
> > > additional clock start/stop cycles during the transition to 1.8V
> > > signalling mode.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > I tested the series on imx6s with a RIoT board. With this patch applied
> > the RIoT board emmc does not work. Here is the output of the board:
> 
> Unfortunately, I don't have any emmc sdhci using devices, so this is
> a combination I can't test myself.
> 
> What would be useful is to find out which of the two changes in there
> is the cause - can you try with just the change to
> sdhci_do_start_signal_voltage_switch applied, iow just this change:

I just tried the different parts of the patch. Without the following
change, emmc works:

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			host->ops->set_clock(host, host->clock);
 		}
 
-
-		/* Reset SD Clock Enable */
-		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-		clk &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/41d480c8/attachment.sig>
