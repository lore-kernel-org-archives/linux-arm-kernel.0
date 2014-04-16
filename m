From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Apr 2014 15:56:57 +0530
Subject: [PATCH v7 2/2] dma: Add Xilinx AXI Video Direct Memory Access
 Engine driver support
In-Reply-To: <CA+mB=1LDGCY3sN5sL1giOwwqHjD8gG74Yy0dXRS8s+MtDOvxHw@mail.gmail.com>
References: <1396008222-7058-1-git-send-email-sthokal@xilinx.com>
 <1396008222-7058-3-git-send-email-sthokal@xilinx.com>
 <20140416090605.GP32284@intel.com>
 <CA+mB=1LDGCY3sN5sL1giOwwqHjD8gG74Yy0dXRS8s+MtDOvxHw@mail.gmail.com>
Message-ID: <20140416102657.GS32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 03:41:34PM +0530, Srikanth Thokala wrote:
> On Wed, Apr 16, 2014 at 2:36 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Fri, Mar 28, 2014 at 05:33:42PM +0530, Srikanth Thokala wrote:
> >> This is the driver for the AXI Video Direct Memory Access (AXI
> >> VDMA) core, which is a soft Xilinx IP core that provides high-
> >> bandwidth direct memory access between memory and AXI4-Stream
> >> type video target peripherals. The core provides efficient two
> >> dimensional DMA operations with independent asynchronous read
> >> and write channel operation.
> >>
> >> This module works on Zynq (ARM Based SoC) and Microblaze platforms.
> >
> > Okay the series is fine and was going to apply it BUT
> > 1) need ack on DT patch..
> > 2) issues below on managing the descriptor and resetting the cookie :(
> 
> Ok.
> 
> >
> >> +
> >> +/**
> >> + * xilinx_vdma_tx_descriptor - Allocate transaction descriptor
> >> + * @chan: Driver specific VDMA channel
> >> + *
> >> + * Return: The allocated descriptor on success and NULL on failure.
> >> + */
> >> +static struct xilinx_vdma_tx_descriptor *
> >> +xilinx_vdma_alloc_tx_descriptor(struct xilinx_vdma_chan *chan)
> >> +{
> >> +     struct xilinx_vdma_tx_descriptor *desc;
> >> +     unsigned long flags;
> >> +
> >> +     if (chan->allocated_desc)
> >> +             return chan->allocated_desc;
> > ??
> >
> >> +
> >> +     desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> >> +     if (!desc)
> >> +             return NULL;
> >> +
> >> +     spin_lock_irqsave(&chan->lock, flags);
> >> +     chan->allocated_desc = desc;
> > ah why do you need this?
> >
> > So this essentailly prevents you from preparing two trasactions at same time as
> > you would overwrite??
> 
> This will allow to queue up multiple segments on to a single
> transaction descriptor.
> User will submit this single desc and in the issue_pending() we decode multiple
> segments and submit to SG HW engine.  We free up the allocated_desc when it is
> submitted to the HW.  This is added after my discussion with Jaswinder, to best
> utilize HW SG engine.

I think best utilization of HW SG engine would happen if we collate the pending
list when you start dma....

-- 
~Vinod
