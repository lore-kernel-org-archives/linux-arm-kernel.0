From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  7 May 2014 10:51:56 +0100
Subject: [PATCH RESEND 1/2] arm: SIGBUS on unsupported ARMv6 unaligned accesses
In-Reply-To: <cover.1399028497.git.robin.murphy@arm.com>
References: <cover.1399028497.git.robin.murphy@arm.com>
Message-ID: <6c89b740173398578fa999c99237858b7680a84e.1399028497.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the default behaviour for userspace alignment faults
on v6 from silent fixup to SIGBUS. This only affects code that violates
the v6 unaligned access model - bad assembly/JIT code or high-level
language code in violation of the relevant language spec - which should
be corrected rather than unwittingly relying on performance-degrading
fixups. Fixup behaviour can still be controlled from boot parameters or
at runtime for compatibility with existing incorrect software.

There will be no impact for v5 and earlier.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
---

This one is already in the patch system as 7944/1, since nobody objected
to the original RFC or patch postings.
Russell: any news on whether you're happy to take this?

 arch/arm/mm/alignment.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9240364..9a93315 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -106,10 +106,10 @@ static int safe_usermode(int new_usermode, bool warn)
 	 * making any progress.
 	 */
 	if (cpu_is_v6_unaligned() && !(new_usermode & (UM_FIXUP | UM_SIGNAL))) {
-		new_usermode |= UM_FIXUP;
+		new_usermode |= UM_SIGNAL;
 
 		if (warn)
-			printk(KERN_WARNING "alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.\n");
+			printk(KERN_WARNING "alignment: ignoring faults is unsafe on this CPU.  Defaulting to signal mode.\n");
 	}
 
 	return new_usermode;
@@ -971,7 +971,7 @@ static int __init alignment_init(void)
 		cr_alignment &= ~CR_A;
 		cr_no_alignment &= ~CR_A;
 		set_cr(cr_alignment);
-		ai_usermode = safe_usermode(ai_usermode, false);
+		ai_usermode = safe_usermode(ai_usermode | UM_WARN, false);
 	}
 #endif
 
-- 
1.7.9.5
