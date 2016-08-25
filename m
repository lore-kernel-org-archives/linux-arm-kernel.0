From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:18:58 -0600
Subject: [PATCH 08/28] coresight: etmv4: Fix ETMv4x peripheral ID table
In-Reply-To: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472159958-5981-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

This patch cleans up the peripheral id table for different ETMv4
implementations.

As per Cortex-A53 TRM, the ETM has following id values:

Peripheral ID0	0x5D	0xFE0
Peripheral ID1	0xB9	0xFE4
Peripheral ID2	0x4B	0xFE8
Peripheral ID3	0x00	0xFEC

where, PID2: has the following format:

[7:4]   Revision
[3]     JEDEC   0b1     res1. Indicates a JEP106 identity code is used
[2:0]   DES_1   0b011   ARM Limited. This is bits[6:4] of JEP106 ID code

The existing table entry checks only the bits [1:0], which is not
sufficient enough. Fix it to match bits [3:0], just like the other
entries do. While at it, correct the comment for A57 and the A53 entry.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 17e2e81d2e90..bc5ed207a3b5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -812,12 +812,12 @@ err_arch_supported:
 }
 
 static struct amba_id etm4_ids[] = {
-	{       /* ETM 4.0 - Qualcomm */
-		.id	= 0x0003b95d,
-		.mask	= 0x0003ffff,
+	{       /* ETM 4.0 - Cortex-A53  */
+		.id	= 0x000bb95d,
+		.mask	= 0x000fffff,
 		.data	= "ETM 4.0",
 	},
-	{       /* ETM 4.0 - Juno board */
+	{       /* ETM 4.0 - Cortex-A57 */
 		.id	= 0x000bb95e,
 		.mask	= 0x000fffff,
 		.data	= "ETM 4.0",
-- 
2.7.4
