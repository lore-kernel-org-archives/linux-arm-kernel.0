From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 13 Mar 2018 11:24:30 -0600
Subject: [PATCH 1/2] coresight: Use %px to print pcsr instead of %p
In-Reply-To: <1520961871-11196-1-git-send-email-mathieu.poirier@linaro.org>
References: <1520961871-11196-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1520961871-11196-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
printk specifier %p to hash all addresses before printing, this was
resulting in the high 32 bits of pcsr can only output zeros.  So
module cannot completely print pc value and it's pointless for debugging
purpose.

This patch fixes this by using %px to print pcsr instead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 6ea62c62ff27..9cdb3fbc8c1f 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -315,7 +315,7 @@ static void debug_dump_regs(struct debug_drvdata *drvdata)
 	}
 
 	pc = debug_adjust_pc(drvdata);
-	dev_emerg(dev, " EDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
+	dev_emerg(dev, " EDPCSR:  [<%px>] %pS\n", (void *)pc, (void *)pc);
 
 	if (drvdata->edcidsr_present)
 		dev_emerg(dev, " EDCIDSR: %08x\n", drvdata->edcidsr);
-- 
2.7.4
