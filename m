From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  4 Jul 2014 16:22:16 +0200
Subject: [PATCH] ARM: mvebu: Fix the operand list in the inline asm of
 armada_370_xp_pmsu_idle_enter
Message-ID: <1404483736-16938-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the inline asm part of the function armada_370_xp_pmsu_idle_enter()
the input operand was used. The intent here was to let the compiler
choose this register so it could do the optimization it
needed.

However an input operand is not supposed to be modified by the inline
asm code. This can lead to improper generated instructions.

In some case generated instruction the compiler made the choice to
reuse the same register to store the return value. But in the assembly
part this register was modified, so it can lead to return an wrong
value.

The fix is to use a clobber. Thanks to this the compiler will know
that the value of this register will be modified.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi,

I found this bug while adding cpu idle support for Armada 370 and only
recently after rebasing the code on mvebu/soc. So this patch fixes
something which can really happen even if we didn't notice it on
Armada XP. Fortunately the code fixed was introduced during this
release, so there is no need to backport it, just to apply it on
3.16-rc.

Thanks,
Gregory

 arch/arm/mach-mvebu/pmsu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8520bf..d15b0b346a26 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -206,12 +206,12 @@ static noinline int do_armada_370_xp_cpu_suspend(unsigned long deepidle)
 
 	/* Test the CR_C bit and set it if it was cleared */
 	asm volatile(
-	"mrc	p15, 0, %0, c1, c0, 0 \n\t"
-	"tst	%0, #(1 << 2) \n\t"
-	"orreq	%0, %0, #(1 << 2) \n\t"
-	"mcreq	p15, 0, %0, c1, c0, 0 \n\t"
+	"mrc	p15, 0, r0, c1, c0, 0 \n\t"
+	"tst	r0, #(1 << 2) \n\t"
+	"orreq	r0, r0, #(1 << 2) \n\t"
+	"mcreq	p15, 0, r0, c1, c0, 0 \n\t"
 	"isb	"
-	: : "r" (0));
+	: : : "r0");
 
 	pr_warn("Failed to suspend the system\n");
 
-- 
1.8.1.2
