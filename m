From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Aug 2012 10:56:49 +0100
Subject: [PATCH] ARM: contextidr: avoid using bfi instruction during notifier
Message-ID: <1345715809-12312-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bfi instruction is not available on ARMv6, so instead use an and/orr
sequence in the contextidr_notifier. This gets rid of the assembler
error:

  Assembler messages:
  Error: selected processor does not support ARM mode `bfi r3,r2,#0,#8'

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Tested on my Integrator/CP w/ an 1136 tile.

 arch/arm/mm/context.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 119bc52..4e07eec 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -63,10 +63,11 @@ static int contextidr_notifier(struct notifier_block *unused, unsigned long cmd,
 	pid = task_pid_nr(thread->task) << ASID_BITS;
 	asm volatile(
 	"	mrc	p15, 0, %0, c13, c0, 1\n"
-	"	bfi	%1, %0, #0, %2\n"
-	"	mcr	p15, 0, %1, c13, c0, 1\n"
+	"	and	%0, %0, %2\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c13, c0, 1\n"
 	: "=r" (contextidr), "+r" (pid)
-	: "I" (ASID_BITS));
+	: "I" (~ASID_MASK));
 	isb();
 
 	return NOTIFY_OK;
-- 
1.7.4.1
