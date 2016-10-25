From: joe@perches.com (Joe Perches)
Date: Tue, 25 Oct 2016 09:40:26 -0700
Subject: [PATCH V2] arm64: Neaten show_regs, remove KERN_CONT
Message-ID: <289fb30081aba03fec0c960e7334f707bf36c881.1477413522.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit db4b0710fae9 ("arm64: fix show_regs fallout from KERN_CONT changes")
corrected the KERN_CONT fallout from commit 4bcc595ccd80
("printk: reinstate KERN_CONT for printing continuation lines"), but
the code still has unnecessary KERN_CONT uses.

Remove the KERN_CONT uses to avoid possible message interleaving.

Miscellanea:

o Remove unnecessary trailing blank from the output too.
o Convert i and top_reg to unsigned int
o Move the extra blank line after __show_reg to the caller for symmetry

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm64/kernel/process.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 01753cd7d3f0..5ba12f019bf7 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -168,7 +168,7 @@ void machine_restart(char *cmd)
 
 void __show_regs(struct pt_regs *regs)
 {
-	int i, top_reg;
+	unsigned int i, top_reg;
 	u64 lr, sp;
 
 	if (compat_user_mode(regs)) {
@@ -190,24 +190,23 @@ void __show_regs(struct pt_regs *regs)
 
 	i = top_reg;
 
-	while (i >= 0) {
-		printk("x%-2d: %016llx ", i, regs->regs[i]);
+	if (i % 2) {
+		printk("x%-2d: %016llx\n", i, regs->regs[i]);
 		i--;
-
-		if (i % 2 == 0) {
-			pr_cont("x%-2d: %016llx ", i, regs->regs[i]);
-			i--;
-		}
-
-		pr_cont("\n");
 	}
-	printk("\n");
+	while (i > 0) {
+		printk("x%-2d: %016llx x%-2d: %016llx\n",
+		       i, regs->regs[i],
+		       i - 1, regs->regs[i - 1]);
+		i -= 2;
+	}
 }
 
 void show_regs(struct pt_regs * regs)
 {
 	printk("\n");
 	__show_regs(regs);
+	printk("\n");
 }
 
 static void tls_thread_flush(void)
-- 
2.10.0.rc2.1.g053435c
