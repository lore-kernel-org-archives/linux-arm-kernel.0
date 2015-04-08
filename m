From: broonie@kernel.org (Mark Brown)
Date: Wed,  8 Apr 2015 23:47:52 +0100
Subject: [PATCH] coresight: etb10: Fix check for bogus buffer depth
Message-ID: <1428533272-23375-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We attempt to sanity check the buffer depth reported by the hardware by
making sure it is not less than zero however this check will never be true
since the buffer depth is stored in an unsigned integer. Instead change
the check to look for the top bit being set which was the intention.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

This depends on the patch I sent earlier today for context though
there's no direct dependency (and this check isn't sufficient to catch
the fault I'm seeing).

 drivers/hwtracing/coresight/coresight-etb10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 46eb9f88a29f..2a77d83130e6 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -457,7 +457,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->buffer_depth = etb_get_buffer_depth(drvdata);
 	clk_disable_unprepare(drvdata->clk);
 
-	if (drvdata->buffer_depth < 0)
+	if (drvdata->buffer_depth & 0x80000000)
 		return -EINVAL;
 
 	drvdata->buf = devm_kzalloc(dev,
-- 
2.1.4
