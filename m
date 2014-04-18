From: wuqixuan@huawei.com (Wuqixuan)
Date: Fri, 18 Apr 2014 09:53:07 +0000
Subject: [PATCH] ARM: armv7 no need update SCTLR for alignment 
Message-ID: <BB7C62C2B0732E4DA93834A501E846456C8F1A92@szxema505-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Armv7, cr_alignment and cr_no_alignment are always same, in alignment_init both 
cr_alignment and cr_no_alignment will be updated by clearing A bit. So there is no 
meaning to update SCTLR if interrupt and exception disturbs the user-space. 

Signed-off-by: Wuqixuan <wuqixuan@huawei.com>
---
diff -git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -323,12 +323,6 @@
   A710( bne .Larm710bug      )
 
 #endif
-#if defined(CONFIG_ALIGNMENT_TRAP)
+#if defined(CONFIG_ALIGNMENT_TRAP) && !(__LINUX_ARM_ARCH__ >= 7)
 ldr ip, __cr_alignment
 ldr ip, [ip]
 mcr p15, 0, ip, c1, c0  @ update control register
#endif
  enable_irq
 
  get_thread_info tsk
@@ -393,11 +387,6 @@
  b ret_slow_syscall
 
  .align 5
-#ifdef CONFIG_ALIGNMENT_TRAP
+#if defined(CONFIG_ALIGNMENT_TRAP) && !(__LINUX_ARM_ARCH__ >= 7)
 .type __cr_alignment, #object
__cr_alignment:
 .word cr_alignment
#endif
  .ltorg
 
 /*
diff -git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -44,11 +44,6 @@
  .endm
 
  .macro alignment_trap, rtemp
-#ifdef CONFIG_ALIGNMENT_TRAP 
+#if defined(CONFIG_ALIGNMENT_TRAP) && !(__LINUX_ARM_ARCH__ >= 7)
 ldr \rtemp, .LCcralign
 ldr \rtemp, [\rtemp]
 mcr p15, 0, \rtemp, c1, c0
#endif
  .endm
 
  @
