From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 5 Aug 2011 15:32:33 +0530
Subject: [PATCH V3 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <cover.1312538034.git.viresh.kumar@st.com>
References: <cover.1312538034.git.viresh.kumar@st.com>
Message-ID: <7280d025e19b6b9eba91b5988c6c1f498c6ffbda.1312538034.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Insert notifiers for the runtime PM API. With this the runtime PM layer kicks in
to action where used.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/amba-pl08x.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index ead88c9..5dd97f4 100644
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
@@ -405,6 +406,7 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
 		return NULL;
 	}
 
+	pm_runtime_get_sync(&pl08x->adev->dev);
 	return ch;
 }
 
@@ -418,6 +420,8 @@ static inline void pl08x_put_phy_channel(struct pl08x_driver_data *pl08x,
 	/* Stop the channel and clear its interrupts */
 	pl08x_terminate_phy_chan(pl08x, ch);
 
+	pm_runtime_put(&pl08x->adev->dev);
+
 	/* Mark it as free */
 	ch->serving = NULL;
 	spin_unlock_irqrestore(&ch->lock, flags);
@@ -1855,6 +1859,9 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_pl08x;
 	}
 
+	pm_runtime_set_active(&adev->dev);
+	pm_runtime_enable(&adev->dev);
+
 	/* Initialize memcpy engine */
 	dma_cap_set(DMA_MEMCPY, pl08x->memcpy.cap_mask);
 	pl08x->memcpy.dev = &adev->dev;
@@ -1992,6 +1999,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_info(&pl08x->adev->dev, "DMA: PL%03x rev%u at 0x%08llx irq %d\n",
 		 amba_part(adev), amba_rev(adev),
 		 (unsigned long long)adev->res.start, adev->irq[0]);
+
+	pm_runtime_put(&adev->dev);
 	return 0;
 
 out_no_slave_reg:
@@ -2010,6 +2019,9 @@ out_no_ioremap:
 	dma_pool_destroy(pl08x->pool);
 out_no_lli_pool:
 out_no_platdata:
+	pm_runtime_put(&adev->dev);
+	pm_runtime_disable(&adev->dev);
+
 	kfree(pl08x);
 out_no_pl08x:
 	amba_release_regions(adev);
-- 
1.7.2.2
