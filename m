From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2011 16:39:42 +0100
Subject: [PATCH] ARM: mm: ensure TTBR0 is restored when changing ASID on
	rollover
Message-ID: <1306856382-26295-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 52af9c6c ("ARM: 6943/1: mm: use TTBR1 instead of reserved context ID")
I updated the ASID rollover code to use only the kernel page tables
whilst updating the ASID.

Unfortunately, the code to restore the user page tables was part of a
later patch which isn't yet in mainline, so this leaves the code
quite broken.

This patch fixes the issue by calling cpu_switch_mm to change the ASID
which has the side-effect of setting up TTBR0 to point to the user
tables.

Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 8bfae96..2352395 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -100,8 +100,7 @@ static void reset_context(void *info)
 	set_mm_context(mm, asid);
 
 	/* set the new ASID */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (mm->context.id));
-	isb();
+	cpu_switch_mm(mm->pgd, mm);
 }
 
 #else
-- 
1.7.0.4
