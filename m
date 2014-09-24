From: behanw@converseincode.com (Behan Webster)
Date: Tue, 23 Sep 2014 20:44:44 -0700
Subject: [PATCH] arm, vt8500,
 LLVMLlinux: Use mcr instead of mcr% for mach-vt8500
Message-ID: <1411530284-28807-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ASM below does not compile with clang and is not the way that the mcr
command is used in other parts of the kernel.

arch/arm/mach-vt8500/vt8500.c:72:11: error: invalid % escape in inline assembly string
        asm("mcr%? p15, 0, %0, c7, c0, 4" : : "r" (0));
            ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

There are other forms that are supported on different ARM instruction sets but
generally the kernel just uses mcr as it is supported in all ARM instruction
sets.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Mark Charlebois <charlebm@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-vt8500/vt8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 2da7be3..3bc0dc9 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -69,7 +69,7 @@ static void vt8500_power_off(void)
 {
 	local_irq_disable();
 	writew(5, pmc_base + VT8500_HCR_REG);
-	asm("mcr%? p15, 0, %0, c7, c0, 4" : : "r" (0));
+	asm("mcr p15, 0, %0, c7, c0, 4" : : "r" (0));
 }
 
 static void __init vt8500_init(void)
-- 
1.9.1
