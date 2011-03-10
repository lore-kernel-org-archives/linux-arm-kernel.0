From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Mar 2011 12:37:14 +0530
Subject: [PATCH v2 2/5] OMAP3: PM: Fix the MMU on sequence in the asm code
In-Reply-To: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
References: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1299740837-27881-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add necessary barriers after enabling MMU. Also use the sane way to
load pc and jump to it instead of executing ldma first up.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 8894c08..e58ec7d 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -619,12 +619,17 @@ usettbr0:
 	ldr	r2, cache_pred_disable_mask
 	and	r4, r2
 	mcr	p15, 0, r4, c1, c0, 0
+	dsb
+	isb
+	ldr     r0, =restoremmu_on
+	bx      r0
 
 /*
  * ==============================
  * == Exit point from OFF mode ==
  * ==============================
  */
+restoremmu_on:
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
 
-- 
1.6.0.4
