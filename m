From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 26 Sep 2018 14:56:19 +0100
Subject: [PATCH 2/7] arm64: sdei: Always use sdei stack for sdei events
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1537970184-44348-3-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SDEI events can occur at any point, including when the stack pointer is
not aligned. SP could be modified to respect alignment 16-byte alignement,
but there is a need to deal with code using SP as scratch register.

Always reserve the SDEI stacks to handle its events.

Since stack allocation relies on VMAPed stacks, lets make SDEI depend on
VMAP_STACK.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/include/asm/sdei.h |  2 --
 arch/arm64/kernel/entry.S     |  2 --
 arch/arm64/kernel/sdei.c      | 23 ++++++++---------------
 drivers/firmware/Kconfig      |  1 +
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index ffe47d7..149dffe 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -46,8 +46,6 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
 static inline bool on_sdei_stack(unsigned long sp,
 				struct stack_info *info)
 {
-	if (!IS_ENABLED(CONFIG_VMAP_STACK))
-		return false;
 	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
 		return false;
 	if (in_nmi())
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 09dbea22..fc5842b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1187,7 +1187,6 @@ ENTRY(__sdei_asm_handler)
 
 	mov	x19, x1
 
-#ifdef CONFIG_VMAP_STACK
 	/*
 	 * entry.S may have been using sp as a scratch register, find whether
 	 * this is a normal or critical event and switch to the appropriate
@@ -1201,7 +1200,6 @@ ENTRY(__sdei_asm_handler)
 2:	mov	x6, #SDEI_STACK_SIZE
 	add	x5, x5, x6
 	mov	sp, x5
-#endif
 
 	/*
 	 * We may have interrupted userspace, or a guest, or exit-from or
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 5ba4465..2e2fb0b 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -20,21 +20,16 @@
 unsigned long sdei_exit_mode;
 
 /*
- * VMAP'd stacks checking for stack overflow on exception using sp as a scratch
- * register, meaning SDEI has to switch to its own stack. We need two stacks as
- * a critical event may interrupt a normal event that has just taken a
- * synchronous exception, and is using sp as scratch register. For a critical
- * event interrupting a normal event, we can't reliably tell if we were on the
- * sdei stack.
+ * SDEI events could occur at a time where SP_EL1 is misaligned or invalid, a
+ * solution is to give SDEI its own stack. We need two stacks as a critical
+ * event may interrupt a normal event that has just taken a synchronous
+ * exception, and is using sp as scratch register. For a critical event
+ * interrupting a normal event, we can't reliably tell if we were on the sdei
+ * stack.
  * For now, we allocate stacks when the driver is probed.
  */
-DECLARE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
-DECLARE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
-
-#ifdef CONFIG_VMAP_STACK
 DEFINE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
-#endif
 
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
@@ -150,10 +145,8 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 		return 0;
 	}
 
-	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
-		if (init_sdei_stacks())
-			return 0;
-	}
+	if (init_sdei_stacks())
+		return 0;
 
 	sdei_exit_mode = (conduit == CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6e83880..c63df31 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -85,6 +85,7 @@ config ARM_SCPI_POWER_DOMAIN
 config ARM_SDE_INTERFACE
 	bool "ARM Software Delegated Exception Interface (SDEI)"
 	depends on ARM64
+	depends on VMAP_STACK
 	help
 	  The Software Delegated Exception Interface (SDEI) is an ARM
 	  standard for registering callbacks from the platform firmware
-- 
1.9.1
