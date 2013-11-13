From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 13 Nov 2013 14:38:41 +0100
Subject: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <52837A59.5070508@tabi.org>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <52822529.5090502@tabi.org> <20131112132441.GG30263@pengutronix.de>
 <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
 <20131113121630.GH30263@pengutronix.de> <52837A59.5070508@tabi.org>
Message-ID: <20131113133841.GI30263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 07:10:49AM -0600, Timur Tabi wrote:
> Markus Pargmann wrote:
> >>>Can you change the code so that the interrupts are enabled only on
> >>>i.MX?  On PowerPC, the interrupts are used only for debugging.
> 
> >Why is this necessary? The interrupts were enabled for all
> >architectures before.
> 
> My concern is with these lines:
> 
> 	write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TDMAE);
> ...
> 	write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TDMAE, 0);
> 
> This toggles the TDMAE interrupt on PowerPC, which I believe is
> VITAL to making it work.  The SSI and the DMA controller talk to
> each other automatically, and if I'm reading the documentation
> correctly, that communication depends on TDMAE and RDMAE.

Is it necessary to keep TDMAE enabled the whole time? In the patch we
enable it when playback starts and disable when it stops, so the
communication between DMA and SSI shouldn't be disturbed.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
