From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 22 Jan 2013 10:56:40 +0000
Subject: [PATCH] ARM: Versatile Express: extend the MPIDR range used for pen
 release check
Message-ID: <1358852200-4581-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ARM multi-cluster systems the MPIDR affinity level 0 cannot be used as a
single cpu identifier, affinity levels 1 and 2 must be taken into account as
well.
This patch extends the MPIDR usage to affinity levels 1 and 2 in versatile
secondary cores start up code in order to compare the passed pen_release
value with the full-blown affinity mask.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm/plat-versatile/headsmp.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
index dd703ef..b178d44 100644
--- a/arch/arm/plat-versatile/headsmp.S
+++ b/arch/arm/plat-versatile/headsmp.S
@@ -20,7 +20,7 @@
  */
 ENTRY(versatile_secondary_startup)
 	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
+	bic	r0, #0xff000000
 	adr	r4, 1f
 	ldmia	r4, {r5, r6}
 	sub	r4, r4, r5
-- 
1.7.12
