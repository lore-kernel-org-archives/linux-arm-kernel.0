From: agross@codeaurora.org (Andy Gross)
Date: Mon, 24 Feb 2014 14:50:28 -0600
Subject: Ideas/suggestions to avoid repeated locking and reducing too
 many lists with dmaengine?
In-Reply-To: <530B9784.5060904@ti.com>
References: <530B9784.5060904@ti.com>
Message-ID: <20140224205028.GA24339@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 01:03:32PM -0600, Joel Fernandes wrote:
> Hi folks,
> 
> Just wanted your thoughts/suggestions on how we can avoid overhead in the EDMA
> dmaengine driver. I am seeing a lots of performance drop specially for small
> transfers with EDMA versus before raw EDMA was moved to DMAEngine framework
> (atleast 25%).

I've seen roughly the same drop in my testing.  In my case it had to do with the
nature of how work is done using virt-dma.  The virt-dma is predicated on only
letting one transaction be active at a time and it increases the latency for
getting the next transaction off.  For large transactions, it's negligible.  But
for small transactions, it is pretty evident.


> One of the things I am thinking about is the repeated (spin) locking/unlocking
> of the virt_dma_chan->lock or vc->lock. In many cases, there's only 1 user or
> thread requiring to do a DMA, so I feel the locking is unnecessary and potential
> overhead. If there's a sane way to detect this an avoid locking altogether, that
> would be great.

I'd expect the locking to not be the source of the problem, especially with
your use case.

[snip]

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
