From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 26 Aug 2014 11:28:45 +0100
Subject: [PATCH 1/6] arm: Fix in-correct barrier usage in SWP{B} emulation
In-Reply-To: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1409048930-21598-2-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the ARM ARMv7, explicit barriers are necessary when using
synchronisation primitives such as SWP{B}. The use of these
instructions does not automatically imply a barrier and any ordering
requirements by the software must be explicitly expressed with the use
of suitable barriers.

Based on this, remove the barriers from SWP{B} emulation.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm/kernel/swp_emulate.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index b1b8988..74117b5 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -141,14 +141,6 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 	while (1) {
 		unsigned long temp;
 
-		/*
-		 * Barrier required between accessing protected resource and
-		 * releasing a lock for it. Legacy code might not have done
-		 * this, and we cannot determine that this is not the case
-		 * being emulated, so insert always.
-		 */
-		smp_mb();
-
 		if (type == TYPE_SWPB)
 			__user_swpb_asm(*data, address, res, temp);
 		else
@@ -161,13 +153,6 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
 	}
 
 	if (res == 0) {
-		/*
-		 * Barrier also required between acquiring a lock for a
-		 * protected resource and accessing the resource. Inserted for
-		 * same reason as above.
-		 */
-		smp_mb();
-
 		if (type == TYPE_SWPB)
 			swpbcounter++;
 		else
-- 
1.7.10.4
