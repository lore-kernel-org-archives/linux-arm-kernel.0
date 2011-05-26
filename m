From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2011 08:36:20 +0100
Subject: [PATCH 2/2] dmaengine: add TODO items for future work on dma
	drivers
In-Reply-To: <1306323570-11133-3-git-send-email-vinod.koul@intel.com>
References: <1306323570-11133-1-git-send-email-vinod.koul@intel.com>
	<1306323570-11133-3-git-send-email-vinod.koul@intel.com>
Message-ID: <20110526073620.GF24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 05:09:30PM +0530, Koul, Vinod wrote:
> +1. Move remaining drivers to use new slave interface
> +2. Remove old slave pointer machansim
> +3. Make issue_pending to start the transaction in below drivers
> +	- mpc512x_dma
> +	- imx-dma
> +	- imx-sdma
> +	- mxs-dma.c
> +	- dw_dmac
> +	- intel_mid_dma
> +	- ste_dma40

I'd suggest adding some more to this:

4. Remove dma_slave_config's dma direction.

It's pointless that dma_slave_config carries the DMA direction (to/from
device) and the prepare function does too.  It leads to DMA engine drivers
having to verify that the two match, and DMA engine users having to issue
two calls every time they change direction.

Instead, lets specify that dma_slave_config carries the _device_ side
parameters, which are selected according to the direction given to the
prepare function.  The memory-side parameters should be selected by the
DMA engine driver according to its knowledge of the system.

This is sensible as M2M transfers don't allow configuration and therefore
already have to select these parameters internally.
