From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 10:13:54 +0200
Subject: [PATCHv5 4/4] ARM: mvebu: use pci_ioremap_set_mem_type() to map PCI
 I/O as strongly ordered
In-Reply-To: <1400487234-4501-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400487234-4501-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400487234-4501-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Part of the workaround for the PCIe/SMP/PL310 deadlock on Armada
375/38x is to map PCI mappings strongly ordered. Mapping PCI memory
regions as strongly ordered was already done thanks to the
arch_ioremap_caller mechanism. This patch does the same for the PCI
I/O regions by using the new pci_ioremap_set_mem_type() function.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This patch is kept separate from the rest of the
mach-mvebu/coherency.c code for the workaround, as this patch has a
build dependency on the new API. Since the new API patch will go
through Russell's tree, and this patch through the mvebu tree, there
might be some merging issue, or even the need to delay the merging of
this patch.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index f6be9c6..0215614 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -335,6 +335,7 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
 
 	coherency_cpu_base = of_iomap(np, 0);
 	arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
+	pci_ioremap_set_mem_type(MT_UNCACHED);
 
 	/*
 	 * Add the PL310 property "arm,io-coherent". This makes sure the
-- 
1.9.3
