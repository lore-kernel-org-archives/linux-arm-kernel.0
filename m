From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Sep 2014 11:55:18 +0100
Subject: [PATCH] of: amba: use of_dma_configure for AMBA devices
In-Reply-To: <20140918125535.GB17701@e104818-lin.cambridge.arm.com>
References: <90bd1ff3c93b827c12e1b3dc9ad3f227632d0f6e.1410954967.git.robin.murphy@arm.com>
 <20140917170338.GC18532@arm.com>
 <CAL_JsqKTZyPgbxy=pPmFPKRxa97oaWqC6u6pBvqvja_URLno4Q@mail.gmail.com>
 <20140917180524.GG18532@arm.com> <541AC384.8010806@arm.com>
 <20140918125535.GB17701@e104818-lin.cambridge.arm.com>
Message-ID: <20140922105515.GI30085@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 01:55:36PM +0100, Catalin Marinas wrote:
> On Thu, Sep 18, 2014 at 12:35:32PM +0100, Robin Murphy wrote:
> > On 17/09/14 19:05, Will Deacon wrote:
> > > On Wed, Sep 17, 2014 at 06:47:19PM +0100, Rob Herring wrote:
> > >> On Wed, Sep 17, 2014 at 12:03 PM, Will Deacon <will.deacon@arm.com> wrote:
> > >>> On Wed, Sep 17, 2014 at 12:56:07PM +0100, Robin Murphy wrote:
> > >>>> Commit 591c1e ("of: configure the platform device dma parameters)
> > >>>> introduced a common mechanism to configure DMA from DT properties.
> > >>>> AMBA devices created from DT can take advantage of this, too.
> > >>>>
> > >>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > >>>
> > >>>    Acked-by: Will Deacon <will.deacon@arm.com>
> > >>>
> > >>> It would be great if the arm-soc guys can pick this up.
> > >>
> > >> Is this a dependency for something else? If so,
> > >>
> > >> Acked-by: Rob Herring <robh@kernel.org>
> > >
> > > Yeah, it's going to be needed by my IOMMU init rework so that AMBA devices
> > > get registered with their IOMMUs.
> > 
> > Noob question: Does that mean I should resend (with ACKs) to 
> > arm at kernel.org? (I wasn't entirely sure where this should go, hence just 
> > throwing at the list with CCs)
> 
> If it is not part of a larger series you want to merge, Rob could pick
> it up (he could add the acks as well).
> 
> Alternatively, I can get it via the arm64 tree together with an
> additional patch removing the bus hooks in dma-mapping.c (maybe that's a
> better option if no-one objects).

So I plan to take this patch via the arm64 tree together with the patch
below (after some more testing):

----8<----------------------------

>From 2189064795dc3fb4101e5c34d28c6b62b8a3bfd9 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 22 Sep 2014 11:48:31 +0100
Subject: [PATCH] arm64: Implement set_arch_dma_coherent_ops() to replace bus
 notifiers

Commit 6ecba8eb51b7 (arm64: Use bus notifiers to set per-device coherent
DMA ops) introduced bus notifiers to set the coherent dma ops based on
the 'dma-coherent' DT property. Since the generic of_dma_configure()
handles this property for platform and AMBA devices, replace the
notifiers with set_arch_dma_coherent_ops().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/dma-mapping.h |  7 +++++++
 arch/arm64/mm/dma-mapping.c          | 31 -------------------------------
 2 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index dc82e52acdb3..adeae3f6f0fc 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -52,6 +52,13 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 	dev->archdata.dma_ops = ops;
 }
 
+static inline int set_arch_dma_coherent_ops(struct device *dev)
+{
+	set_dma_ops(dev, &coherent_swiotlb_dma_ops);
+	return 0;
+}
+#define set_arch_dma_coherent_ops	set_arch_dma_coherent_ops
+
 #include <asm-generic/dma-mapping-common.h>
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4164c5ace9f8..d6ceb3df0047 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -22,11 +22,8 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
-#include <linux/amba/bus.h>
 
 #include <asm/cacheflush.h>
 
@@ -308,40 +305,12 @@ struct dma_map_ops coherent_swiotlb_dma_ops = {
 };
 EXPORT_SYMBOL(coherent_swiotlb_dma_ops);
 
-static int dma_bus_notifier(struct notifier_block *nb,
-			    unsigned long event, void *_dev)
-{
-	struct device *dev = _dev;
-
-	if (event != BUS_NOTIFY_ADD_DEVICE)
-		return NOTIFY_DONE;
-
-	if (of_property_read_bool(dev->of_node, "dma-coherent"))
-		set_dma_ops(dev, &coherent_swiotlb_dma_ops);
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block platform_bus_nb = {
-	.notifier_call = dma_bus_notifier,
-};
-
-static struct notifier_block amba_bus_nb = {
-	.notifier_call = dma_bus_notifier,
-};
-
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 
 static int __init swiotlb_late_init(void)
 {
 	size_t swiotlb_size = min(SZ_64M, MAX_ORDER_NR_PAGES << PAGE_SHIFT);
 
-	/*
-	 * These must be registered before of_platform_populate().
-	 */
-	bus_register_notifier(&platform_bus_type, &platform_bus_nb);
-	bus_register_notifier(&amba_bustype, &amba_bus_nb);
-
 	dma_ops = &noncoherent_swiotlb_dma_ops;
 
 	return swiotlb_late_init_with_default_size(swiotlb_size);
