From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed,  1 May 2013 09:58:46 -0700
Subject: [PATCH] ARM: nommu: Fix types for ioremap functions
Message-ID: <1367427526-5475-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cd024d4245b2bfbd824b911f11a9756d1d6c167d
(ARM: 7704/1: mm: Use phys_addr_t properly for ioremap functions)
changed the type of the ioremap functions to actually use phys_addr_t.
Change the nommu functions accordingly as well to avoid errors:

arch/arm/mm/nommu.c:84:15: error: conflicting types for '__arm_ioremap'
arch/arm/include/asm/io.h:137:22: note: previous declaration of '__arm_ioremap' was here
arch/arm/mm/nommu.c:91:18: error: conflicting types for 'arch_ioremap_caller'
arch/arm/include/asm/io.h:142:25: note: previous declaration of 'arch_ioremap_caller' was here
arch/arm/mm/nommu.c:93:15: error: conflicting types for '__arm_ioremap_caller'
arch/arm/include/asm/io.h:133:22: note: previous declaration of '__arm_ioremap_caller' was here

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/nommu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d51225f..31bd77b 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -81,16 +81,16 @@ void __iomem *__arm_ioremap_pfn_caller(unsigned long pfn, unsigned long offset,
 	return __arm_ioremap_pfn(pfn, offset, size, mtype);
 }
 
-void __iomem *__arm_ioremap(unsigned long phys_addr, size_t size,
+void __iomem *__arm_ioremap(phys_addr_t phys_addr, size_t size,
 			    unsigned int mtype)
 {
 	return (void __iomem *)phys_addr;
 }
 EXPORT_SYMBOL(__arm_ioremap);
 
-void __iomem * (*arch_ioremap_caller)(unsigned long, size_t, unsigned int, void *);
+void __iomem * (*arch_ioremap_caller)(phys_addr_t, size_t, unsigned int, void *);
 
-void __iomem *__arm_ioremap_caller(unsigned long phys_addr, size_t size,
+void __iomem *__arm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 				   unsigned int mtype, void *caller)
 {
 	return __arm_ioremap(phys_addr, size, mtype);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
