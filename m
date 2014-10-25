From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sat, 25 Oct 2014 14:57:18 +0100
Subject: [PATCH v6 3/7] xen/arm: introduce is_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1410251450180.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410251450180.22875@kaball.uk.xensource.com>
Message-ID: <1414245442-4306-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a simple utility function that returns whether a device is dma
coherent based on device tree information.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: catalin.marinas at arm.com
CC: Will.Deacon at arm.com
---
 arch/arm/xen/mm32.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
index 6153d61..2b259f1 100644
--- a/arch/arm/xen/mm32.c
+++ b/arch/arm/xen/mm32.c
@@ -2,10 +2,16 @@
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
+#include <linux/of_address.h>
 
 #include <xen/features.h>
 
 
+static inline bool is_dma_coherent(struct device *dev)
+{
+	return of_dma_is_coherent(dev->of_node);
+}
+
 /* functions called by SWIOTLB */
 
 static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
-- 
1.7.10.4
