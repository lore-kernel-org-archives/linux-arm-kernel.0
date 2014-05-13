From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 12:10:39 +0200
Subject: [PATCHv2 4/4] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399975839-5311-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 375 and Armada 38x SOCs, which use the Cortex-A9
CPU core, the PL310 cache and the Marvell PCIe hardware block are
affected a L2/PCIe deadlock caused by a system erratum when hardware
I/O coherency is used.

This deadlock can be avoided by mapping the PCIe memory areas as
strongly-ordered, and by removing the outer cache sync done in
software. This is done in this patch, thanks to the new bits of
infrastructure added in 'ARM: mm: allow sub-architectures to override
PCI I/O memory type' and 'ARM: mm: add support for HW coherent systems
in PL310' respectively.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 01cfce6..e7e09ce 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -71,6 +71,53 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
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
+/*
+ * When we are I/O coherent and we use the PL310 cache controller, we
+ * switch the PL310 compatible string to
+ * "arm,pl310-coherent-cache". This makes sure the outer sync
+ * operation is not used, which allows to workaround the system
+ * erratum that causes deadlocks when doing PCIe in a SMP situation on
+ * Armada 375 and Armada 38x.
+ */
+static void __init mvebu_l2x0_pl310_coherent(void)
+{
+	struct device_node *np;
+
+	if (!coherency_available())
+		return;
+
+	for_each_compatible_node(np, NULL, "arm,pl310-cache") {
+		struct property *new_compat;
+
+		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
+		new_compat->name = kstrdup("compatible", GFP_KERNEL);
+		new_compat->value = kstrdup("arm,pl310-coherent-cache",
+					    GFP_KERNEL);
+		new_compat->length = strlen(new_compat->value) + 1;
+		of_update_property(np, new_compat);
+	}
+}
+
 static void __init mvebu_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
@@ -78,6 +125,14 @@ static void __init mvebu_timer_and_clk_init(void)
 	mvebu_scu_enable();
 	coherency_init();
 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
+
+	if (of_machine_is_compatible("marvell,armada375") ||
+	    of_machine_is_compatible("marvell,armada38x")) {
+		arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
+		pci_ioremap_set_mem_type(MT_MEMORY_RW_SO);
+		mvebu_l2x0_pl310_coherent();
+	}
+
 	l2x0_of_init(0, ~0UL);
 
 	if (of_machine_is_compatible("marvell,armada375"))
-- 
1.9.2
