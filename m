From: tixy@yxit.co.uk (Tixy)
Date: Sat, 10 Sep 2011 12:05:02 +0100
Subject: [PATCH v2 06/10] ARM: kprobes: Add exports for test code
In-Reply-To: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1315652706-2900-7-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The test code will be using kprobes' internal decoding tables so we
need to export these for when then the tests are compiled as a module.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h       |    8 ++++++++
 arch/arm/kernel/kprobes-arm.c   |    4 ++++
 arch/arm/kernel/kprobes-thumb.c |    7 +++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index a6aeda0..38945f7 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -413,6 +413,14 @@ struct decode_reject {
 	DECODE_HEADER(DECODE_TYPE_REJECT, _mask, _value, 0)
 
 
+#ifdef CONFIG_THUMB2_KERNEL
+extern const union decode_item kprobe_decode_thumb16_table[];
+extern const union decode_item kprobe_decode_thumb32_table[];
+#else
+extern const union decode_item kprobe_decode_arm_table[];
+#endif
+
+
 int kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
 			const union decode_item *table, bool thumb16);
 
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 79203ee..9fe8910 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -60,6 +60,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <linux/module.h>
 
 #include "kprobes.h"
 
@@ -971,6 +972,9 @@ const union decode_item kprobe_decode_arm_table[] = {
 
 	DECODE_END
 };
+#ifdef CONFIG_ARM_KPROBES_TEST_MODULE
+EXPORT_SYMBOL_GPL(kprobe_decode_arm_table);
+#endif
 
 static void __kprobes arm_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 902ca59..8f96ec7 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <linux/module.h>
 
 #include "kprobes.h"
 
@@ -943,6 +944,9 @@ const union decode_item kprobe_decode_thumb32_table[] = {
 	 */
 	DECODE_END
 };
+#ifdef CONFIG_ARM_KPROBES_TEST_MODULE
+EXPORT_SYMBOL_GPL(kprobe_decode_thumb32_table);
+#endif
 
 static void __kprobes
 t16_simulate_bxblx(struct kprobe *p, struct pt_regs *regs)
@@ -1423,6 +1427,9 @@ const union decode_item kprobe_decode_thumb16_table[] = {
 
 	DECODE_END
 };
+#ifdef CONFIG_ARM_KPROBES_TEST_MODULE
+EXPORT_SYMBOL_GPL(kprobe_decode_thumb16_table);
+#endif
 
 static unsigned long __kprobes thumb_check_cc(unsigned long cpsr)
 {
-- 
1.7.2.5
