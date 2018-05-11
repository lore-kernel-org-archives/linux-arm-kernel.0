From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Fri, 11 May 2018 11:35:23 +0800
Subject: [PATCH 2/9] armv8: pm: Fix issue of rcpm driver wrongly program other
 IP control bits
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
Message-ID: <20180511033530.7931-2-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ran Wang <ran.wang_1@nxp.com>

When rcpm driver get target register data from DTS property 'fsl,
rcpm-wakeup' (second value), it directly write that data to register
RCPM_IPPDEXPCRx rather than 'OR' the value read from it before. This
operation will over-write those non-related IP control bit which
might have been programmed, should be prevented.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/rcpm.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index ff0477b..39eabfb 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -75,6 +75,7 @@ static void rcpm_wakeup_fixup(struct device *dev, void *data)
 static int rcpm_suspend_prepare(void)
 {
 	int i;
+	u32 val;
 
 	WARN_ON(!rcpm);
 
@@ -84,9 +85,12 @@ static int rcpm_suspend_prepare(void)
 	dpm_for_each_dev(NULL, rcpm_wakeup_fixup);
 
 	for (i = 0; i < rcpm->ipp_num; i++) {
-		rcpm_reg_write(rcpm->ippdexpcr_offset + 4 * i,
-			       rcpm->ippdexpcr[i]);
-		pr_debug("ippdexpcr%d = 0x%x\n", i, rcpm->ippdexpcr[i]);
+		if (rcpm->ippdexpcr[i]) {
+			val = rcpm_reg_read(rcpm->ippdexpcr_offset + 4 * i);
+			rcpm_reg_write(rcpm->ippdexpcr_offset + 4 * i,
+					       val | rcpm->ippdexpcr[i]);
+			pr_debug("ippdexpcr%d = 0x%x\n", i, rcpm->ippdexpcr[i]);
+		}
 	}
 
 	return 0;
-- 
1.7.1
