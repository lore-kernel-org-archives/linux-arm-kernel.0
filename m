From: dave.martin@linaro.org (Dave Martin)
Date: Tue,  8 Feb 2011 15:20:14 +0000
Subject: [PATCH] ARM: Correct WFE() in asm/spinlock.h for Thumb-2
Message-ID: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The content for ALT_SMP() in the definition of WFE() expands to 6
bytes (IT cc ; WFEcc.W), which breaks the assumptions of the fixup
code, leading to lockups when the affected code gets run.

This patch works around the problem by explicitly using an
IT + WFEcc.N pair.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/spinlock.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index da1af52..7cba79c 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -18,7 +18,12 @@
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define SEV		ALT_SMP("sev.w", "nop.w")
-#define WFE(cond)	ALT_SMP("wfe" cond ".w", "nop.w")
+#define WFE(cond)	ALT_SMP(		\
+	"it " cond "\n\t"			\
+	"wfe" cond ".n",			\
+						\
+	"nop.w"					\
+)
 #else
 #define SEV		ALT_SMP("sev", "nop")
 #define WFE(cond)	ALT_SMP("wfe" cond, "nop")
-- 
1.7.1
