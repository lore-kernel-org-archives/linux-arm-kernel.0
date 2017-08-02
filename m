From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:20 -0600
Subject: [PATCH 26/26] coresight: STM: Clean up __iomem type usage
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-27-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

The casting and other things here is odd, and causes sparse to
complain:

drivers/hwtracing/coresight/coresight-stm.c:279:35: warning: incorrect type in argument 1 (different address spaces)
drivers/hwtracing/coresight/coresight-stm.c:279:35:    expected void [noderef] <asn:2>*addr
drivers/hwtracing/coresight/coresight-stm.c:279:35:    got struct stm_drvdata *drvdata
drivers/hwtracing/coresight/coresight-stm.c:327:17: warning: incorrect type in argument 2 (different address spaces)
drivers/hwtracing/coresight/coresight-stm.c:327:17:    expected void volatile [noderef] <asn:2>*addr
drivers/hwtracing/coresight/coresight-stm.c:327:17:    got void *addr
drivers/hwtracing/coresight/coresight-stm.c:330:17: warning: incorrect type in argument 2 (different address spaces)
drivers/hwtracing/coresight/coresight-stm.c:330:17:    expected void volatile [noderef] <asn:2>*addr
drivers/hwtracing/coresight/coresight-stm.c:330:17:    got void *addr
drivers/hwtracing/coresight/coresight-stm.c:333:17: warning: incorrect type in argument 2 (different address spaces)
drivers/hwtracing/coresight/coresight-stm.c:333:17:    expected void volatile [noderef] <asn:2>*addr
drivers/hwtracing/coresight/coresight-stm.c:333:17:    got void *addr

>From what I can tell, we don't really need to treat ch_addr as
anything besides a pointer, and we can just do pointer math
instead of ORing in the bits of the offset and achieve the same
thing.

Also, we were passing a drvdata pointer to the
coresight_timeout() function, but we really wanted to pass the
address of the register base. Luckily the base is the first
member of the structure, so everything works out, but this is
quite unsafe if we ever change the structure layout. Clean this
all up so sparse stops complaining on this code.

Reported-by: Satyajit Desai <sadesai@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 202ed7a909e1..8ec4c4f8a2f2 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -276,7 +276,7 @@ static void stm_disable(struct coresight_device *csdev,
 		spin_unlock(&drvdata->spinlock);
 
 		/* Wait until the engine has completely stopped */
-		coresight_timeout(drvdata, STMTCSR, STMTCSR_BUSY_BIT, 0);
+		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
 
 		pm_runtime_put(drvdata->dev);
 
@@ -307,7 +307,8 @@ static inline bool stm_addr_unaligned(const void *addr, u8 write_bytes)
 	return ((unsigned long)addr & (write_bytes - 1));
 }
 
-static void stm_send(void *addr, const void *data, u32 size, u8 write_bytes)
+static void stm_send(void __iomem *addr, const void *data,
+		     u32 size, u8 write_bytes)
 {
 	u8 paload[8];
 
@@ -414,7 +415,7 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 				  unsigned int size,
 				  const unsigned char *payload)
 {
-	unsigned long ch_addr;
+	void __iomem *ch_addr;
 	struct stm_drvdata *drvdata = container_of(stm_data,
 						   struct stm_drvdata, stm);
 
@@ -424,7 +425,7 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 	if (channel >= drvdata->numsp)
 		return -EINVAL;
 
-	ch_addr = (unsigned long)stm_channel_addr(drvdata, channel);
+	ch_addr = stm_channel_addr(drvdata, channel);
 
 	flags = (flags == STP_PACKET_TIMESTAMPED) ? STM_FLAG_TIMESTAMPED : 0;
 	flags |= test_bit(channel, drvdata->chs.guaranteed) ?
@@ -437,20 +438,20 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 
 	switch (packet) {
 	case STP_PACKET_FLAG:
-		ch_addr |= stm_channel_off(STM_PKT_TYPE_FLAG, flags);
+		ch_addr += stm_channel_off(STM_PKT_TYPE_FLAG, flags);
 
 		/*
 		 * The generic STM core sets a size of '0' on flag packets.
 		 * As such send a flag packet of size '1' and tell the
 		 * core we did so.
 		 */
-		stm_send((void *)ch_addr, payload, 1, drvdata->write_bytes);
+		stm_send(ch_addr, payload, 1, drvdata->write_bytes);
 		size = 1;
 		break;
 
 	case STP_PACKET_DATA:
-		ch_addr |= stm_channel_off(STM_PKT_TYPE_DATA, flags);
-		stm_send((void *)ch_addr, payload, size,
+		ch_addr += stm_channel_off(STM_PKT_TYPE_DATA, flags);
+		stm_send(ch_addr, payload, size,
 				drvdata->write_bytes);
 		break;
 
-- 
2.7.4
