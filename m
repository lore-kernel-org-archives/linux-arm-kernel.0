From: rabin@rab.in (Rabin Vincent)
Date: Mon, 3 Jan 2011 16:42:18 +0530
Subject: [PATCH 6/7] ARM: PL011: Add support for transmit DMA
In-Reply-To: <E1PZhMW-0007pl-6b@rmk-PC.arm.linux.org.uk>
References: <20110103100753.GB26785@n2100.arm.linux.org.uk>
	<E1PZhMW-0007pl-6b@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTi=kRbUTtBFmaS6X8ybfsnN1Br8MGysx8dTFcvsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 3, 2011 at 15:40, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> + ? ? ? if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
> + ? ? ? ? ? ? ? uap->dmatx.queued = false;
> + ? ? ? ? ? ? ? dev_dbg(uap->port.dev, "unable to map TX DMA\n");
> + ? ? ? ? ? ? ? return -EBUSY;
> + ? ? ? }
> +
> + ? ? ? desc = dma_dev->device_prep_slave_sg(chan, &dmatx->sg, 1, DMA_TO_DEVICE,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> + ? ? ? if (!desc) {
> + ? ? ? ? ? ? ? uap->dmatx.queued = false;

Doesn't dma_unmap_sg need to be called here?

> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* If DMA cannot be used right now, we complete this
> + ? ? ? ? ? ? ? ?* transaction via IRQ and let the TTY layer retry.
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? dev_dbg(uap->port.dev, "TX DMA busy\n");
> + ? ? ? ? ? ? ? return -EBUSY;
> + ? ? ? }
