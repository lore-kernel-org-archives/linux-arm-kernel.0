From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Sep 2016 10:32:48 +0200
Subject: [PATCH 4/9] mtd: nand: Add function to convert ONFI mode to
 data_interface
In-Reply-To: <1473928373-8680-1-git-send-email-s.hauer@pengutronix.de>
References: <1473928373-8680-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1473928373-8680-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

onfi_init_data_interface() initializes a data interface with
values from a given ONFI mode.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/nand_timings.c | 28 ++++++++++++++++++++++++++++
 include/linux/mtd/nand.h        |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/mtd/nand/nand_timings.c b/drivers/mtd/nand/nand_timings.c
index 9af2ebc..608d098 100644
--- a/drivers/mtd/nand/nand_timings.c
+++ b/drivers/mtd/nand/nand_timings.c
@@ -269,3 +269,31 @@ const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode)
 	return &onfi_sdr_timings[mode].timings.sdr;
 }
 EXPORT_SYMBOL(onfi_async_timing_mode_to_sdr_timings);
+
+/**
+ * onfi_init_data_interface - [NAND Interface] Initialize a data interface from
+ * given ONFI mode
+ * @iface: The data interface to be initialized
+ * @mode: The ONFI timing mode
+ */
+int onfi_init_data_interface(struct nand_chip *chip,
+			     struct nand_data_interface *iface,
+			     enum nand_data_interface_type type,
+			     int timing_mode)
+{
+	if (type != NAND_SDR_IFACE)
+		return -EINVAL;
+
+	if (timing_mode < 0 || timing_mode >= ARRAY_SIZE(onfi_sdr_timings))
+		return -EINVAL;
+
+	*iface = onfi_sdr_timings[timing_mode];
+
+	/*
+         * TODO: initialize timings that cannot be deduced from timing mode:
+         * tR, tPROG, tCCS, ...
+         * These information are part of the ONFI parameter page.
+         */
+
+	return 0;
+}
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index f305bed..7216f54 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -1104,6 +1104,11 @@ static inline int onfi_get_sync_timing_mode(struct nand_chip *chip)
 	return le16_to_cpu(chip->onfi_params.src_sync_timing_mode);
 }
 
+int onfi_init_data_interface(struct nand_chip *chip,
+			     struct nand_data_interface *iface,
+			     enum nand_data_interface_type type,
+			     int timing_mode);
+
 /*
  * Check if it is a SLC nand.
  * The !nand_is_slc() can be used to check the MLC/TLC nand chips.
-- 
2.8.1
