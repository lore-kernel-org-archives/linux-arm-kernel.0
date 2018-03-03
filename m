From: leo.yan@linaro.org (Leo Yan)
Date: Sat,  3 Mar 2018 12:23:01 +0800
Subject: [PATCH] coresight: use %px to print pcsr instead of %p
Message-ID: <1520050981-17129-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
printk specifier %p to hash all addresses before printing, this was
resulting in the high 32 bits of pcsr can only output zeros.  So
module cannot completely print pc value and it's pointless for debugging
purpose.

This patch fixes this by using %px to print pcsr instead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 6ea62c6..9cdb3fb 100644
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
