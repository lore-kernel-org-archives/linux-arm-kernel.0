From: ian.campbell@citrix.com (Ian Campbell)
Date: Mon, 20 Jan 2014 11:30:41 +0000
Subject: [PATCH v3] xen: swiotlb: handle sizeof(dma_addr_t) !=
 sizeof(phys_addr_t)
Message-ID: <1390217441-9910-1-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of phys_to_machine and machine_to_phys in the phys<=>bus conversions
causes us to lose the top bits of the DMA address if the size of a DMA address is not the same as the size of the phyiscal address.

This can happen in practice on ARM where foreign pages can be above 4GB even
though the local kernel does not have LPAE page tables enabled (which is
totally reasonable if the guest does not itself have >4GB of RAM). In this
case the kernel still maps the foreign pages at a phys addr below 4G (as it
must) but the resulting DMA address (returned by the grant map operation) is
much higher.

This is analogous to a hardware device which has its view of RAM mapped up
high for some reason.

This patch makes I/O to foreign pages (specifically blkif) work on 32-bit ARM
systems with more than 4GB of RAM.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arm-kernel at lists.infradead.org
---
v3: Added Stefano's ack, added accidentally forgotten Ccs to Russell and l-a-k.
v2: Add comment on avoiding PFN_PHYS, and remove accidental truncation due to
    it in xen_bus_to_phys.
---
 arch/arm/Kconfig          |    1 +
 drivers/xen/swiotlb-xen.c |   22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7e..24307dc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1885,6 +1885,7 @@ config XEN
 	depends on !GENERIC_ATOMIC64
 	select ARM_PSCI
 	select SWIOTLB_XEN
+	select ARCH_DMA_ADDR_T_64BIT
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 1eac073..ebd8f21 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -75,14 +75,32 @@ static unsigned long xen_io_tlb_nslabs;
 
 static u64 start_dma_addr;
 
+/*
+ * Both of these functions should avoid PFN_PHYS because phys_addr_t
+ * can be 32bit when dma_addr_t is 64bit leading to a loss in
+ * information if the shift is done before casting to 64bit.
+ */
 static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
 {
-	return phys_to_machine(XPADDR(paddr)).maddr;
+	unsigned long mfn = pfn_to_mfn(PFN_DOWN(paddr));
+	dma_addr_t dma = (dma_addr_t)mfn << PAGE_SHIFT;
+
+	dma |= paddr & ~PAGE_MASK;
+
+	return dma;
 }
 
 static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
 {
-	return machine_to_phys(XMADDR(baddr)).paddr;
+	unsigned long pfn = mfn_to_pfn(PFN_DOWN(baddr));
+	dma_addr_t dma = (dma_addr_t)pfn << PAGE_SHIFT;
+	phys_addr_t paddr = dma;
+
+	BUG_ON(paddr != dma); /* truncation has occurred, should never happen */
+
+	paddr |= baddr & ~PAGE_MASK;
+
+	return paddr;
 }
 
 static inline dma_addr_t xen_virt_to_bus(void *address)
-- 
1.7.10.4
