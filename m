From: hari.vyas@broadcom.com (Hari Vyas)
Date: Tue, 17 Jul 2018 15:01:21 +0530
Subject: [PATCH] arm64: fix kernel panic on serror exception caused by user
 process
In-Reply-To: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
References: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
Message-ID: <1531819881-2931-2-git-send-email-hari.vyas@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On executing simple user level "devmem 0x0" command, kernel panics.
As 0x0 address is mostly not matched to any valid memory so exception
is expected and raised which results in unconditional kernel panic
by serror handler.

This is happening after newly introduced serror handling framework
change which panics kernel on any any serror without checking
processor mode.`

Kernel panic is fixed by checking processor mode in serror handler.
On kernel mode, normal kernel panic action is taken and system halts.
On user mode, only user process is killed and further panic action is
not initiated.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
---
 arch/arm64/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d45..c7cbad7 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -729,6 +729,13 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 
 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs)) {
+		pr_crit("UserMode SError Exception on CPU%d, code 0x%08x %s\n",
+			smp_processor_id(), esr, esr_get_class_string(esr));
+		die("Oops - user mode ", regs, 0);
+		return;
+        }
+
 	nmi_enter();
 
 	/* non-RAS errors are not containable */
-- 
1.9.1
