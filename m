From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu,  7 May 2015 14:00:19 +0200
Subject: [PATCH] arm/mm/dma-mapping.c: Add arm_coherent_dma_mmap
Message-ID: <1431000019-7483-1-git-send-email-mike.looijmans@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When dma-coherent transfers are enabled, the mmap call must
not change the pg_prot flags in the vma struct.

Split the arm_dma_mmap into a common and specific parts,
and add a "arm_coherent_dma_mmap" implementation that does
not alter the page protection flags.

Tested on a topic-miami board (Zynq) using the ACP port
to transfer data between FPGA and CPU using the Dyplo
framework. Without this patch, byte-wise access to mmapped
coherent DMA memory was about 20x slower because of the
memory being marked as non-cacheable, and transfer speeds
would not exceed 240MB/s.

After this patch, the mapped memory is cacheable and the
transfer speed is again 600MB/s (limited by the FPGA) when
the data is in the L2 cache, while data integrity is being
maintained.

The patch has no effect on non-coherent DMA.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 arch/arm/boot/dts/topic-dyplo.dtsi |  1 +
 arch/arm/mm/dma-mapping.c          | 32 +++++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/topic-dyplo.dtsi b/arch/arm/boot/dts/topic-dyplo.dtsi
index 0deedb6..fa5901b 100644
--- a/arch/arm/boot/dts/topic-dyplo.dtsi
+++ b/arch/arm/boot/dts/topic-dyplo.dtsi
@@ -6,5 +6,6 @@
 		reg = <0x64400000 0x200000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 57 0x4>;
+		dma-coherent;
 	};
 };
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 903dba0..4815259 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -148,11 +148,14 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs);
 static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
 				  dma_addr_t handle, struct dma_attrs *attrs);
+static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 struct dma_attrs *attrs);
 
 struct dma_map_ops arm_coherent_dma_ops = {
 	.alloc			= arm_coherent_dma_alloc,
 	.free			= arm_coherent_dma_free,
-	.mmap			= arm_dma_mmap,
+	.mmap			= arm_coherent_dma_mmap,
 	.get_sgtable		= arm_dma_get_sgtable,
 	.map_page		= arm_coherent_dma_map_page,
 	.map_sg			= arm_dma_map_sg,
@@ -677,10 +680,7 @@ static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 			   __builtin_return_address(0));
 }
 
-/*
- * Create userspace mapping for the DMA-coherent memory.
- */
-int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 struct dma_attrs *attrs)
 {
@@ -691,8 +691,6 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
 	unsigned long off = vma->vm_pgoff;
 
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-
 	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
@@ -708,6 +706,26 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 }
 
 /*
+ * Create userspace mapping for the DMA-coherent memory.
+ */
+static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 struct dma_attrs *attrs)
+{
+	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+}
+
+int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		 struct dma_attrs *attrs)
+{
+#ifdef CONFIG_MMU
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+#endif	/* CONFIG_MMU */
+	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+}
+
+/*
  * Free a buffer as defined by the above mapping.
  */
 static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-- 
1.9.1
