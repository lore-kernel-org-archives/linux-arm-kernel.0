From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 10 Nov 2014 16:14:05 +0000
Subject: [PATCH v8 13/13] swiotlb-xen: remove BUG_ON in xen_bus_to_phys
In-Reply-To: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1411101607130.22875@kaball.uk.xensource.com>
Message-ID: <1415636045-24669-13-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On x86 truncation cannot occur because config XEN depends on X86_64 ||
(X86_32 && X86_PAE).

On ARM truncation can occur without CONFIG_ARM_LPAE, when the dma
operation involves foreign grants. However in that case the physical
address returned by xen_bus_to_phys is actually invalid (there is no mfn
to pfn tracking for foreign grants on ARM) and it is not used.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/swiotlb-xen.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 498b654..153cf14 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -96,8 +96,6 @@ static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
 	dma_addr_t dma = (dma_addr_t)pfn << PAGE_SHIFT;
 	phys_addr_t paddr = dma;
 
-	BUG_ON(paddr != dma); /* truncation has occurred, should never happen */
-
 	paddr |= baddr & ~PAGE_MASK;
 
 	return paddr;
-- 
1.7.10.4
