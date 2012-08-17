From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 17 Aug 2012 16:35:18 +0200
Subject: [PATCH 2/8] UBI: separate bad_peb_limit in a function
In-Reply-To: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
References: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1345214124-5478-3-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional changes here, just to prepare for next patch.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/mtd/ubi/build.c |   57 ++++++++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 738772c..82d11e1 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -565,6 +565,37 @@ void ubi_free_internal_volumes(struct ubi_device *ubi)
 	}
 }
 
+static int get_bad_peb_limit(const struct ubi_device *ubi, int max_beb_per1024)
+{
+	int limit, device_pebs;
+	uint64_t device_size;
+
+	/*
+	 * We don't want a division by 0, and having max_beb_per1024 == 0 is ok
+	 */
+	if (!max_beb_per1024)
+		return 0;
+
+	/*
+	 * Here we are using size of the entire flash chip and
+	 * not just the MTD partition size because the maximum
+	 * number of bad eraseblocks is a percentage of the
+	 * whole device and bad eraseblocks are not fairly
+	 * distributed over the flash chip. So the worst case
+	 * is that all the bad eraseblocks of the chip are in
+	 * the MTD partition we are attaching (ubi->mtd).
+	 */
+	device_size = mtd_get_device_size(ubi->mtd);
+	device_pebs = mtd_div_by_eb(device_size, ubi->mtd);
+	limit = mult_frac(device_pebs, max_beb_per1024, 1024);
+
+	/* Round it up */
+	if (mult_frac(limit, 1024, max_beb_per1024) < device_pebs)
+		limit += 1;
+
+	return limit;
+}
+
 /**
  * io_init - initialize I/O sub-system for a given UBI device.
  * @ubi: UBI device description object
@@ -582,6 +613,8 @@ void ubi_free_internal_volumes(struct ubi_device *ubi)
  */
 static int io_init(struct ubi_device *ubi)
 {
+	const int max_beb_per1024 = CONFIG_MTD_UBI_BEB_LIMIT;
+
 	if (ubi->mtd->numeraseregions != 0) {
 		/*
 		 * Some flashes have several erase regions. Different regions
@@ -610,29 +643,7 @@ static int io_init(struct ubi_device *ubi)
 
 	if (mtd_can_have_bb(ubi->mtd)) {
 		ubi->bad_allowed = 1;
-		if (CONFIG_MTD_UBI_BEB_LIMIT > 0) {
-			int per1024 = CONFIG_MTD_UBI_BEB_LIMIT;
-			int limit, device_pebs;
-			uint64_t device_size;
-
-			/*
-			 * Here we are using size of the entire flash chip and
-			 * not just the MTD partition size because the maximum
-			 * number of bad eraseblocks is a percentage of the
-			 * whole device and bad eraseblocks are not fairly
-			 * distributed over the flash chip. So the worst case
-			 * is that all the bad eraseblocks of the chip are in
-			 * the MTD partition we are attaching (ubi->mtd).
-			 */
-			device_size = mtd_get_device_size(ubi->mtd);
-			device_pebs = mtd_div_by_eb(device_size, ubi->mtd);
-			limit = mult_frac(device_pebs, per1024, 1024);
-
-			/* Round it up */
-			if (mult_frac(limit, 1024, per1024) < device_pebs)
-				limit += 1;
-			ubi->bad_peb_limit = limit;
-		}
+		ubi->bad_peb_limit = get_bad_peb_limit(ubi, max_beb_per1024);
 	}
 
 	if (ubi->mtd->type == MTD_NORFLASH) {
-- 
1.7.2.5
