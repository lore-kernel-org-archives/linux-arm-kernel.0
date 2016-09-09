From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Fri,  9 Sep 2016 18:18:09 +0800
Subject: [PATCH] coresight: stm: return error code instead of zero in
 .packet() to avoid dead loop
Message-ID: <1473416289-30882-1-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In STM framework driver, the trace data writing loop would keep running
until it received a negative return value or the whole trace packet has
been written to STM device.  So if the .packet() of STM device always
returns zero since the device is not enabled or the parameter isn't
supported, STM framework driver will stall into a dead loop.

Returning -EACCES (Permission denied) in .packet() if the device is
disabled makes more sense, and this is the same for returning -EINVAL
if the channel passed into is not supported.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 73be58a..6291ce1 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -399,10 +399,10 @@ static ssize_t stm_generic_packet(struct stm_data *stm_data,
 						   struct stm_drvdata, stm);
 
 	if (!(drvdata && local_read(&drvdata->mode)))
-		return 0;
+		return -EACCES;
 
 	if (channel >= drvdata->numsp)
-		return 0;
+		return -EINVAL;
 
 	ch_addr = (unsigned long)stm_channel_addr(drvdata, channel);
 
-- 
2.7.4
