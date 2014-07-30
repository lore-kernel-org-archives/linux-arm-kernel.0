From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 30 Jul 2014 11:37:35 +0100
Subject: [PATCH] drivers: CCI: Correct use of ! and &
Message-ID: <1406716655-32494-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Himangi Saraogi <himangi774@gmail.com>

In commit ae91d60ba88ef0bdb1b5e9b2363bd52fc45d2af7, a bug was fixed that
involved converting !x & y to !(x & y).  The code below shows the same
pattern, and thus should perhaps be fixed in the same way.

The Coccinelle semantic patch that makes this change is as follows:

// <smpl>
@@ expression E1,E2; @@
(
  !E1 & !E2
|
- !E1 & E2
+ !(E1 & E2)
)
// </smpl>

Cc: stable at vger.kernel.org
Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
---
 drivers/bus/arm-cci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5a86da9..7af78df 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -397,7 +397,8 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
 		hw_counter = &event->hw;
 
 		/* Did this counter overflow? */
-		if (!pmu_read_register(idx, CCI_PMU_OVRFLW) & CCI_PMU_OVRFLW_FLAG)
+		if (!(pmu_read_register(idx, CCI_PMU_OVRFLW) &
+		      CCI_PMU_OVRFLW_FLAG))
 			continue;
 
 		pmu_write_register(CCI_PMU_OVRFLW_FLAG, idx, CCI_PMU_OVRFLW);
-- 
1.7.10.4
