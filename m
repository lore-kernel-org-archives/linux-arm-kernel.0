From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Mon,  9 Jul 2018 10:42:44 +0200
Subject: [PATCH] microblaze: warn if of_iomap() failed
Message-ID: <1531125764-25816-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_iomap() can return NULL. The function is void thus error propagation
is not possible but at least a WARN_ON() seems warranted here as a silent
failure might lead to a hard to understand system state.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with experimental coccinelle script

Probably this should be a BUG_ON() as this is such a low level fault that
continuing operations probably makes little sense.

Patch was compiletested with: mmu_defconfig (implies CONFIG_PCI_XILINX=y)

Patch is against 4.18-rc3 (localversion-next is next-20180709)

 arch/microblaze/pci/xilinx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index 14c7da5f..7fa72ff 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -157,6 +157,7 @@ void __init xilinx_pci_init(void)
 
 	/* Set the max bus number to 255, and bus/subbus no's to 0 */
 	pci_reg = of_iomap(pci_node, 0);
+	WARN_ON(!pci_reg);
 	out_be32(pci_reg + XPLB_PCI_BUS, 0x000000ff);
 	iounmap(pci_reg);
 
-- 
2.1.4
