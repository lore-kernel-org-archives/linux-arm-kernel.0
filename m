From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 19 Feb 2014 12:17:02 +0000
Subject: [PATCH 1/2] drivers: cci: Extend support to CCI revisions > r1p2
In-Reply-To: <1392812223-29274-1-git-send-email-punit.agrawal@arm.com>
References: <1392812223-29274-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1392812223-29274-2-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver queries the CCI IP revision to distinguish between r0 and r1
scheme for event numbers and currently supports upto version r1p2. To
minimise code churn every time there's a new version of the IP, assume
that event numbering doesn't change for revisions > r1p0 (which is
the case).

The driver will still need an update for future revisions that change
the event numbers.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 drivers/bus/arm-cci.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 962fd35..da485ae 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -88,8 +88,7 @@ static unsigned long cci_ctrl_phys;
 
 #define CCI_REV_R0		0
 #define CCI_REV_R1		1
-#define CCI_REV_R0_P4		4
-#define CCI_REV_R1_P2		6
+#define CCI_REV_R1_PX		5
 
 #define CCI_PMU_EVT_SEL		0x000
 #define CCI_PMU_CNTR		0x004
@@ -193,21 +192,16 @@ static int probe_cci_revision(void)
 	rev = readl_relaxed(cci_ctrl_base + CCI_PID2) & CCI_PID2_REV_MASK;
 	rev >>= CCI_PID2_REV_SHIFT;
 
-	if (rev <= CCI_REV_R0_P4)
+	if (rev < CCI_REV_R1_PX)
 		return CCI_REV_R0;
-	else if (rev <= CCI_REV_R1_P2)
+	else
 		return CCI_REV_R1;
-
-	return -ENOENT;
 }
 
 static struct pmu_port_event_ranges *port_range_by_rev(void)
 {
 	int rev = probe_cci_revision();
 
-	if (rev < 0)
-		return NULL;
-
 	return &port_event_range[rev];
 }
 
-- 
1.7.10.4
