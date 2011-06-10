From: sundaram@ti.com (Raju, Sundaram)
Date: Fri, 10 Jun 2011 17:18:46 +0530
Subject: [RFC] dmaengine: add new api for preparing simple slave	transfer
In-Reply-To: <20110610104318.GC24636@n2100.arm.linux.org.uk>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
	<20110609124723.GA24636@n2100.arm.linux.org.uk>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE2EFB@dbde02.ent.ti.com>
	<20110609163206.GB24636@n2100.arm.linux.org.uk>
	<1307686397.10976.116.camel@vkoul-udesk3>
	<E0D41E29EB0DAC4E9F3FF173962E9E940301FE337F@dbde02.ent.ti.com>
	<20110610104318.GC24636@n2100.arm.linux.org.uk>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE3452@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, June 10, 2011 4:13 PM
> To: Raju, Sundaram
> Cc: Koul, Vinod; Dan; davinci-linux-open-source at linux.davincidsp.com; linux-
> omap at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [RFC] dmaengine: add new api for preparing simple slave transfer
> 
> On Fri, Jun 10, 2011 at 03:51:41PM +0530, Raju, Sundaram wrote:
> > Consider a simple video use case of de-interlacing a video buffer.
> > Odd lines have to be transferred first, and then the even lines are
> > transferred separately. This can be done by programming the
> > inter frame gap as the line size of the video buffer in the DMAC.
> > This will require you to have only 2 descriptors, one for the
> > odd lines and another for the even lines. This results in only
> > 2 descriptors being written to DMAC registers.
> 
> How would this be handled with DMACs which can't 'skip' bytes in the
> buffer?  You would have to generate a list of LLIs separately
> describing each 'line' of video and chain them together.

Correct.

> 
> How do you handle the situation where a driver uses your new proposed
> API, but it doesn't support that in hardware.
> 

It should be handled the same way how a sg buffer is handled, 
if LLI chaining feature is not available in the hardware. 

It has to be submitted as a queue of separate descriptors to
the DMAC, where each descriptor will be processed after the 
completion of the previous descriptor.

> > Actually we can deduce the chunk_size from the
> > dma_slave_config itself. It is either the src_addr_width or
> > dst_addr_width based on the direction. Because at a stretch
> > DMAC cannot transfer more than the slave register width.
> 
> I think you're misinterpreting those fields.  (dst|src)_addr_width tells
> the DMA controller the width of each transaction - whether to issue a
> byte, half-word, word or double-word read or write to the peripheral.
> It doesn't say how many of those to issue, it just says what the
> peripheral access size is to be.
> 
> In other words, they describe the width of the FIFO register.

Yes correct, I was just giving an example for considering or
understanding a buffer in 3D and how each dimension should be.

chunk_size = (src|dst)_addr_width, for a special case,
i.e, if DMAC is programmed to transfer the entire 1D buffer
per sync event received from the peripheral.

In slave transfer, the peripheral is going to give a sync event to 
DMAC when the FIFO register is full|empty.

Now DMACs capable of 3D transfer, do transfer of the whole 1D
buffer per sync received or even whole 2D buffer per sync received
(based on the sync rate programmed in the DMAC).

So the DMAC has to be programmed for a 1D size (i.e. chunk size)
equal to that of the width of the FIFO register if the sync rate
programmed in DMAC is "per chunk".  

Regards,
Sundaram
