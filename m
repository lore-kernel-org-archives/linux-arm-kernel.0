From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 28 Aug 2018 14:03:30 +0000
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer
In-Reply-To: <20180821155553.GI2388@vkoul-mobl>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
Message-ID: <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod <vkoul@kernel.org>
> Sent: Tuesday, August 21, 2018 9:26 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams at intel.com; Michal Simek <michals@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; lars at metafoo.de;
> dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
> transfer
> 
> On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> > In AXI CDMA simple mode also pass MSB bits of source and destination
> > address to xilinx_write function. This fixes simple CDMA operation
> > mode using 64-bit addressing.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > index a37871e..2e15d86 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struct
> xilinx_dma_chan *chan)
> >
> >  		hw = &segment->hw;
> >
> > -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> >src_addr);
> > -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> >dest_addr);
> > +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> (dma_addr_t)
> > +			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));
> 
> so this is:
>         (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)
> 
> what is src_addr data type? I think its u32. It would be better to
> update xilinx_write() to take u64 and not dma_addr_t.

Yes, src_addr_msb and src_addr BD fields are u32. To explain: There is no
prob in xilinx_write it takes dma_addr_t as an arg which is 32/64 bit 
depending on _DMA_ADDR_T_64BIT. In 64bit CDMA transfer, there was a bug
i.e in the call to xilinx_write src_addr_msb 32 bits were not passed. To fix
that combine MSB and LSB 32 bits before passing it to xilinx_write.

Thanks,
Radhey
> 
> 
> > +		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR,
> (dma_addr_t)
> > +			     ((u64)hw->dest_addr_msb << 32 | hw-
> >dest_addr));
> >
> >  		/* Start the transfer */
> >  		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> ~Vinod
