From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Nov 2016 16:17:49 +0100
Subject: [PATCH 1/8] dma: pl08x: Add support for the DMA slave map
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478791076-19528-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the new channel request API introduced
in commit a8135d0d79e9d0ad3a4ff494fceeaae83
"dmaengine: core: Introduce new, universal API to request a channel".

param field of struct dma_slave_map type entries in the platform
data structure should be pointing to struct pl08x_channel_data
of related DMA channel.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/dma/amba-pl08x.c   | 11 +++++++++++
 include/linux/amba/pl08x.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 939a7c3..0b7c6ce 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1793,6 +1793,13 @@ bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
 }
 EXPORT_SYMBOL_GPL(pl08x_filter_id);
 
+static bool pl08x_filter_fn(struct dma_chan *chan, void *chan_id)
+{
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+
+	return plchan->cd == chan_id;
+}
+
 /*
  * Just check that the device is there and active
  * TODO: turn this bit on/off depending on the number of physical channels
@@ -2307,6 +2314,10 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 			ret = -EINVAL;
 			goto out_no_platdata;
 		}
+	} else {
+		pl08x->slave.filter.map = pl08x->pd->slave_map;
+		pl08x->slave.filter.mapcnt = pl08x->pd->slave_map_len;
+		pl08x->slave.filter.fn = pl08x_filter_fn;
 	}
 
 	/* By default, AHB1 only.  If dualmaster, from platform */
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 27e9ec8..5308eae 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -84,6 +84,8 @@ struct pl08x_channel_data {
  * running any DMA transfer and multiplexing can be recycled
  * @lli_buses: buses which LLIs can be fetched from: PL08X_AHB1 | PL08X_AHB2
  * @mem_buses: buses which memory can be accessed from: PL08X_AHB1 | PL08X_AHB2
+ * @slave_map: DMA slave matching table
+ * @slave_map_len: number of elements in @slave_map
  */
 struct pl08x_platform_data {
 	struct pl08x_channel_data *slave_channels;
@@ -93,6 +95,8 @@ struct pl08x_platform_data {
 	void (*put_xfer_signal)(const struct pl08x_channel_data *, int);
 	u8 lli_buses;
 	u8 mem_buses;
+	const struct dma_slave_map *slave_map;
+	int slave_map_len;
 };
 
 #ifdef CONFIG_AMBA_PL08X
-- 
1.9.1
