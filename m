From: wmills@ti.com (Bill Mills)
Date: Sun, 5 Jun 2016 23:20:29 -0400
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <1465183229-24147-1-git-send-email-wmills@ti.com>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
Message-ID: <1465183229-24147-5-git-send-email-wmills@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone2 can do DMA coherency but only if:
1) DDR3A DMA buffers are in high physical addresses (0x8_0000_0000)
    (DDR3B does not have this constraint)
2) Memory is marked outer shared
3) DMA Master marks transactions as outer shared
    (This is taken care of in bootloader)

Use outer shared instead of inner shared.
This choice is done at early init time and uses the attr_mod facility

If the kernel is not configured for LPAE and using high PA, or if the
switch to outer shared fails, then we fail to meet this criteria.
Under any of these conditions we veto any dma-coherent attributes in
the DTB.

Signed-off-by: Bill Mills <wmills@ti.com>
---
 arch/arm/mach-keystone/keystone.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index a33a296..d10adaf 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -28,6 +28,7 @@
 #include "keystone.h"
 
 static unsigned long keystone_dma_pfn_offset __read_mostly;
+static bool keystone_dma_coherent;
 
 static int keystone_platform_notifier(struct notifier_block *nb,
 				      unsigned long event, void *data)
@@ -52,21 +53,53 @@ static struct notifier_block platform_nb = {
 	.notifier_call = keystone_platform_notifier,
 };
 
+void veto_dma_coherent(void)
+{
+	struct device_node	*node, *start_node;
+	struct property		*prop;
+
+	for (start_node = NULL;
+	     (node = of_find_node_with_property(start_node, "dma-coherent"));
+	     start_node = node) {
+		prop = of_find_property(node, "dma-coherent", NULL);
+		if (prop)
+			of_remove_property(node, prop);
+	}
+}
+
 static void __init keystone_init(void)
 {
+	/* If we are running from the high physical addresses then adjust
+	 * addresses we give to the device's DMA.  They will be seeing this
+	 * memory through the MSMC address translation which makes the first 2GB
+	 * of high memory appear in the low 4GB space.
+	 * (DMA masters on keystone2 have 32 bit address buses)
+	 */
 	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
 		keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
 						   KEYSTONE_LOW_PHYS_START);
 		bus_register_notifier(&platform_bus_type, &platform_nb);
 	}
+
+	/* if the kernel has not been configured to meet the keystone
+	 * platform requirements to achieve DMA coherency, then ignore any
+	 * device tree configuration for this
+	 */
+	if (!keystone_dma_coherent)
+		veto_dma_coherent();
+
 	keystone_pm_runtime_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static long long __init keystone_pv_fixup(void)
 {
+#ifdef CONFIG_ARM_LPAE
 	long long offset;
 	phys_addr_t mem_start, mem_end;
+	bool dma_ok;
+
+	dma_ok = use_outer_shared();
 
 	mem_start = memblock_start_of_DRAM();
 	mem_end = memblock_end_of_DRAM();
@@ -84,11 +117,15 @@ static long long __init keystone_pv_fixup(void)
 	}
 
 	offset = KEYSTONE_HIGH_PHYS_START - KEYSTONE_LOW_PHYS_START;
+	keystone_dma_coherent = dma_ok;
 
 	/* Populate the arch idmap hook */
 	arch_phys_to_idmap_offset = -offset;
 
 	return offset;
+#else
+	return 0;
+#endif
 }
 
 static const char *const keystone_match[] __initconst = {
-- 
1.9.1
