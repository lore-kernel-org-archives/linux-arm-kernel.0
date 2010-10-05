From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue,  5 Oct 2010 21:53:32 +0200
Subject: [PATCH] ARM: fix isb regression on CPU < v7
Message-ID: <1286308412-8252-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel does not compile for my ARM926EJ-S system U300 due to
the isb instruction inserted in generic assember statement from
commit 8925ec4c530094b878e7e28a1fd78e7122afd973, "ARM: 6385/1:
setup: detect aliasing I-cache when D-cache is non-aliasing"
hey the isb is only available when assembling for v7 so let's
use the generic isb() macro from setup.h instead.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/kernel/setup.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4572cf8..336f14e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -247,11 +247,12 @@ static int cpu_has_aliasing_icache(unsigned int arch)
 	/* arch specifies the register format */
 	switch (arch) {
 	case CPU_ARCH_ARMv7:
-		asm("mcr	p15, 2, %1, c0, c0, 0	@ set CSSELR\n"
-		    "isb\n"
-		    "mrc	p15, 1, %0, c0, c0, 0	@ read CCSIDR"
-		    : "=r" (id_reg)
+		asm("mcr	p15, 2, %0, c0, c0, 0 @ set CSSELR"
+		    : /* No output operands */
 		    : "r" (1));
+		isb();
+		asm("mrc	p15, 1, %0, c0, c0, 0 @ read CCSIDR"
+		    : "=r" (id_reg));
 		line_size = 4 << ((id_reg & 0x7) + 2);
 		num_sets = ((id_reg >> 13) & 0x7fff) + 1;
 		aliasing_icache = (line_size * num_sets) > PAGE_SIZE;
-- 
1.7.2.3
