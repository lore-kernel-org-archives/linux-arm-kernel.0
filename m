From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 11 Jul 2018 15:45:41 +0800
Subject: [PATCH v2 2/6] perf cs-etm: Bail out immediately for instruction
 sample failure
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1531295145-596-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the instruction sample failure has happened, it isn't necessary to
execute to the end of the function cs_etm__flush().  This commit is to
bail out immediately and return the error code.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 822ba91..8b2c099 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -939,6 +939,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 		err = cs_etm__synth_instruction_sample(
 			etmq, addr,
 			etmq->period_instructions);
+		if (err)
+			return err;
+
 		etmq->period_instructions = 0;
 
 		/*
-- 
2.7.4
