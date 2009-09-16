From: frederic.riss@gmail.com (=?ISO-8859-1?Q?Fr=E9d=E9ric?= RISS)
Date: Wed, 16 Sep 2009 07:21:16 +0200
Subject: [PATCH] arm: Make kprobes unregistration SMP safe
Message-ID: <1253078476.5021.65.camel@funkybook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM kprobes use an illegal instruction to trigger kprobes. In the
current implementation, there's a race between the unregistration of a
kprobe and the illegal instruction exception handler if they run at the
same time on different cores. 

When reading the value of the undefined instruction, the exception
handler might get the original legal instruction as just patched
concurrently by arch_disarm_kprobe(). When this happen the kprobe
handler won't run, and thus the exception handler will oops because it
believe it just hit an undefined instruction in kernel space.

The following patch synchronizes the code patching in the kprobes
unregistration using stop_machine and thus avoids the above race.

Signed-off-by: Frederic RISS <frederic.riss@gmail.com>

---

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index d28513f..6ada87d 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 #include <linux/module.h>
+#include <linux/stop_machine.h>
 #include <linux/stringify.h>
 #include <asm/traps.h>
 #include <asm/cacheflush.h>
@@ -83,10 +84,24 @@ void __kprobes arch_arm_kprobe(struct kprobe *p)
 	flush_insns(p->addr, 1);
 }
 
+/*
+ * The actual disarming is done here on each CPU and synchronized using
+ * stop_machine. This synchronization is necessary on SMP to avoid removing
+ * a probe between the moment the 'Undefined Instruction' exception is raised
+ * and the moment the exception handler reads the faulting instruction from
+ * memory.
+ */
+int __kprobes __arch_disarm_kprobe(void *p)
+{
+	struct kprobe *kp = p;
+	*kp->addr = kp->opcode;
+	flush_insns(kp->addr, 1);
+	return 0;
+}
+
 void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
-	*p->addr = p->opcode;
-	flush_insns(p->addr, 1);
+	stop_machine(__arch_disarm_kprobe, p, &cpu_online_map);
 }
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
