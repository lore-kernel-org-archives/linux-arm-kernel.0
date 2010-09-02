From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 2 Sep 2010 11:50:33 +0900
Subject: [PATCH] arm: fix pci_set_consistent_dma_mask for dmabounce devices
In-Reply-To: <20100901085738.GJ8142@n2100.arm.linux.org.uk>
References: <20100819174426O.fujita.tomonori@lab.ntt.co.jp>
	<m3sk1yzkjw.fsf@intrepid.localdomain>
	<20100901085738.GJ8142@n2100.arm.linux.org.uk>
Message-ID: <20100902114937X.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Sep 2010 09:57:38 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Sat, Aug 28, 2010 at 07:58:11PM +0200, Krzysztof Halasa wrote:
> > What's the outcome of the following?
> > 
> > Russell, are you going to apply it as is, or is a better (short-term)
> > fix being made?
> 
> I want to see a better solution to this first - without which we'll
> apply this hack and then quietly forget about the problem.

This restores the trick that had worked.

btw, I can't compile ARCH_IXP4XX without the following patch:

http://www.spinics.net/lists/arm-kernel/msg95933.html

=
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH] arm: fix arm: fix pci_set_consistent_dma_mask for dmabounce devices

This fixes the regression caused by the commit
6fee48cd330c68332f9712bc968d934a1a84a32a.

ARM needs to clip the dma coherent mask for dmabounce devices. This
restores the old trick.

Note that strictly speaking, the DMA API doesn't allow architectures
to do such but I'm not sure it's worth adding the new API to set the
dma mask that allows architectures to clip it.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/arm/common/it8152.c                     |    8 ++++++++
 arch/arm/mach-ixp4xx/common-pci.c            |    8 ++++++++
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    2 ++
 arch/arm/mach-pxa/include/mach/hardware.h    |    2 +-
 arch/arm/mach-pxa/include/mach/io.h          |    2 ++
 include/linux/dma-mapping.h                  |    4 ++++
 6 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 6c09135..f89dc5d 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -263,6 +263,14 @@ static int it8152_pci_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (mask >= PHYS_OFFSET + SZ_64M - 1)
+		return 0;
+
+	return -EIO;
+}
+
 int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
 {
 	it8152_io.start = IT8152_IO_BASE + 0x12000;
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 61cd4d6..06941a0 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -503,6 +503,14 @@ struct pci_bus * __devinit ixp4xx_scan_bus(int nr, struct pci_sys_data *sys)
 	return pci_scan_bus(sys->busnr, &ixp4xx_ops, sys);
 }
 
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (mask >= SZ_64M - 1 )
+		return 0;
+
+	return -EIO;
+}
+
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index f91ca6d..8138371 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -26,6 +26,8 @@
 #define PCIBIOS_MAX_MEM		0x4BFFFFFF
 #endif
 
+#define ARCH_HAS_DMA_SET_COHERENT_MASK
+
 #define pcibios_assign_all_busses()	1
 
 /* Register locations and bits */
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index 7f64d24..428cc7b 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -309,7 +309,7 @@ extern unsigned long get_clock_tick_rate(void);
 #define PCIBIOS_MIN_IO		0
 #define PCIBIOS_MIN_MEM		0
 #define pcibios_assign_all_busses()	1
+#define ARCH_HAS_DMA_SET_COHERENT_MASK
 #endif
 
-
 #endif  /* _ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-pxa/include/mach/io.h b/arch/arm/mach-pxa/include/mach/io.h
index 262691f..fdca3be 100644
--- a/arch/arm/mach-pxa/include/mach/io.h
+++ b/arch/arm/mach-pxa/include/mach/io.h
@@ -6,6 +6,8 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
+#include <mach/hardware.h>
+
 #define IO_SPACE_LIMIT 0xffffffff
 
 /*
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ce29b81..ba8319a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -102,6 +102,9 @@ static inline u64 dma_get_mask(struct device *dev)
 	return DMA_BIT_MASK(32);
 }
 
+#ifdef ARCH_HAS_DMA_SET_COHERENT_MASK
+int dma_set_coherent_mask(struct device *dev, u64 mask);
+#else
 static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
 	if (!dma_supported(dev, mask))
@@ -109,6 +112,7 @@ static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
 	dev->coherent_dma_mask = mask;
 	return 0;
 }
+#endif
 
 extern u64 dma_get_required_mask(struct device *dev);
 
-- 
1.7.1
