From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Aug 2012 09:04:16 +0100
Subject: [PATCH v3 1/4] dmaengine: mmp-pdma support
In-Reply-To: <CAMj5Bkhu2r_R6q3g2aJk1r9Ytz+1eK7gfy6vWuAg1+OPUN7z8Q@mail.gmail.com>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-2-git-send-email-zhangfei.gao@marvell.com>
 <20120814083026.GG18957@n2100.arm.linux.org.uk>
 <CAMj5Bkhu2r_R6q3g2aJk1r9Ytz+1eK7gfy6vWuAg1+OPUN7z8Q@mail.gmail.com>
Message-ID: <20120815080416.GH18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 03:44:35PM +0800, zhangfei gao wrote:
> Still have one question.
> vchan_tx_submit is sending vd node to submitted list.
> list_add_tail(&vd->node, &vc->desc_submitted);
> 
> While what we want is send the desc chain, including many nodes,
> and the first desc will have call back.
> chain 1: first -> desc -> desc -> desc
> chain 2: first -> desc -> desc -> desc
> Once the dma chain done, irq happen and call back from first desc.

I don't understand why you want a DMA engine descriptor to represent
one single DMA hardware scatterlist entry.  This makes much more
difficult when reporting status, especially the DMA residue (which
your existing driver does not support.)

Why not hang several DMA hardware scatterlist entries off the same
DMA engine descriptor?
