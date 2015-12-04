From: brian.starkey@arm.com (Brian Starkey)
Date: Fri, 4 Dec 2015 10:37:52 +0000
Subject: [PATCH] drivers: dma-coherent: use ioremap_wc() for DMA_MEMORY_MAP
In-Reply-To: <1448029226-4914-1-git-send-email-brian.starkey@arm.com>
References: <1448029226-4914-1-git-send-email-brian.starkey@arm.com>
Message-ID: <20151204103752.GA21574@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Is there anything I can do to help get this merged?
It fixes a real problem we have on our arm64 development boards.

>From my reading of Documentation/DMA-API.txt it seems like this was
the intended behavior in the first place.

Best regards,
Brian

On Fri, Nov 20, 2015 at 02:20:26PM +0000, Brian Starkey wrote:
>When the DMA_MEMORY_MAP flag is used, memory which can be accessed
>directly should be returned, so use ioremap_wc() instead of ioremap().
>Also, ensure that the correct memset operation is used in
>dma_alloc_from_coherent() with respect to the region's flags.
>
>This fixes the below alignment fault on arm64, caused by invalid use
>of memset() on Device memory.
>
>   Unhandled fault: alignment fault (0x96000061) at 0xffffff8000380000
>   Internal error: : 96000061 [#1] PREEMPT SMP
>   Modules linked in: hdlcd(+) clk_scpi
>   CPU: 4 PID: 1355 Comm: systemd-udevd Not tainted 4.4.0-rc1+ #5
>   Hardware name: ARM Juno development board (r0) (DT)
>   task: ffffffc9763eee00 ti: ffffffc9758c4000 task.ti: ffffffc9758c4000
>   PC is at __efistub_memset+0x1ac/0x200
>   LR is at dma_alloc_from_coherent+0xb0/0x120
>   pc : [<ffffffc00030ff2c>] lr : [<ffffffc00042a918>] pstate: 400001c5
>   sp : ffffffc9758c79a0
>   x29: ffffffc9758c79a0 x28: ffffffc000635cd0
>   x27: 0000000000000124 x26: ffffffc000119ef4
>   x25: 0000000000010000 x24: 0000000000000140
>   x23: ffffffc07e9ac3a8 x22: ffffffc9758c7a58
>   x21: ffffffc9758c7a68 x20: 0000000000000004
>   x19: ffffffc07e9ac380 x18: 0000000000000001
>   x17: 0000007fae1bbba8 x16: ffffffc0001b2d1c
>   x15: ffffffffffffffff x14: 0ffffffffffffffe
>   x13: 0000000000000010 x12: ffffff800837ffff
>   x11: ffffff800837ffff x10: 0000000040000000
>   x9 : 0000000000000000 x8 : ffffff8000380000
>   x7 : 0000000000000000 x6 : 000000000000003f
>   x5 : 0000000000000040 x4 : 0000000000000000
>   x3 : 0000000000000004 x2 : 000000000000ffc0
>   x1 : 0000000000000000 x0 : ffffff8000380000
>
>Signed-off-by: Brian Starkey <brian.starkey@arm.com>
>Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>---
> drivers/base/dma-coherent.c |   10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
>index 55b8398..45358d0 100644
>--- a/drivers/base/dma-coherent.c
>+++ b/drivers/base/dma-coherent.c
>@@ -31,7 +31,10 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr, dma_addr_t device_add
> 	if (!size)
> 		goto out;
>
>-	mem_base = ioremap(phys_addr, size);
>+	if (flags & DMA_MEMORY_MAP)
>+		mem_base = ioremap_wc(phys_addr, size);
>+	else
>+		mem_base = ioremap(phys_addr, size);
> 	if (!mem_base)
> 		goto out;
>
>@@ -181,7 +184,10 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
> 	 */
> 	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
> 	*ret = mem->virt_base + (pageno << PAGE_SHIFT);
>-	memset(*ret, 0, size);
>+	if (mem->flags & DMA_MEMORY_MAP)
>+		memset(*ret, 0, size);
>+	else
>+		memset_io(*ret, 0, size);
> 	spin_unlock_irqrestore(&mem->spinlock, flags);
>
> 	return 1;
>-- 
>1.7.9.5
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
