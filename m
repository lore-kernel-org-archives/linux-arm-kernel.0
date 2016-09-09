From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  9 Sep 2016 14:05:08 +0200
Subject: [PATCH 5/9] mtd: nand: Expose data interface for ONFI mode 0
In-Reply-To: <1473422712-12359-1-git-send-email-s.hauer@pengutronix.de>
References: <1473422712-12359-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1473422712-12359-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nand layer will need ONFI mode 0 to use it as timing mode
before and right after reset.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/nand_timings.c | 11 +++++++++++
 include/linux/mtd/nand.h        |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mtd/nand/nand_timings.c b/drivers/mtd/nand/nand_timings.c
index ece4ff2..5217915 100644
--- a/drivers/mtd/nand/nand_timings.c
+++ b/drivers/mtd/nand/nand_timings.c
@@ -285,3 +285,14 @@ int onfi_init_data_interface(struct nand_data_interface *iface, int mode)
 
 	return 0;
 }
+
+/**
+ * nand_get_default_data_interface - [NAND Interface] Retrieve NAND
+ * data interface for mode 0. This is used as default timing after
+ * reset.
+ */
+const struct nand_data_interface *nand_get_default_data_interface(void)
+{
+	return &onfi_sdr_timings[0];
+}
+EXPORT_SYMBOL(nand_get_default_data_interface);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 0044fac..56787da 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -1143,6 +1143,8 @@ static inline int jedec_feature(struct nand_chip *chip)
 
 /* get timing characteristics from ONFI timing mode. */
 const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
+/* get data interface from ONFI timing mode 0, used after reset. */
+const struct nand_data_interface *nand_get_default_data_interface(void);
 
 int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
-- 
2.8.1
