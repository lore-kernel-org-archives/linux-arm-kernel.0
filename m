From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:51 +0100
Subject: [PATCH 02/24] ARM: kprobes: Add alu_write_pc()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This writes a new value to PC which was obtained as the result of an ARM
ALU instruction. For ARMv7 and later this performs interworking.

On ARM kernels we shouldn't encounter any ALU instructions trying to
switch to Thumb mode so support for this isn't strictly necessary.
However, the approach taken in all other instruction decoding is for us
to avoid unpredictable modification of the PC for security reasons. This
is usually achieved by rejecting insertion of probes on problematic
instruction, but for ALU instructions we can't do this as it depends on
the contents of the CPU registers at the time the probe is hit. So, as
we require some form of run-time checking to trap undesirable PC
modification, we may as well simulate the instructions correctly, i.e.
in the way they would behave in the absence of a probe.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h        |   28 ++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes-common.c |   15 +++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index c442852..a6aeda0 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -133,6 +133,34 @@ static inline void __kprobes load_write_pc(long pcv, struct pt_regs *regs)
 }
 
 
+#if __LINUX_ARM_ARCH__ >= 7
+
+#define alu_write_pc_interworks true
+#define test_alu_write_pc_interworking()
+
+#elif __LINUX_ARM_ARCH__ <= 5
+
+/* Kernels built for <= ARMv5 should never run on >= ARMv6 hardware, so... */
+#define alu_write_pc_interworks false
+#define test_alu_write_pc_interworking()
+
+#else /* __LINUX_ARM_ARCH__ == 6 */
+
+/* We could be an ARMv6 binary on ARMv7 hardware so we need a run-time check. */
+extern bool alu_write_pc_interworks;
+void __init test_alu_write_pc_interworking(void);
+
+#endif /* __LINUX_ARM_ARCH__ == 6 */
+
+static inline void __kprobes alu_write_pc(long pcv, struct pt_regs *regs)
+{
+	if (alu_write_pc_interworks)
+		bx_write_pc(pcv, regs);
+	else
+		regs->ARM_pc = pcv;
+}
+
+
 void __kprobes kprobe_simulate_nop(struct kprobe *p, struct pt_regs *regs);
 void __kprobes kprobe_emulate_none(struct kprobe *p, struct pt_regs *regs);
 
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 32bb0f2..a5394fb4 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -59,10 +59,25 @@ void __init test_load_write_pc_interworking(void)
 #endif /* !test_load_write_pc_interworking */
 
 
+#ifndef test_alu_write_pc_interworking
+
+bool alu_write_pc_interworks;
+
+void __init test_alu_write_pc_interworking(void)
+{
+	int arch = cpu_architecture();
+	BUG_ON(arch == CPU_ARCH_UNKNOWN);
+	alu_write_pc_interworks = arch >= CPU_ARCH_ARMv7;
+}
+
+#endif /* !test_alu_write_pc_interworking */
+
+
 void __init arm_kprobe_decode_init(void)
 {
 	find_str_pc_offset();
 	test_load_write_pc_interworking();
+	test_alu_write_pc_interworking();
 }
 
 
-- 
1.7.2.5
