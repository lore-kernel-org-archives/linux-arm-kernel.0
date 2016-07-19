From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 19 Jul 2016 15:35:18 +0300
Subject: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
In-Reply-To: <20160718103409.GH5783@n2100.arm.linux.org.uk>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
Message-ID: <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/16 13:34, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
>> Before looking for the next descriptor to start, complete the just finished
>> cookie.
> 
> This change will reduce performance as we no longer have an overlap
> between the next request starting to be dealt with in the hardware
> vs the previous request being completed.

vchan_cookie_complete() will only mark the cookie completed, adds the vd to
the desc_completed list (it was deleted from desc_issued list when it was
started by omap_dma_start_desc) and schedule the tasklet to deal with the real
completion later.
Marking the just finished descriptor/cookie done first then looking for
possible descriptors in the queue to start feels like a better sequence.

After a quick grep in the kernel source: only omap-dma.c was starting the next
transfer before marking the current completed descriptor/cookie done.

> Your commit log doesn't
> say _why_ the change is being made, it merely tells us what the
> patch is doing, which we can see already.
> 
> Please describe changes a little better.
> 


-- 
P?ter
