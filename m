From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Nov 2012 14:55:15 +0000
Subject: [PATCH 3/6] ASoC: wm8974: include MCLKDIV in pll_factors
In-Reply-To: <1352469625-32024-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-4-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20121109145515.GH23807@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 03:00:22PM +0100, Steffen Trumtrar wrote:

> To calculate the integer part of the frequency ratio, the whole output
> path has to be considered (post and pre are optional):

> 	    Ndiv = (pre * target * 4 * post) / source

> In the current implementation only the fixed- and pre-divider is
> considered, but the post-divider is omitted.
> To calculate Ndiv, this post divider has to be applied before any
> calculation happens. Otherwise Ndiv is considered to be to low in the
> later stages. This leads to a wrong value in the PLLN register, which
> in turn produces a wrong playback speed of the audio signal.

This changelog doesn't mention where you're using MCLKDIV here but it
does rather sound like the PLL configuration is not being done correctly
here.  The expectation is that when the PLL is configured the raw output
frequency from the PLL is specified.  The PLL is then specified as the
system clock with that rate and then any division required to make that
usable happens afterwards.

> +	case WM8974_MCLKDIV_1:
> +				reg = 1;
> +				break;

Please do follow the Linux coding style for kernel code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/140c9be2/attachment.sig>
