From: broonie@kernel.org (Mark Brown)
Date: Sat, 18 Apr 2015 18:34:07 +0100
Subject: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
In-Reply-To: <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
Message-ID: <20150418173407.GE26185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 04:14:07PM +0800, Koro Chen wrote:

> +Each external interface (called "IO" in this driver) is presented as a
> +DAI to ASoC. An IO must be connected via the interconnect to a memif.
> +The connection paths are configured through the device tree.

Why are these connection paths configured via device tree?  I would
expect that either there would be runtime configurability of these
things (particularly if loopback configurations within the hardware are
possible) or we'd just allocate memory interfaces to DAIs automatically
as DAIs come into use.

> +- mem-interface-playback:
> +  mem-interface-capture: property of memif, format is: <memif irq use_sram>;
> +	                 memif: which memif to be used
> +			        (defined in include/dt-bindings/sound/mtk-afe.h)
> +		         irq: which irq to be used
> +			      (defined in include/dt-bindings/sound/mtk-afe.h)
> +		         use_sram: 1 is yes, 0 is no

Again, this looks like stuff we should be able to figure out at runtime
- the use of SRAM in particular looks like something we might want to
change depending on use case.  Assuming it adds buffering then for a
VoIP application we might not want to use SRAM to minimize latency but
during music playback we might want to enable SRAM to minimize power
consumption.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150418/f9a9b312/attachment.sig>
