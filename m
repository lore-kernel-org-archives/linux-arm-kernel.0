From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:53 +0100
Subject: [PATCH 06/51] ARM: kprobes: Move is_writeback define to header file.
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-7-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This will be used later in other files.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h     |    6 ++++++
 arch/arm/kernel/kprobes-arm.c |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 792f231..4de2f37 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -36,4 +36,10 @@ void __init arm_kprobe_decode_init(void);
 
 extern kprobe_check_cc * const kprobe_condition_checks[16];
 
+/*
+ * Test if load/store instructions writeback the address register.
+ * if P (bit 24) == 0 or W (bit 21) == 1
+ */
+#define is_writeback(insn) ((insn ^ 0x01000000) & 0x01200000)
+
 #endif /* _ARM_KERNEL_KPROBES_H */
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 8d4464f..3c4678e 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -69,12 +69,6 @@
 
 #define is_r15(insn, bitpos) (((insn) & (0xf << bitpos)) == (0xf << bitpos))
 
-/*
- * Test if load/store instructions writeback the address register.
- * if P (bit 24) == 0 or W (bit 21) == 1
- */
-#define is_writeback(insn) ((insn ^ 0x01000000) & 0x01200000)
-
 #define PSR_fs	(PSR_f|PSR_s)
 
 #define KPROBE_RETURN_INSTRUCTION	0xe1a0f00e	/* mov pc, lr */
-- 
1.7.2.5
