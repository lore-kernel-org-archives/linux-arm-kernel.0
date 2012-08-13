From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Aug 2012 13:12:15 +0000
Subject: [PATCH v2 1/4] dmaengine: mmp-pdma support
In-Reply-To: <1344395701-30888-2-git-send-email-zhangfei.gao@marvell.com>
References: <1344395701-30888-1-git-send-email-zhangfei.gao@marvell.com>
 <1344395701-30888-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201208131312.15180.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 August 2012, Zhangfei Gao wrote:
> 1. virtual channel vs. physical channel
> Virtual channel is managed by dmaengine
> Physical channel handling resource, such as irq
> Physical channel is alloced dynamically as descending priority,
> freed immediately when irq done.
> The availble highest priority physically channel will alwayes be alloced
> 
> Issue pending list -> alloc highest dma physically channel available -> dma done -> free physically channel
> 
> 2. list: running list & pending list
> submit: desc list -> pending list
> issue_pending_list: if (IDLE) pending list -> running list; free pending list (RUN)
> irq: free running list (IDLE)
>      check pendlist -> pending list -> running list; free pending list (RUN)
> 
> 3. irq:
> Each list generate one irq, calling callback
> One list may contain several desc chain, in such case, make sure only the last desc list generate irq.
> 
> 4. async
> Submit will add desc chain to pending list, which can be multi-called
> If multi desc chain is submitted, only the last desc would generate irq -> call back
> If IDLE, issue_pending_list start pending_list, transforming pendlist to running list
> If RUN, irq will start pending list
> 
> 5. test
> 5.1 pxa3xx_nand on pxa910
> 5.2 insmod dmatest.ko (threads_per_chan=y)
> By default drivers/dma/dmatest.c test every channel and test memcpy with 1 threads per channel
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>

Looks all good to, the entire series, except one very small point:

> +Required properties:
> +- compatible: Should be "marvell,pdma-1.0"
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Either contain all of the per-channel DMA interrupts
> +               or one irq for pdma device
> +- dma-channels: Number of DMA channels supported by the controller.

I think the last one should be "#dma-channels", not "dma-channels", since it's
counting the channels. I think we use the "#" version in the preliminary binding
for the generic dma channel assignment in DT.

	Arnd
