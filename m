From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 27 Jun 2015 20:10:54 +0530
Subject: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A49A91915@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
 <20150622104932.GC19530@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A49A91915@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20150627144054.GW19530@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 05:12:13PM +0000, Appana Durga Kedareswara Rao wrote:
> > where is the hardware addr programmed? I can see you are using sg list
> > passed for porgramming one side of a transfer where is other side
> > programmed?
> 
> The actual programming happens in the start_transfer(I mean in issue_pending) API
> There are two modes
> 
> All the h/w addresses are configured in the start_transfer API.
> 
> In simple transfer Mode the below write triggers the transfer
> dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
>                                hw->control & XILINX_DMA_MAX_TRANS_LEN);
> 
> In SG Mode the below write triggers the transfer.
> dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC, tail->phys);
> 
> There are two Channels MM2S (Memory to device) and S2MM (Device to Memory) channel.
> --> In MM2S case we need to configure the SOF (Start of frame) for the first BD and we need to set EOF(end of frame) for the last BD
> --> For S2MM case no need to configure SOF and EOF. Once we got the IOC interrupt will call mark the cookie as complete and will
> Call the user callback. There users checks for the data.
> 
> Please let me know if you are not clear.
No sorry am not...

I asked how the device address in configured. For both MM2S S2MM you are
using sg for memory address, where are you getting device adress, are you
assuming/hardcoding or getting somehow, if so how?

> > no dma_slave_config handler?
> No need of this callback earlier in the dma_slave_config we are doing terminate_all
> Now we have a separate API for that so no need to have this call back.

The question was on parameters

-- 
~Vinod
