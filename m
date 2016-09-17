From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:12:56 +0200
Subject: [PATCH 06/24] ste_dma40: Replace four kzalloc() calls by kcalloc() in
 d40_hw_detect_init()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <4025bbbc-ea7f-3a02-3bd2-dd374720fe37@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 09:56:32 +0200

* The script "checkpatch.pl" can point information out like the following.

  WARNING: Prefer kcalloc over kzalloc with multiply

  Thus fix the affected source code places.

* Replace the specification of data types by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 57d87a8..b5d15a1 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3281,19 +3281,20 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		base->gen_dmac.init_reg_size = ARRAY_SIZE(dma_init_reg_v4a);
 	}
 
-	base->phy_res = kzalloc(num_phy_chans * sizeof(struct d40_phy_res),
+	base->phy_res = kcalloc(num_phy_chans,
+				sizeof(*base->phy_res),
 				GFP_KERNEL);
 	if (!base->phy_res)
 		goto failure;
 
-	base->lookup_phy_chans = kzalloc(num_phy_chans *
-					 sizeof(struct d40_chan *),
+	base->lookup_phy_chans = kcalloc(num_phy_chans,
+					 sizeof(*base->lookup_phy_chans),
 					 GFP_KERNEL);
 	if (!base->lookup_phy_chans)
 		goto failure;
 
-	base->lookup_log_chans = kzalloc(num_log_chans *
-					 sizeof(struct d40_chan *),
+	base->lookup_log_chans = kcalloc(num_log_chans,
+					 sizeof(*base->lookup_log_chans),
 					 GFP_KERNEL);
 	if (!base->lookup_log_chans)
 		goto failure;
@@ -3304,9 +3305,10 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	if (!base->reg_val_backup_chan)
 		goto failure;
 
-	base->lcla_pool.alloc_map =
-		kzalloc(num_phy_chans * sizeof(struct d40_desc *)
-			* D40_LCLA_LINK_PER_EVENT_GRP, GFP_KERNEL);
+	base->lcla_pool.alloc_map = kcalloc(num_phy_chans
+					    * D40_LCLA_LINK_PER_EVENT_GRP,
+					    sizeof(*base->lcla_pool.alloc_map),
+					    GFP_KERNEL);
 	if (!base->lcla_pool.alloc_map)
 		goto failure;
 
-- 
2.10.0
