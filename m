From: eric@anholt.net (Eric Anholt)
Date: Wed, 30 May 2018 12:11:07 -0700
Subject: [PATCH v2] spi: bcm2835aux: ensure interrupts are enabled for
 shared handler
In-Reply-To: <20180523205220.7394-1-robh@kernel.org>
References: <20180523205220.7394-1-robh@kernel.org>
Message-ID: <87sh69nelw.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
> Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
> DT change which breaks compatibility with older kernels. The AUX irqchip
> was already rejected for upstream[1] and the DT change would break
> working systems if the DTB is updated to a newer one. The latter issue
> was brought to my attention by Alex Graf.
>
> The root cause however is a bug in the shared handler. A shared handler
> must correctly identify it actually handled an interrupt. The handler
> here was processing data whether interrupts were enabled or not.
> It would return IRQ_HANDLED if there was any data and not only when
> there was an actual interrupt pending. The result is that another
> device's IRQ could cause the SPI's IRQ handler to run and process data
> when the the SPI driver working in polled mode. Fix this by adding a
> check in the IRQ handler that the TXEMPTY or IDLE interrupts are enabled
> and always return IRQ_NONE when they are not.

FWIW, I see v1 already applied in -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/0171381b/attachment.sig>
