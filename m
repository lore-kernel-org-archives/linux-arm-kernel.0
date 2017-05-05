From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:57:45 +0200
Subject: [PATCH 02/10] dma: mv_xor_v2: properly handle wrapping in the array
 of HW descriptors
In-Reply-To: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493978274-12805-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mv_xor_v2_tasklet() is looping over completed HW descriptors. Before the
loop, it initializes 'next_pending_hw_desc' to the first HW descriptor
to handle, and then the loop simply increments this point, without
taking care of wrapping when we reach the last HW descriptor. The
'pending_ptr' index was being wrapped back to 0 at the end, but it
wasn't used in each iteration of the loop to calculate
next_pending_hw_desc.

This commit fixes that, and makes next_pending_hw_desc a variable local
to the loop itself.

Fixes: 19a340b1a820 ("dmaengine: mv_xor_v2: new driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor_v2.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index e928020..bdfb36e 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -560,7 +560,6 @@ static void mv_xor_v2_tasklet(unsigned long data)
 {
 	struct mv_xor_v2_device *xor_dev = (struct mv_xor_v2_device *) data;
 	int pending_ptr, num_of_pending, i;
-	struct mv_xor_v2_descriptor *next_pending_hw_desc = NULL;
 	struct mv_xor_v2_sw_desc *next_pending_sw_desc = NULL;
 
 	dev_dbg(xor_dev->dmadev.dev, "%s %d\n", __func__, __LINE__);
@@ -568,17 +567,10 @@ static void mv_xor_v2_tasklet(unsigned long data)
 	/* get the pending descriptors parameters */
 	num_of_pending = mv_xor_v2_get_pending_params(xor_dev, &pending_ptr);
 
-	/* next HW descriptor */
-	next_pending_hw_desc = xor_dev->hw_desq_virt + pending_ptr;
-
 	/* loop over free descriptors */
 	for (i = 0; i < num_of_pending; i++) {
-
-		if (pending_ptr > MV_XOR_V2_DESC_NUM)
-			pending_ptr = 0;
-
-		if (next_pending_sw_desc != NULL)
-			next_pending_hw_desc++;
+		struct mv_xor_v2_descriptor *next_pending_hw_desc =
+			xor_dev->hw_desq_virt + pending_ptr;
 
 		/* get the SW descriptor related to the HW descriptor */
 		next_pending_sw_desc =
@@ -614,6 +606,8 @@ static void mv_xor_v2_tasklet(unsigned long data)
 
 		/* increment the next descriptor */
 		pending_ptr++;
+		if (pending_ptr >= MV_XOR_V2_DESC_NUM)
+			pending_ptr = 0;
 	}
 
 	if (num_of_pending != 0) {
-- 
2.7.4
