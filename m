From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 15 Aug 2012 17:09:56 +0800
Subject: [PATCH v3 1/4] dmaengine: mmp-pdma support
In-Reply-To: <20120815080416.GH18957@n2100.arm.linux.org.uk>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-2-git-send-email-zhangfei.gao@marvell.com>
 <20120814083026.GG18957@n2100.arm.linux.org.uk>
 <CAMj5Bkhu2r_R6q3g2aJk1r9Ytz+1eK7gfy6vWuAg1+OPUN7z8Q@mail.gmail.com>
 <20120815080416.GH18957@n2100.arm.linux.org.uk>
Message-ID: <CAMj5BkgzMTCThfHw7jd01KsECCWO5Uaw2dZNrDGrrGiXoaRmFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 4:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 15, 2012 at 03:44:35PM +0800, zhangfei gao wrote:
>> Still have one question.
>> vchan_tx_submit is sending vd node to submitted list.
>> list_add_tail(&vd->node, &vc->desc_submitted);
>>
>> While what we want is send the desc chain, including many nodes,
>> and the first desc will have call back.
>> chain 1: first -> desc -> desc -> desc
>> chain 2: first -> desc -> desc -> desc
>> Once the dma chain done, irq happen and call back from first desc.
>
> I don't understand why you want a DMA engine descriptor to represent
> one single DMA hardware scatterlist entry.  This makes much more
> difficult when reporting status, especially the DMA residue (which
> your existing driver does not support.)
>
> Why not hang several DMA hardware scatterlist entries off the same
> DMA engine descriptor?

The cookie can be used to compute tx_status.
For example, one descriptor chain has 10 descriptor, with cookie++.
tx_submit will return final cookie=9.
dma_async_is_tx_complete will use this cookie to check the status.

If using single descriptor describing big chunc of data, with only cookie.
Then driver has to directly check the dma register to get status.

I think the residue may only meaningful to cyclic dma, for audio.
For peripheral dma, irq after one descriptor chain, do we have to set it?
If needed it, how about get such info in irq.

Thanks
