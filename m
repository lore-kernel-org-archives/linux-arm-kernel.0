From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Feb 2011 12:15:57 +0100
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <20110221110905.GL14495@n2100.arm.linux.org.uk>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
	<20110221100439.GE2616@pengutronix.de>
	<010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
	<20110221104608.GF2616@pengutronix.de>
	<20110221110905.GL14495@n2100.arm.linux.org.uk>
Message-ID: <20110221111557.GG2616@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 11:09:05AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 21, 2011 at 11:46:08AM +0100, Wolfram Sang wrote:
> > > > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > > > +   if (cpu_is_mx53())
> > > > > +           host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
> > > >
> > > > Have you tried it doing it via IO-accessors?
> > > Richard Zhu: This quirk is used to fix a mechanism problem in the MMC CMDs execution procedure.
> > > It would be very abrupt and ugly, if the IO-accessors are added into these original procedures.
> > 
> > Please don't get it personal, but IMHO it is pretty ugly the way it is
> > now. This quirk is very imx-specific and calling something like
> > SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By the way, what
> > does this bit do, the description doesn't say so?
> 
> SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO is rather too verbose.  Isn't
> there a shorter version which could be used?  SDHCI_QUIRK_SDIO_MULTIBLK_INT
> maybe?

As I understand, the non-SDIO part is handled here:

+       /*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO */
+       if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
+               if (cmd->opcode == 12)
+                       flags |= SDHCI_CMD_ABORTCMD;
+       }

But I'd really like to avoid the quirk bit. Maybe we'll get a better
idea once we understand what that magic bit actually does. For a start,
we might simply set SDHCI_QUIRK_NO_MULTIBLOCK for mx53 like we do for
other imx.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110221/d80aa342/attachment.sig>
