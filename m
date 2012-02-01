From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 1 Feb 2012 16:12:25 +0530
Subject: [PATCH V3 09/12] dmaengine/dw_dmac: Add 64 bit access width support
 for slave xfers on mem side
In-Reply-To: <cover.1328091915.git.viresh.kumar@st.com>
References: <cover.1328091915.git.viresh.kumar@st.com>
Message-ID: <85c11ca4e007a3c725724466f98e2159bbb6cf0a.1328091915.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

64 bit transfers are possible on both sides in slave transfers (memory as well
as peripherals). This patch adds support for it memory side 64 bit transfers.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 49d477c..44d8069 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -756,8 +756,14 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 			mem = sg_phys(sg);
 			len = sg_dma_len(sg);
-			mem_width = 2;
-			if (unlikely(mem & 3 || len & 3))
+
+			if (!((mem | len) & 7))
+				mem_width = 3;
+			else if (!((mem | len) & 3))
+				mem_width = 2;
+			else if (!((mem | len) & 1))
+				mem_width = 1;
+			else
 				mem_width = 0;
 
 slave_sg_todev_fill_desc:
@@ -814,8 +820,14 @@ slave_sg_todev_fill_desc:
 
 			mem = sg_phys(sg);
 			len = sg_dma_len(sg);
-			mem_width = 2;
-			if (unlikely(mem & 3 || len & 3))
+
+			if (!((mem | len) & 7))
+				mem_width = 3;
+			else if (!((mem | len) & 3))
+				mem_width = 2;
+			else if (!((mem | len) & 1))
+				mem_width = 1;
+			else
 				mem_width = 0;
 
 slave_sg_fromdev_fill_desc:
-- 
1.7.8.110.g4cb5d
