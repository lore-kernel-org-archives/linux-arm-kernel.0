From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Aug 2015 15:47:51 +0200
Subject: [PATCH] ARM: mvebu: Use a CR_C constant instead of a hard-coded one
Message-ID: <1439214471-25902-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the armada_370_xp_pmsu_idle_enter() function to use a CR_C
constant instead of a hard-coded constant in the assembly part.
This clean-up was suggested by Russell King.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi,

this clean-up is not for 4.2 neither for 4.3 (the rc6 had just been
released), but for 4.4. I send it now to not forget it.

Gregory

 arch/arm/mach-mvebu/pmsu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 4f4e22206ae5..8efb83cea83d 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -296,11 +296,11 @@ int armada_370_xp_pmsu_idle_enter(unsigned long deepidle)
 	/* Test the CR_C bit and set it if it was cleared */
 	asm volatile(
 	"mrc	p15, 0, r0, c1, c0, 0 \n\t"
-	"tst	r0, #(1 << 2) \n\t"
+	"tst	r0, %0 \n\t"
 	"orreq	r0, r0, #(1 << 2) \n\t"
 	"mcreq	p15, 0, r0, c1, c0, 0 \n\t"
 	"isb	"
-	: : : "r0");
+	: : "Ir" (CR_C) : "r0");
 
 	pr_debug("Failed to suspend the system\n");
 
-- 
2.1.0
