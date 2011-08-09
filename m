From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 9 Aug 2011 22:42:23 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <4E4111F3.5070409@freescale.com>
References: <20110805135133.GA26981@pengutronix.de>
	<4E3F8087.6070206@freescale.com>
	<20110809093546.GB1923@pengutronix.de>
	<4E4111F3.5070409@freescale.com>
Message-ID: <20110809204223.GA5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>>Always reproducible by me when trying to format mtd0. Sometimes(always?) seen
> >>>by Koen during boot (on read?). Never seen by Huang? It is currently unclear if
> >>After I used a different .config, it never appears in my side.
> >So, you have a config which triggers this? That should be useful for
> >debugging. What do you need to enable to see this?
> >
> My old config is made by myself. I think it was a wrong config,

Let's see what the bug is in the end, but I don't think a config could be
"wrong" in a way to trigger such a bug. Even misconfiguration can be handled
gracefully with code.

> it's not a DMA bug, I discuss with Koen, and make sure that the bug is
> caused by the GPMI or BCH.

Did you get any further during this day?

> it's a different bug from  Aisheng Dong's bug.

Okay, I had a look at this one today.

> >>>* custom kernel command line parameters
> >>The kernel command line 'gpmi_nand' is to avoid the conflict with
> >>other modules such as
> >>SD.
> >>
> >>If it's be removed, I have to use different config to resolve the
> >>issue which is not better either. :(
> >This is a board-specific issue, so you should handle this at
> >board-level, not at driver level.
> >
> I wish to handle it at the board level.
> 
> But I have no idea how to solve the conflict between GPMI and SD.  :(
> 
> Could you give me some hint?

For starters, you could move some kerel-parameter to the board-file and create the
devices as needed depending on that:

if (gpmi_nand)
	mx28_add_gpmi_nand(&mx28evk_gpmi_nand_data);
else
	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);

or something alike unless I miss something. This is probably not the best
solution as well, but at least it keeps the driver free from the
board-configuration.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110809/5fc77cd0/attachment.sig>
