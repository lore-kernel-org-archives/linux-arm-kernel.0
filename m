From: joe@perches.com (Joe Perches)
Date: Sun, 23 Oct 2016 13:40:49 -0700
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
Message-ID: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit db4b0710fae9 ("arm64: fix show_regs fallout from KERN_CONT changes")
corrected the KERN_CONT fallout from commit 4bcc595ccd80
("printk: reinstate KERN_CONT for printing continuation lines"), but
the code still has unnecessary KERN_CONT uses.  Remove them.

Miscellanea:

o Remove unnecessary trailing blank from the output too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm64/kernel/process.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 01753cd7d3f0..2278e7197a8e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -190,18 +190,16 @@ void __show_regs(struct pt_regs *regs)
 
 	i = top_reg;
 
-	while (i >= 0) {
-		printk("x%-2d: %016llx ", i, regs->regs[i]);
+	if (i >= 0 && !(i % 2)) {
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
-- 
2.10.0.rc2.1.g053435c
