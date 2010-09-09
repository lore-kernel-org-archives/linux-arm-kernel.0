From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 9 Sep 2010 18:39:53 +0200
Subject: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on platform
	sdhci api
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0789F0@zch01exm22.fsl.freescale.net>
References: <1283334533-12793-1-git-send-email-r65037@freescale.com>
	<20100906104729.GB2617@pengutronix.de>
	<A88EF4D64D8447468743DC1503C0B6CA0787D4@zch01exm22.fsl.freescale.net>
	<20100907102817.GA7534@pengutronix.de>
	<A88EF4D64D8447468743DC1503C0B6CA0789F0@zch01exm22.fsl.freescale.net>
Message-ID: <20100909163952.GI3773@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> BTW, Do you know that how to define and pass the kinds of
> platform_data-struct special to the board to the sdhci_pltfm.c layer
> platform-data struct?

I think we should extend the pdata->init call to also have the
platform_data as an argument. Then, the platform-specific init routine
should have all it needs. Will update that tomorrow.

> [<Zhu Richard-r65037>] The one used in sdhci-of-esdhc.c is better than
> the one listed abov; it's more logical and clear. :)

Good, it seems to be complete, too :)

> > I find that the sdhci.c had been support the 8bits bus_width.
> 
> Yes, it was added recently, but it might have issues. See here:
> 
> http://thread.gmane.org/gmane.linux.kernel.mmc/3370
> [<Zhu Richard-r65037>] Different IC design may have the different
> definitions of the bus width configuration in the HOST_CONTROL register.
> This is not a big issue; we can handle these differences in the SW.

Yes, my point is that we don't handle this at the generic
sdhci-core, but at the parts which deal with the platform-specific
faul^H^H^H^H... differences ;)

> About the 8bits supports, I had been verified this feature on i.MX
> platforms for a while.
> The MMC cards 8bits mode can work well on some i.MX eSDHC platforms.

Why only some? Are the others not working or not tested?

> One more suggestion, the caps should be handled carefully, because not
> only the caps of the IC design, but also the caps of the board HW design
> should be taken care,

Could you give an example when it is board-dependent?

> [<Zhu Richard-r65037>] I'm checking it, and still trying finding a way
> to pass the board related info (such as the WP pins, and bus width to
> sdhci-platfm.c layer)

See above. And here is my current WIP. I factored out the common stuff
from of and pltfm. Furthermore, I addressed Uwe's comments about adding
MX35-devices. Expect a few updates (platform-data) tomorrow.

http://git.pengutronix.de/?p=wsa/linux-2.6.git;a=shortlog;h=refs/heads/pcm043-wip

(The old branch is still there, just in case you are working with it)

> The host->ops->get_ro should be added into the sdhci.c file although
> following the method provided in the RFC patches. How do you think about
> that?

I agree, that one seems needed. Shall I integrate this into my series
or do you want to place this patch ontop of my series?

Kind regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100909/51c24ec9/attachment.sig>
