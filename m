From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:18 +0530
Subject: [PATCH V2 05/13] dw_dmac: Adding support for 64 bit access width for
	memcpy xfers
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <42625509e43721a26cc70e9f5fe16d0b93ebff84.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 2b0d5e9..e5d97bf 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -583,7 +583,9 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	 * We can be a lot more clever here, but this should take care
 	 * of the most common optimization.
 	 */
-	if (!((src | dest  | len) & 3))
+	if (!((src | dest  | len) & 7))
+		src_width = dst_width = 3;
+	else if (!((src | dest  | len) & 3))
 		src_width = dst_width = 2;
 	else if (!((src | dest | len) & 1))
 		src_width = dst_width = 1;
-- 
1.7.2.2
