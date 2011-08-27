From: tixy@yxit.co.uk (Tixy)
Date: Sat, 27 Aug 2011 12:12:43 +0100
Subject: [PATCH] ARM: kprobes: Fix jprobe registration on Thumb kernels
Message-ID: <1314443563-16389-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

When jprobes are registered, the generic kprobes code verifies that the
address given for the probe's handler corresponds to a symbol in the
kernel. For thumb kernels, this address has bit zero set to indicate its
thumb-ness and so is rejected as being offset by one byte from the
symbol address.

Fortunately, on some architectures, the jprobes handler is specified
using a struct rather than a plain function pointer; so a mechanism is
provided for arch code to define a translation function called
arch_deref_entry_point(). We can use this on Thumb kernels to remove bit
zero of the handler address and fix our problem.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 129c116..9c88bcd 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -497,6 +497,14 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	regs->ARM_lr = (unsigned long)&kretprobe_trampoline;
 }
 
+#ifdef CONFIG_THUMB2_KERNEL
+unsigned long arch_deref_entry_point(void *entry)
+{
+	/* Remove any thumb flag from the function pointer. */
+	return (unsigned long)entry & ~1lu;
+}
+#endif
+
 int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
-- 
1.7.2.5
