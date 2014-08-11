From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Aug 2014 10:24:07 +0100
Subject: [PATCH 1/2] ARM: abort: don't clear the exclusive monitors
Message-ID: <1407749048-18909-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv6 and ARMv7 early abort handlers clear the exclusive monitors
upon entry to the kernel, but this is redundant:

  - We clear the monitors on every exception return since commit
    200b812d0084 ("Clear the exclusive monitor when returning from an
    exception"), so this is not necessary to ensure the monitors are
    cleared before returning from a fault handler.

  - Any dummy STREX will target a temporary scratch area in memory, and
    may succeed or fail without corrupting useful data. Its status value
    will not be used.

  - Any other STREX in the kernel must be preceded by an LDREX, which
    will initialise the monitors consistently and will not depend on the
    earlier state of the monitors.

Therefore we have no reason to care about the initial state of the
exclusive monitors when a data abort is taken, and clearing the monitors
prior to exception return (as we already do) is sufficient.

This patch removes the redundant clearing of the exclusive monitors from
the early abort handlers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: stable at vger.kernel.org
---
 arch/arm/mm/abort-ev6.S | 6 ------
 arch/arm/mm/abort-ev7.S | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index 3815a82..8c48c5c 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -17,12 +17,6 @@
  */
 	.align	5
 ENTRY(v6_early_abort)
-#ifdef CONFIG_CPU_V6
-	sub	r1, sp, #4			@ Get unused stack location
-	strex	r0, r1, [r1]			@ Clear the exclusive monitor
-#elif defined(CONFIG_CPU_32v6K)
-	clrex
-#endif
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 /*
diff --git a/arch/arm/mm/abort-ev7.S b/arch/arm/mm/abort-ev7.S
index 7033752..4812ad0 100644
--- a/arch/arm/mm/abort-ev7.S
+++ b/arch/arm/mm/abort-ev7.S
@@ -13,12 +13,6 @@
  */
 	.align	5
 ENTRY(v7_early_abort)
-	/*
-	 * The effect of data aborts on on the exclusive access monitor are
-	 * UNPREDICTABLE. Do a CLREX to clear the state
-	 */
-	clrex
-
 	mrc	p15, 0, r1, c5, c0, 0		@ get FSR
 	mrc	p15, 0, r0, c6, c0, 0		@ get FAR
 
-- 
1.9.1
