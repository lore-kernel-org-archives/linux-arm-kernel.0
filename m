From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 24 Mar 2014 17:17:52 +0100
Subject: [PATCH 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1395677872-32741-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 375 and Armada 38x SOCs, which use the Cortex-A9
CPU core, the PL310 cache and the Marvell PCIe hardware block are
affected a L2/PCIe deadlock problem when hardware I/O coherency is used.

This deadlock can be avoided by mapping the PCIe memory areas as
strongly-ordered, and by removing the outer cache sync done in
software. This is done in this patch, thanks to the new bits of
infrastructure added in 'ARM: mm: allow sub-architectures to override
PCI I/O memory type' and 'ARM: mm: add support for HW coherent systems
in PL310' respectively.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 6260cb8..af4eee9 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -75,6 +75,26 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
 	return 1;
 }
 
+/*
+ * This ioremap hook is used on Armada 375/38x to ensure that PCIe
+ * memory areas are mapped as MT_MEMORY_RW_SO instead of
+ * MT_DEVICE. This is needed as a workaround for a deadlock issue
+ * between the PCIe interface and the cache controller.
+ */
+static void __iomem *
+armada_pcie_wa_ioremap_caller(phys_addr_t phys_addr, size_t size,
+			      unsigned int mtype, void *caller)
+{
+	struct resource pcie_mem;
+
+	mvebu_mbus_get_pcie_mem_aperture(&pcie_mem);
+
+	if (pcie_mem.start <= phys_addr && (phys_addr + size) <= pcie_mem.end)
+		mtype = MT_MEMORY_RW_SO;
+
+	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
+}
+
 static void __init mvebu_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
@@ -83,9 +103,18 @@ static void __init mvebu_timer_and_clk_init(void)
 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
 	coherency_init();
 #ifdef CONFIG_CACHE_L2X0
-	l2x0_of_init(0, ~0UL);
+	if (coherency_available())
+		l2x0_of_init_coherent(0, ~0UL);
+	else
+		l2x0_of_init(0, ~0UL);
 #endif
 
+	if (of_machine_is_compatible("marvell,armada375") ||
+	    of_machine_is_compatible("marvell,armada38x")) {
+		arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
+		pci_ioremap_set_mem_type(MT_MEMORY_RW_SO);
+	}
+
 	if (of_machine_is_compatible("marvell,armada375"))
 		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
 				"imprecise external abort");
-- 
1.8.3.2
