From: hoan.tran@amperecomputing.com (Hoan Tran)
Date: Wed,  6 Jun 2018 14:06:54 -0700
Subject: [PATCH] perf: xgene: Fix IOB SLOW PMU parser error
Message-ID: <1528319214-19726-1-git-send-email-hoan.tran@amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below parser error of the IOB SLOW PMU.

        # perf stat -a -e iob-slow0/cycle-count/ sleep 1
        evenf syntax error: 'iob-slow0/cycle-count/'
                                 \___ parser error

It replaces the "-" character by "_" character inside the PMU name.

Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
---
 drivers/perf/xgene_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 6bdb1da..0e31f13 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1463,7 +1463,7 @@ static char *xgene_pmu_dev_name(struct device *dev, u32 type, int id)
        case PMU_TYPE_IOB:
                return devm_kasprintf(dev, GFP_KERNEL, "iob%d", id);
        case PMU_TYPE_IOB_SLOW:
-               return devm_kasprintf(dev, GFP_KERNEL, "iob-slow%d", id);
+               return devm_kasprintf(dev, GFP_KERNEL, "iob_slow%d", id);
        case PMU_TYPE_MCB:
                return devm_kasprintf(dev, GFP_KERNEL, "mcb%d", id);
        case PMU_TYPE_MC:
--
2.7.4

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is for the sole use of the intended recipient(s) and contains information that is confidential and proprietary to Ampere Computing or its subsidiaries. It is to be used solely for the purpose of furthering the parties' business relationship. Any review, copying, or distribution of this email (or any attachments thereto) is strictly prohibited. If you are not the intended recipient, please contact the sender immediately and permanently delete the original and any copies of this email and any attachments thereto.
