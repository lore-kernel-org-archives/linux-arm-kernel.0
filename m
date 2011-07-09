From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:55 +0100
Subject: [PATCH 08/51] ARM: kprobes: Make str_pc_offset a constant on ARMv7
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-9-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The str_pc_offset value is architecturally defined on ARMv7 onwards so
we can make it a compile time constant. This means on Thumb kernels the
runtime checking code isn't needed, which saves us from having to fix it
to work for Thumb.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h        |   14 ++++++++++++++
 arch/arm/kernel/kprobes-common.c |    4 ++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 43f630d..406bb2d 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -36,7 +36,21 @@ void __init arm_kprobe_decode_init(void);
 
 extern kprobe_check_cc * const kprobe_condition_checks[16];
 
+
+#if __LINUX_ARM_ARCH__ >= 7
+
+/* str_pc_offset is architecturally defined from ARMv7 onwards */
+#define str_pc_offset 8
+#define find_str_pc_offset()
+
+#else /* __LINUX_ARM_ARCH__ < 7 */
+
+/* We need a run-time check to determine str_pc_offset */
 extern int str_pc_offset;
+void __init find_str_pc_offset(void);
+
+#endif
+
 
 /*
  * Test if load/store instructions writeback the address register.
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index e18576c..87e91ce 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -17,6 +17,8 @@
 #include "kprobes.h"
 
 
+#ifndef find_str_pc_offset
+
 /*
  * For STR and STM instructions, an ARM core may choose to use either
  * a +8 or a +12 displacement from the current instruction's address.
@@ -40,6 +42,8 @@ void __init find_str_pc_offset(void)
 	str_pc_offset = ret;
 }
 
+#endif /* !find_str_pc_offset */
+
 
 void __init arm_kprobe_decode_init(void)
 {
-- 
1.7.2.5
