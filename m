From: filippo.arcidiacono@st.com (Filippo ARCIDIACONO)
Date: Tue, 7 Dec 2010 11:20:54 +0100
Subject: [PATCH (sh-2.6) 2/2] arm: use generic implementation of
	boot_init_stack_canary
In-Reply-To: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
Message-ID: <1291717254-17455-2-git-send-email-filippo.arcidiacono@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All architectures using __stack_chk_guard global variable as canary
could use a generic implementation of boot_init_stack_canary.

Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/arm/include/asm/stackprotector.h |   32 ++------------------------------
 1 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/arch/arm/include/asm/stackprotector.h b/arch/arm/include/asm/stackprotector.h
index de00332..1ae30bc 100644
--- a/arch/arm/include/asm/stackprotector.h
+++ b/arch/arm/include/asm/stackprotector.h
@@ -1,38 +1,10 @@
 /*
- * GCC stack protector support.
- *
- * Stack protector works by putting predefined pattern at the start of
- * the stack frame and verifying that it hasn't been overwritten when
- * returning from the function.  The pattern is called stack canary
- * and gcc expects it to be defined by a global variable called
- * "__stack_chk_guard" on ARM.  This unfortunately means that on SMP
- * we cannot have a different canary value per task.
+ * ARM specific GCC stack protector support.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
 #define _ASM_STACKPROTECTOR_H 1
 
-#include <linux/random.h>
-#include <linux/version.h>
-
-extern unsigned long __stack_chk_guard;
-
-/*
- * Initialize the stackprotector canary value.
- *
- * NOTE: this must only be called from functions that never return,
- * and it must always be inlined.
- */
-static __always_inline void boot_init_stack_canary(void)
-{
-	unsigned long canary;
-
-	/* Try to get a semi random initial value. */
-	get_random_bytes(&canary, sizeof(canary));
-	canary ^= LINUX_VERSION_CODE;
-
-	current->stack_canary = canary;
-	__stack_chk_guard = current->stack_canary;
-}
+#include <asm-generic/stackprotector.h>
 
 #endif	/* _ASM_STACKPROTECTOR_H */
-- 
1.5.5.6
