From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Fri, 7 Sep 2018 12:08:01 +0000
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer
In-Reply-To: <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
 <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <20180829040111.GD2388@vkoul-mobl>
 <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
Message-ID: <MWHPR0201MB362841247B08AFFA21CB0A18C7000@MWHPR0201MB3628.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>
> > > > > -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw-
> > > > >src_addr);
> > > > > -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw-
> > > > >dest_addr);
> > > > > +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR,
> > > > (dma_addr_t)
> > > > > +			     ((u64)hw->src_addr_msb << 32 | hw-
> >src_addr));
> > > >
> > > > so this is:
> > > >         (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)
> > > >
> > > > what is src_addr data type? I think its u32. It would be better to
> > > > update xilinx_write() to take u64 and not dma_addr_t.
> > >
> > > Yes, src_addr_msb and src_addr BD fields are u32. To explain: There is no
> > > prob in xilinx_write it takes dma_addr_t as an arg which is 32/64 bit
> > > depending on _DMA_ADDR_T_64BIT. In 64bit CDMA transfer, there was a
> > bug
> > > i.e in the call to xilinx_write src_addr_msb 32 bits were not passed. To fix
> > > that combine MSB and LSB 32 bits before passing it to xilinx_write.
> >
> > Yeah that part was clear but the implementation can be better..
I thought over it and it seems having a new interface dma_ctrl_write_64
taking lsb and msb bits input looks better and scalable. It will be similar
to existing vdma_desc_write_64 impl. I will send v2 if it looks ok.

Thanks,
Radhey
<snip>
> 
> >
> > --
> > ~Vinod
