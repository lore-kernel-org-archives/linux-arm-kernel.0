From: robherring2@gmail.com (Rob Herring)
Date: Sun, 11 Mar 2012 16:08:17 -0500
Subject: [PATCH 1/4] ARM: fix ioremap/iounmap for !CONFIG_MMU
In-Reply-To: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331500100-31351-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit 4fe7ef3a081 (ARM: provide runtime hook for ioremap/iounmap),
compiles with !CONFIG_MMU were broken. Rename nommu __iounmap to
__arm_iounmap and add arch_ioremap_caller and arch_iounmap. Its
not expected that these need to be overriden for !CONFIG_MMU, so setting
the function ptrs has no effect in this case.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/nommu.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 4fc6794..6486d2f 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -86,13 +86,17 @@ void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
+void __iomem * (*arch_ioremap_caller)(unsigned long, size_t, unsigned int, void *);
+
 void __iomem *__arm_ioremap_caller(unsigned long phys_addr, size_t size,
 				   unsigned int mtype, void *caller)
 {
 	return __arm_ioremap(phys_addr, size, mtype);
 }
 
-void __iounmap(volatile void __iomem *addr)
+void (*arch_iounmap)(volatile void __iomem *);
+
+void __arm_iounmap(volatile void __iomem *addr)
 {
 }
-EXPORT_SYMBOL(__iounmap);
+EXPORT_SYMBOL(__arm_iounmap);
-- 
1.7.5.4
