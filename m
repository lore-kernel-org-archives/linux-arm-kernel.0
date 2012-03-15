From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 17:11:13 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F621C60.5090700@freescale.com>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
Message-ID: <20120315171112.GP3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 11:44:16AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > The SoC is the bit of silicon with the CPU and other devices on it like
> > the DMA controller and SSI or whatever ports.  The card is the PCB this
> > has been soldered down onto.

> Well, I asked about the difference between the soc BINDING and the card
> BINDING.  On PowerPC, at least, there's no distinct binding for either.
> For example, I2C devices are on the PCB, but they're listed as child nodes
> of the I2C controller, which is on the SoC.

Right, but this is the problem in a nutshell - there's nowhere to put
the board binding so the SoC code has to know about and do it.

> However, I don't like the way this is being represented as a PowerPC vs.
> ARM issue, because that's just not correct.  It's an "old binding" vs "new
> binding" issue.  For example:

I think that's just creeping in because the old binding is the existing
practice on PowerPC.

> +	/*
> +	 * In case of imx, the machine driver uses new binding which does
> +	 * not require SSI driver to trigger machine driver's probe, but
> +	 * the pcm device needs to be registered here.
> +	 */
> +	if (ssi_private->ssi_on_imx) {
> +		ssi_private->imx_pcm_pdev =
> +			platform_device_register_simple("imx-pcm-audio",

> This prohibits me from using the new binding on any future PowerPC parts,
> because it clearly says "iMX" on everything.

So long as it's internal to the code (which the above is) I don't think
it really matters, the code can be changed later.  We need to do
something about DMA controllers in general, and there was some recent
discussion on the DT list about a generic binding for them, so leaving
the code as-is with nothing in the DT itself seems like a good place to
leave things initially.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/896de2a3/attachment.sig>
