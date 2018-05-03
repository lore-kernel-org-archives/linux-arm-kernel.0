From: eric@anholt.net (Eric Anholt)
Date: Thu, 03 May 2018 14:15:32 -0700
Subject: [PATCH] spi: bcm2835aux: ensure interrupts are enabled for shared
 handler
In-Reply-To: <20180503180945.3502-1-robh@kernel.org>
References: <20180503180945.3502-1-robh@kernel.org>
Message-ID: <87efiso2yz.fsf@anholt.net>
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
> The root cause however is a bug in the shared handler. Shared handlers
> must check that interrupts are actually enabled before servicing the
> interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.

It looks to me like we'd only return IRQ_HANDLED if we did work that
needed doing.  Is this check effectively doing some interlock to make
sure that we've already started bcm2835aux_spi_transfer_one_irq() and
aren't just racing against transaction setup?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/566dc920/attachment.sig>
