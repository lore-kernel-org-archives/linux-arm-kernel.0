From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Oct 2012 09:52:08 +0100
Subject: [PATCH] dma: add new DMA control commands
In-Reply-To: <507FA595.4020507@freescale.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
 <1350541111.5263.3.camel@vkoul-udesk3> <507FA595.4020507@freescale.com>
Message-ID: <20121018085208.GR21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 02:45:41PM +0800, Huang Shijie wrote:
> ? 2012?10?18? 14:18, Vinod Koul ??:
>> Why cant you do start (prepare clock etc) when you submit the descriptor
>> to dmaengine. Can be done in tx_submit callback.
>> Similarly remove the clock when dma transaction gets completed.
> I ever thought this method too.
>
> But it will become low efficient in the following case:
>
>   Assuming the gpmi-nand driver has to read out 1024 pages in one  
> _SINGLE_ read operation.
> The gpmi-nand will submit the descriptor to dmaengine per page. So with  
> your method,
> the system will repeat the enable/disable dma clock 1024 time. At every  
> enable/disable dma clock,
> the system has to enable the clock chain and it's parents ...

And what if you stop using clk_prepare_enable(), and prepare the clock
when the channel is requested and only use clk_enable() in the tx_submit
method?
