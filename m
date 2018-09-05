From: leo.yan@linaro.org (Leo Yan)
Date: Wed,  5 Sep 2018 15:55:43 +0800
Subject: [PATCH 1/2] coresight: tmc: Fix byte-address alignment for RRP
Message-ID: <1536134144-2764-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From the comment in the code, it claims the requirement for byte-address
alignment for RRP register: 'for 32-bit, 64-bit and 128-bit wide trace
memory, the four LSBs must be 0s. For 256-bit wide trace memory, the
five LSBs must be 0s'.  This isn't consistent with the program, the
program sets five LSBs as zeros for 32/64/128-bit wide trace memory and
set six LSBs zeros for 256-bit wide trace memory.

After checking with the CoreSight Trace Memory Controller technical
reference manual (ARM DDI 0461B, section 3.3.4 RAM Read Pointer
Register), it proves the comment is right and the program does wrong
setting.

This patch fixes byte-address alignment for RRP by following correct
definition in the technical reference manual.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0549249..e310613 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -438,10 +438,10 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 		case TMC_MEM_INTF_WIDTH_32BITS:
 		case TMC_MEM_INTF_WIDTH_64BITS:
 		case TMC_MEM_INTF_WIDTH_128BITS:
-			mask = GENMASK(31, 5);
+			mask = GENMASK(31, 4);
 			break;
 		case TMC_MEM_INTF_WIDTH_256BITS:
-			mask = GENMASK(31, 6);
+			mask = GENMASK(31, 5);
 			break;
 		}
 
-- 
2.7.4
