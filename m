From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:22 +0100
Subject: [PATCH 35/51] ARM: kprobes: Add load_write_pc()
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-36-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This writes a value to PC which was obtained as the result of a
LDR or LDM instruction. For ARMv5T and later this must perform
interworking.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h        |   24 ++++++++++++++++++++++++
 arch/arm/kernel/kprobes-common.c |   15 +++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 12627a3..5d6bf0d 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -109,6 +109,30 @@ static inline void __kprobes bx_write_pc(long pcv, struct pt_regs *regs)
 	regs->ARM_pc = pcv;
 }
 
+
+#if __LINUX_ARM_ARCH__ >= 6
+
+/* Kernels built for >= ARMv6 should never run on <= ARMv5 hardware, so... */
+#define load_write_pc_interworks true
+#define test_load_write_pc_interworking()
+
+#else /* __LINUX_ARM_ARCH__ < 6 */
+
+/* We need run-time testing to determine if load_write_pc() should interwork. */
+extern bool load_write_pc_interworks;
+void __init test_load_write_pc_interworking(void);
+
+#endif
+
+static inline void __kprobes load_write_pc(long pcv, struct pt_regs *regs)
+{
+	if (load_write_pc_interworks)
+		bx_write_pc(pcv, regs);
+	else
+		regs->ARM_pc = pcv;
+}
+
+
 void __kprobes kprobe_simulate_nop(struct kprobe *p, struct pt_regs *regs);
 void __kprobes kprobe_emulate_none(struct kprobe *p, struct pt_regs *regs);
 
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 84c0c74..41e8218 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -45,9 +45,24 @@ void __init find_str_pc_offset(void)
 #endif /* !find_str_pc_offset */
 
 
+#ifndef test_load_write_pc_interworking
+
+bool load_write_pc_interworks;
+
+void __init test_load_write_pc_interworking(void)
+{
+	int arch = cpu_architecture();
+	BUG_ON(arch == CPU_ARCH_UNKNOWN);
+	load_write_pc_interworks = arch >= CPU_ARCH_ARMv5T;
+}
+
+#endif /* !test_load_write_pc_interworking */
+
+
 void __init arm_kprobe_decode_init(void)
 {
 	find_str_pc_offset();
+	test_load_write_pc_interworking();
 }
 
 
-- 
1.7.2.5
