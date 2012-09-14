From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 08:15:50 +0530
Subject: [PATCH v5 1/3] dmaengine: mmp-pdma support
In-Reply-To: <1346641427-5002-2-git-send-email-zhangfei.gao@marvell.com>
References: <1346641427-5002-1-git-send-email-zhangfei.gao@marvell.com>
 <1346641427-5002-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1347590750.1943.1.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-03 at 11:03 +0800, Zhangfei Gao wrote:
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
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Applied thanks


-- 
~Vinod
