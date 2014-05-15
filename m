From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 16:59:34 +0200
Subject: [PATCHv4 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400165974-9059-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 375 and Armada 38x SOCs, which use the Cortex-A9
CPU core, the PL310 cache and the Marvell PCIe hardware block are
affected a L2/PCIe deadlock caused by a system erratum when hardware
I/O coherency is used.

This deadlock can be avoided by mapping the PCIe memory areas as
strongly-ordered (note: MT_UNCACHED is strongly-ordered), and by
removing the outer cache sync done in software. This is implemented in
this patch by:

 * Registering a custom arch_ioremap_caller function that allows to
   make sure PCI memory regions are mapped MT_UNCACHED.

 * Adding at runtime the 'arm,io-coherent' property to the PL310 cache
   controller. This cannot be done permanently in the DT, because the
   hardware I/O coherency can only be enabled when CONFIG_SMP is
   enabled, in the current kernel situation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index d5a975b..f6be9c6 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -31,6 +31,7 @@
 #include <linux/clk.h>
 #include <asm/smp_plat.h>
 #include <asm/cacheflush.h>
+#include <asm/mach/map.h>
 #include "armada-370-xp.h"
 #include "coherency.h"
 #include "mvebu-soc-id.h"
@@ -308,9 +309,47 @@ static void __init armada_370_coherency_init(struct device_node *np)
 	set_cpu_coherent();
 }
 
+/*
+ * This ioremap hook is used on Armada 375/38x to ensure that PCIe
+ * memory areas are mapped as MT_UNCACHED instead of MT_DEVICE. This
+ * is needed as a workaround for a deadlock issue between the PCIe
+ * interface and the cache controller.
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
+		mtype = MT_UNCACHED;
+
+	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
+}
+
 static void __init armada_375_380_coherency_init(struct device_node *np)
 {
+	struct device_node *cache_dn;
+
 	coherency_cpu_base = of_iomap(np, 0);
+	arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
+
+	/*
+	 * Add the PL310 property "arm,io-coherent". This makes sure the
+	 * outer sync operation is not used, which allows to
+	 * workaround the system erratum that causes deadlocks when
+	 * doing PCIe in an SMP situation on Armada 375 and Armada
+	 * 38x.
+	 */
+	for_each_compatible_node(cache_dn, NULL, "arm,pl310-cache") {
+		struct property *p;
+
+		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
+		of_add_property(cache_dn, p);
+	}
 }
 
 static int coherency_type(void)
-- 
1.9.3
