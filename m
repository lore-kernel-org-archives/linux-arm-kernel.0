From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 12 Jan 2017 14:19:49 +0000
Subject: [PATCH v5 3/3] dmaengine: xilinx_dma: Fix race condition in the
 driver for multiple descriptor scenario
In-Reply-To: <20170110084917.GA3573@localhost>
References: <1483771530-8545-1-git-send-email-appanad@xilinx.com>
 <1483771530-8545-4-git-send-email-appanad@xilinx.com>
 <20170110084917.GA3573@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A6662F1@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review...    

> On Sat, Jan 07, 2017 at 12:15:30PM +0530, Kedareswara rao Appana wrote:
> > When driver is handling AXI DMA SoftIP When user submits multiple
> > descriptors back to back on the S2MM(recv) side with the current
> > driver flow the last buffer descriptor next bd points to a invalid
> > location resulting the invalid data or errors in the DMA engine.
> 
> Can you rephrase this, it a bit hard to understand.

When DMA is receiving packets h/w expects the descriptors
Should be in the form of a ring (I mean h/w buffer descriptor
Next descriptor field should always point to valid address
So that when DMA engine go and fetch that next descriptor it always 
Sees a valid address).

But with the current driver implementation when user queues
Multiple descriptors the last descriptor next descriptor field
Pointing to an invalid location causing data corruption or 
Errors from the DMA h/w engine...

To avoid this issue creating a Buffer descriptor Chain during 
Channel allocation and using those buffer descriptors for processing
User requested data.

Please let me know if the above explanation is not clear will explain in detail....

> 
> >
> > This patch fixes this issue by creating a BD Chain during
> 
> whats a BD?

Buffer descriptor.

> 
> > channel allocation itself and use those BD's.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> >
> >  drivers/dma/xilinx/xilinx_dma.c | 133
> > +++++++++++++++++++++++++---------------
> >  1 file changed, 83 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index 0e9c02e..af2159d 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -163,6 +163,7 @@
> >  #define XILINX_DMA_BD_SOP		BIT(27)
> >  #define XILINX_DMA_BD_EOP		BIT(26)
> >  #define XILINX_DMA_COALESCE_MAX		255
> > +#define XILINX_DMA_NUM_DESCS		255
> 
> why 255?

It is not an h/w limitation 
Allocating 255 descriptors (Each descriptor is capable of sending 7MB data)
So roughly using allocated descriptors DMA engine can transfer 1GB data
And in the driver we are reusing the allocated descriptors when they are free.

Regards,
Kedar.
