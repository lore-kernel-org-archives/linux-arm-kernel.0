From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 7 Jul 2015 15:31:58 +0000
Subject: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <20150627144054.GW19530@localhost>
References: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
 <20150622104932.GC19530@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A49A91915@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150627144054.GW19530@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A49A95945@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Vinod,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Saturday, June 27, 2015 8:11 PM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Michal Simek; Soren Brinkmann; Anirudha
> Sarangi; Punnaiah Choudary Kalluri; dmaengine at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Srikanth Thokala
> Subject: Re: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine
> driver support
> 
> On Wed, Jun 24, 2015 at 05:12:13PM +0000, Appana Durga Kedareswara Rao
> wrote:
> > > where is the hardware addr programmed? I can see you are using sg
> > > list passed for porgramming one side of a transfer where is other
> > > side programmed?
> >
> > The actual programming happens in the start_transfer(I mean in
> > issue_pending) API There are two modes
> >
> > All the h/w addresses are configured in the start_transfer API.
> >
> > In simple transfer Mode the below write triggers the transfer
> > dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> >                                hw->control &
> > XILINX_DMA_MAX_TRANS_LEN);
> >
> > In SG Mode the below write triggers the transfer.
> > dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC, tail->phys);
> >
> > There are two Channels MM2S (Memory to device) and S2MM (Device to
> Memory) channel.
> > --> In MM2S case we need to configure the SOF (Start of frame) for the
> > --> first BD and we need to set EOF(end of frame) for the last BD For
> > --> S2MM case no need to configure SOF and EOF. Once we got the IOC
> > --> interrupt will call mark the cookie as complete and will
> > Call the user callback. There users checks for the data.
> >
> > Please let me know if you are not clear.
> No sorry am not...
> 
> I asked how the device address in configured. For both MM2S S2MM you are
> using sg for memory address, where are you getting device adress, are you
> assuming/hardcoding or getting somehow, if so how?

As Nicolae Rosia explained there is no concept of address for this DMA.
Connections are made at the design time. 
http://www.fpgadeveloper.com/wp-content/uploads/2014/08/fpga_developer_20140806_130447.png


> 
> > > no dma_slave_config handler?
> > No need of this callback earlier in the dma_slave_config we are doing
> > terminate_all Now we have a separate API for that so no need to have this
> call back.
> 
> The question was on parameters

There is no address related parameters need to configure for this DMA.
That's why no need of dma_slave_config handler. 

Regards,
Kedar.

> 
> --
> ~Vinod
