From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 28 Apr 2010 17:46:47 +0200
Subject: [PATCH 3/5] drivers: mtd: onenand: add new callback for bufferram read
In-Reply-To: <1272469609-21876-1-git-send-email-m.szyprowski@samsung.com>
References: <1272469609-21876-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1272469609-21876-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This patch adds a new callback for the underlying drivers, which is
called instead of accessing the buffer ram directly. This callback will
be used by Samsung OneNAND driver to implement DMA transfers on S5PC110
SoC.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mtd/onenand/onenand_base.c |    6 ++----
 include/linux/mtd/onenand.h        |    2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 045811f..9827ab7 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -1635,7 +1635,6 @@ static int onenand_verify_oob(struct mtd_info *mtd, const u_char *buf, loff_t to
 static int onenand_verify(struct mtd_info *mtd, const u_char *buf, loff_t addr, size_t len)
 {
 	struct onenand_chip *this = mtd->priv;
-	void __iomem *dataram;
 	int ret = 0;
 	int thislen, column;
 
@@ -1655,10 +1654,9 @@ static int onenand_verify(struct mtd_info *mtd, const u_char *buf, loff_t addr,
 
 		onenand_update_bufferram(mtd, addr, 1);
 
-		dataram = this->base + ONENAND_DATARAM;
-		dataram += onenand_bufferram_offset(mtd, ONENAND_DATARAM);
+		this->read_bufferram(mtd, ONENAND_DATARAM, this->verify_buf, 0, mtd->writesize);
 
-		if (memcmp(buf, dataram + column, thislen))
+		if (memcmp(buf, this->verify_buf, thislen))
 			return -EBADMSG;
 
 		len -= thislen;
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 9b43268..c26ff86 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -212,6 +212,8 @@ struct mtd_partition;
 
 struct onenand_platform_data {
 	void		(*mmcontrol)(struct mtd_info *mtd, int sync_read);
+	int		(*read_bufferram)(struct mtd_info *mtd, int area,
+			unsigned char *buffer, int offset, size_t count);
 	struct mtd_partition *parts;
 	unsigned int	nr_parts;
 };
-- 
1.6.4
