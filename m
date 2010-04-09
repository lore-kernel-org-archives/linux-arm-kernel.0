From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 Apr 2010 08:57:43 +0200
Subject: [PATCH 2/5] drivers: mtd: onenand: add allocation of the verify buffer
In-Reply-To: <1270796266-8272-1-git-send-email-m.szyprowski@samsung.com>
References: <1270796266-8272-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1270796266-8272-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This patch extends OneNAND core code with support for OneNAND verify
write check. This is done by allocating the buffer for verify read
directly from the core code.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mtd/onenand/onenand_base.c |   13 ++++++++++++-
 include/linux/mtd/onenand.h        |    3 +++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 1b26f50..045811f 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -3932,6 +3932,13 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 				__func__);
 			return -ENOMEM;
 		}
+#ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
+		this->verify_buf = kzalloc(mtd->writesize, GFP_KERNEL);
+		if (!this->verify_buf) {
+			kfree(this->page_buf);
+			return -ENOMEM;
+		}
+#endif
 		this->options |= ONENAND_PAGEBUF_ALLOC;
 	}
 	if (!this->oob_buf) {
@@ -4059,8 +4066,12 @@ void onenand_release(struct mtd_info *mtd)
 		kfree(this->bbm);
 	}
 	/* Buffers allocated by onenand_scan */
-	if (this->options & ONENAND_PAGEBUF_ALLOC)
+	if (this->options & ONENAND_PAGEBUF_ALLOC) {
 		kfree(this->page_buf);
+#ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
+		kfree(this->verify_buf);
+#endif
+	}
 	if (this->options & ONENAND_OOBBUF_ALLOC)
 		kfree(this->oob_buf);
 	kfree(mtd->eraseregions);
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index c9a3c35..9b43268 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -125,6 +125,9 @@ struct onenand_chip {
 	flstate_t		state;
 	unsigned char		*page_buf;
 	unsigned char		*oob_buf;
+#ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
+	unsigned char		*verify_buf;
+#endif
 
 	int			subpagesize;
 	struct nand_ecclayout	*ecclayout;
-- 
1.6.4
