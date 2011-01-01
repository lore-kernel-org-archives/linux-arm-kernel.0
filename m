From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Jan 2011 15:15:45 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
Message-ID: <20110101151545.GC25924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 03:45:39PM -0800, Dan Williams wrote:
> Support for the DMA_COMPL flags are necessary if the DMA_MEMCPY
> capability is advertised, yes this driver got this wrong.  I'll update
> the documentation to make this requirement clear, and audit the other
> drivers.  With slave-only drivers the only usage model is one where
> the client driver owns dma-mapping.  In the non-slave (opportunistic
> memcpy offload) case the client is unaware of the engine so the driver
> owns unmapping.  The minimal fix is to disable memcpy offload.

As a side note, the DMA mapping for slaves should be done using the
DMA struct device, not the struct device of the peripheral making use
of the DMA engine.

Why?  The slave device has no knowledge of how the DMA engine is
connected into the system, or the DMA parameters associated with the
device performing the DMA, such as the DMA mask and boundaries.  (If
there are several generic DMA agents in the system, it can't know
which is the correct one to use until a channel has been allocated.)
The only struct device which has this information is the one for the
DMA engine itself.

Therefore, the struct device which is passed into the DMA mapping APIs
to prepare memory for DMA must always be the DMA engine struct device
(chan->device->dev) and never the slave struct device.

This is no different from USB - consider the slave devices to be USB
peripherals, and the DMA engine device to be the USB host controller.
The USB host controller performs all the DMA, and DMA mappings are
setup and torn down against the DMA host controller device structure.
