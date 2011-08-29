From: tixy@yxit.co.uk (Tixy)
Date: Mon, 29 Aug 2011 13:34:05 +0100
Subject: [PATCH 06/10] ARM: kprobes: Add exports for test code
In-Reply-To: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
References: <1314621249-958-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1314621249-958-7-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The test code will be using kprobes' internal decoding tables so we
need to export these for when then the tests are compiled as a module.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h       |   21 +++++++++++++++++++++
 arch/arm/kernel/kprobes-arm.c   |    2 ++
 arch/arm/kernel/kprobes-thumb.c |    3 +++
 3 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index a6aeda0..957c447 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -417,4 +417,25 @@ int kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
 			const union decode_item *table, bool thumb16);
 
 
+
+#ifdef CONFIG_ARM_KPROBES_TESTS
+
+/* Declare decoding tables for access by test code */
+#ifdef CONFIG_THUMB2_KERNEL
+extern const union decode_item kprobe_decode_thumb16_table[];
+extern const union decode_item kprobe_decode_thumb32_table[];
+#else
+extern const union decode_item kprobe_decode_arm_table[];
+#endif
+
+#define EXPORT_KPROBES_TEST_SYMBOL(sym) EXPORT_SYMBOL_GPL(sym)
+
+#else /* !CONFIG_ARM_KPROBES_TESTS */
+
+/* No test exports required */
+#define EXPORT_KPROBES_TEST_SYMBOL(sym)
+
+#endif
+
+
 #endif /* _ARM_KERNEL_KPROBES_H */
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 79203ee..7192f21 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -60,6 +60,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <linux/module.h>
 
 #include "kprobes.h"
 
@@ -971,6 +972,7 @@ const union decode_item kprobe_decode_arm_table[] = {
 
 	DECODE_END
 };
+EXPORT_KPROBES_TEST_SYMBOL(kprobe_decode_arm_table);
 
 static void __kprobes arm_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 902ca59..ab6be05 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <linux/module.h>
 
 #include "kprobes.h"
 
@@ -943,6 +944,7 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	 */
 	DECODE_END
 };
+EXPORT_KPROBES_TEST_SYMBOL(kprobe_decode_thumb32_table);
 
 static void __kprobes
 t16_simulate_bxblx(struct kprobe *p, struct pt_regs *regs)
@@ -1423,6 +1425,7 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 
 	DECODE_END
 };
+EXPORT_KPROBES_TEST_SYMBOL(kprobe_decode_thumb16_table);
 
 static unsigned long __kprobes thumb_check_cc(unsigned long cpsr)
 {
-- 
1.7.2.5
