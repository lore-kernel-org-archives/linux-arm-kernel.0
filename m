From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 1 Aug 2011 15:07:18 +0530
Subject: [PATCH V2 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <cover.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
Message-ID: <bc59bbd3709a7af1723d37ab846bf44c6867c00e.1312190881.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Insert notifiers for the runtime PM API. With this the runtime PM layer kicks in
to action where used. This will also handle enabling/disabling of interface
clock (Code will be added in amba/bus.c by Russell King).

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/amba-pl08x.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 3fbaf0e..428a67b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -84,6 +84,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <asm/hardware/pl080.h>
@@ -879,11 +880,19 @@ static void pl08x_free_txd_list(struct pl08x_driver_data *pl08x,
  */
 static int pl08x_alloc_chan_resources(struct dma_chan *chan)
 {
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct pl08x_driver_data *pl08x = plchan->host;
+
+	pm_runtime_resume(&pl08x->adev->dev);
 	return 0;
 }
 
 static void pl08x_free_chan_resources(struct dma_chan *chan)
 {
+	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
+	struct pl08x_driver_data *pl08x = plchan->host;
+
+	pm_runtime_suspend(&pl08x->adev->dev);
 }
 
 /*
@@ -1993,6 +2002,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_info(&pl08x->adev->dev, "DMA: PL%03x rev%u at 0x%08llx irq %d\n",
 		 amba_part(adev), amba_rev(adev),
 		 (unsigned long long)adev->res.start, adev->irq[0]);
+
+	pm_runtime_suspend(&adev->dev);
 	return 0;
 
 out_no_slave_reg:
-- 
1.7.2.2
