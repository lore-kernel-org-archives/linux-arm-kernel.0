From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 12 Aug 2016 17:25:54 +0100
Subject: [PATCH 3/5] bus: arm-ccn: Fix XP watchpoint settings bitmask
In-Reply-To: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
References: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1471019156-5485-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code setting XP watchpoint comparator and mask registers should, in
order to be fully compliant with specification, zero one or more most
significant bits of each field. In both L cases it means zeroing bit 63.
The bitmask doing this was wrong, though, zeroing bit 60 instead.
Fortunately, due to a lucky coincidence, this turned out to be fairly
innocent with the existing hardware.

Fixed now.

Cc: stable at vger.kernel.org # 3.17+
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 9bbb0ab..647a27b 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1003,7 +1003,7 @@ static void arm_ccn_pmu_xp_watchpoint_config(struct perf_event *event)
 
 	/* Comparison values */
 	writel(cmp_l & 0xffffffff, source->base + CCN_XP_DT_CMP_VAL_L(wp));
-	writel((cmp_l >> 32) & 0xefffffff,
+	writel((cmp_l >> 32) & 0x7fffffff,
 			source->base + CCN_XP_DT_CMP_VAL_L(wp) + 4);
 	writel(cmp_h & 0xffffffff, source->base + CCN_XP_DT_CMP_VAL_H(wp));
 	writel((cmp_h >> 32) & 0x0fffffff,
@@ -1011,7 +1011,7 @@ static void arm_ccn_pmu_xp_watchpoint_config(struct perf_event *event)
 
 	/* Mask */
 	writel(mask_l & 0xffffffff, source->base + CCN_XP_DT_CMP_MASK_L(wp));
-	writel((mask_l >> 32) & 0xefffffff,
+	writel((mask_l >> 32) & 0x7fffffff,
 			source->base + CCN_XP_DT_CMP_MASK_L(wp) + 4);
 	writel(mask_h & 0xffffffff, source->base + CCN_XP_DT_CMP_MASK_H(wp));
 	writel((mask_h >> 32) & 0x0fffffff,
-- 
2.7.4
