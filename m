From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 12 Apr 2018 14:22:17 +0100
Subject: [PATCH 2/2] ARM: kexec: record parent context registers for non-crash
 CPUs
Message-ID: <E1f6cB7-0004AG-U5@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How we got to machine_crash_nonpanic_core() (iow, from an IPI, etc) is
not interesting for debugging a crash.  The more interesting context
is the parent context prior to the IPI being received.

Record the parent context register state rather than the register state
in machine_crash_nonpanic_core(), which is more relevant to the failing
condition.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 39dc6bf4610a..43918872b783 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -83,7 +83,7 @@ void machine_crash_nonpanic_core(void *unused)
 {
 	struct pt_regs regs;
 
-	crash_setup_regs(&regs, NULL);
+	crash_setup_regs(&regs, get_irq_regs());
 	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has crashed\n",
 	       smp_processor_id());
 	crash_save_cpu(&regs, smp_processor_id());
-- 
2.7.4
