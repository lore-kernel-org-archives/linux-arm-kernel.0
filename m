From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  2 Aug 2012 18:23:14 -0700
Subject: [PATCH] ARM: Fix XIP build due to PHYS_OFFSET definition moving
Message-ID: <1343956994-27513-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the p2v changes, the PHYS_OFFSET #define moved into a
!__ASSEMBLY__ section. This causes a XIP build to fail with

 arch/arm/kernel/head.o: In function 'stext':
 arch/arm/kernel/head.S:146: undefined reference to 'PHYS_OFFSET'

Momentarily leave the #ifndef __ASSEMBLY__ section so we can
define PHYS_OFFSET for all compilation units.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I don't know if it's worth stable, seems that nobody has compiled XIP for
a year (back to 2.6.39 days?).

 arch/arm/include/asm/memory.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index fcb5757..3299b2d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -187,6 +187,7 @@ static inline unsigned long __phys_to_virt(unsigned long x)
 #define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
 #endif
 #endif
+#endif /* __ASSEMBLY__ */
 
 #ifndef PHYS_OFFSET
 #ifdef PLAT_PHYS_OFFSET
@@ -196,6 +197,8 @@ static inline unsigned long __phys_to_virt(unsigned long x)
 #endif
 #endif
 
+#ifndef __ASSEMBLY__
+
 /*
  * PFNs are used to describe any physical page; this means
  * PFN 0 == physical address 0.
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
