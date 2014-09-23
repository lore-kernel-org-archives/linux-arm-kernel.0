From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 23 Sep 2014 17:21:06 +0000
Subject: [PATCH] dmaengine: fsl-edma: fixup reg offset and hw S/G	support
 in big-endian model
In-Reply-To: <20140923103721.GQ5182@n2100.arm.linux.org.uk>
References: <1411463719-7728-1-git-send-email-jingchang.lu@freescale.com>,
 <20140923103721.GQ5182@n2100.arm.linux.org.uk>
Message-ID: <1411492862884.42316@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_______________________________________
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Sent: Tuesday, September 23, 2014 6:37 PM
To: Lu Jingchang-B35083
Cc: vinod.koul at intel.com; dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] dmaengine: fsl-edma: fixup reg offset and hw S/G   support in big-endian model

On Tue, Sep 23, 2014 at 05:15:19PM +0800, Jingchang Lu wrote:
>  static u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
>  {
> -     if (edma->big_endian)
> -             return ioread16be(addr);
> -     else
> +     u32 dst;

This should be unsigned long, if it needs to exist.

> +     /* swap the reg offset for these in big-endian mode */
> +     if (edma->big_endian) {
> +             dst = ((u32)addr & ~0x3) | (((u32)addr & 0x3) ^ 0x2);

This can be simplified to:

                addr = (void __iomem *)((unsigned long)addr ^ 2);

Ditto for all the other cases.

I will do that, Thanks.

Best Regards,
Jingchang
