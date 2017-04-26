From: joe@perches.com (Joe Perches)
Date: Wed, 26 Apr 2017 10:39:49 -0700
Subject: [PATCH] ARM: Fix __show_regs output timestamps
Message-ID: <61817479ac8c4c6c8be702d2e2136fddac1b1821.1493228290.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiple line formats are not preferred as the second and
subsequent lines may not have timestamps.

Lacking timestamps makes reading the output a bit difficult.
This also makes arm/arm64 output more similar.

Previous:

[ 1514.093231] pc : [<bf79c304>]    lr : [<bf79ced8>]    psr: a00f0013
sp : ecdd7e20  ip : 00000000  fp : ffffffff

New:

[ 1514.093231] pc : [<bf79c304>]    lr : [<bf79ced8>]    psr: a00f0013
[ 1514.105316] sp : ecdd7e20  ip : 00000000  fp : ffffffff

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/kernel/process.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 939e8b58c59d..151cece4a293 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -123,10 +123,10 @@ void __show_regs(struct pt_regs *regs)
 
 	print_symbol("PC is at %s\n", instruction_pointer(regs));
 	print_symbol("LR is at %s\n", regs->ARM_lr);
-	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n"
-	       "sp : %08lx  ip : %08lx  fp : %08lx\n",
-		regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr,
-		regs->ARM_sp, regs->ARM_ip, regs->ARM_fp);
+	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n",
+	       regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr);
+	printk("sp : %08lx  ip : %08lx  fp : %08lx\n",
+	       regs->ARM_sp, regs->ARM_ip, regs->ARM_fp);
 	printk("r10: %08lx  r9 : %08lx  r8 : %08lx\n",
 		regs->ARM_r10, regs->ARM_r9,
 		regs->ARM_r8);
-- 
2.10.0.rc2.1.g053435c
