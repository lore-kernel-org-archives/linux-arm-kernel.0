From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Jul 2014 20:52:02 +0100
Subject: [PATCH 1/4] ARM: alignment: save last kernel aligned fault location
In-Reply-To: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
Message-ID: <E1X39Wc-0000lm-Gm@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save and report (via the procfs file) the last kernel unaligned fault
location.  This allows us to trivially inspect where the last fault
happened for cases which we don't expect to occur.

Since we expect the kernel to generate misalignment faults (due to
the networking layer), even when warnings are enabled, we don't log
them for the kernel.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/alignment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b8cb1a2688a0..0c1ab49e5f7b 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -76,6 +76,7 @@
 
 static unsigned long ai_user;
 static unsigned long ai_sys;
+static void *ai_sys_last_pc;
 static unsigned long ai_skipped;
 static unsigned long ai_half;
 static unsigned long ai_word;
@@ -130,7 +131,7 @@ static const char *usermode_action[] = {
 static int alignment_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "User:\t\t%lu\n", ai_user);
-	seq_printf(m, "System:\t\t%lu\n", ai_sys);
+	seq_printf(m, "System:\t\t%lu (%pF)\n", ai_sys, ai_sys_last_pc);
 	seq_printf(m, "Skipped:\t%lu\n", ai_skipped);
 	seq_printf(m, "Half:\t\t%lu\n", ai_half);
 	seq_printf(m, "Word:\t\t%lu\n", ai_word);
@@ -794,6 +795,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto user;
 
 	ai_sys += 1;
+	ai_sys_last_pc = (void *)instruction_pointer(regs);
 
  fixup:
 
-- 
1.8.3.1
