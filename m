From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 15 Aug 2012 15:44:35 +0800
Subject: [PATCH v3 1/4] dmaengine: mmp-pdma support
In-Reply-To: <20120814083026.GG18957@n2100.arm.linux.org.uk>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-2-git-send-email-zhangfei.gao@marvell.com>
 <20120814083026.GG18957@n2100.arm.linux.org.uk>
Message-ID: <CAMj5Bkhu2r_R6q3g2aJk1r9Ytz+1eK7gfy6vWuAg1+OPUN7z8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 4:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Please consider looking at the virtual dma channel support, which I've
> recently added.  This removes the burden of managing the descriptor
> lists from the driver, deals with the workqueues for completing
> descriptors, etc.
>
> All you need to do is to build the descriptors for the DMA operation,
> manage the scheduling of virtual channels onto physical channels,
> calculate the position of DMA, and starting off and handling the DMA
> hardware.
>
> "virtual dma channel support" is probably something of a misnomer though;
> it can also be used for situations where there's a 1:1 binding between
> virtual and physical dma channels (iow, no virtual channels at all.)
>

Thanks Russell.

Have noticed virt-dma.c before.
The reason not use it is I thought it would be simpler
and easy-debugging to manage virt-channel via two lists:
pending and running lists.

Still have one question.
vchan_tx_submit is sending vd node to submitted list.
list_add_tail(&vd->node, &vc->desc_submitted);

While what we want is send the desc chain, including many nodes,
and the first desc will have call back.
chain 1: first -> desc -> desc -> desc
chain 2: first -> desc -> desc -> desc
Once the dma chain done, irq happen and call back from first desc.

Is that mean vchan_tx_submit is not covering this situation?

Thanks
