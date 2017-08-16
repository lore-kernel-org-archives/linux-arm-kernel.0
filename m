From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 16 Aug 2017 10:45:24 -0700
Subject: [PATCH 2/3] w1: d1w: Provide callback for ds1wm read/write
In-Reply-To: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
References: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1502905525-5646-3-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shreesha Rajashekar <shreesha@broadcom.com>

DS1WM core registers are accessed by reading from and writing to a group of
registers in iproc SOC's.

By default the read and write function uses
__raw_readb() and __raw_writeb(), which wouldnt work for iproc.
hence modifying to provide callbacks for read and write functions.

Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/w1/masters/ds1wm.c | 18 ++++++++++++++++--
 include/linux/mfd/ds1wm.h  |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index fd2e9da..9fadc39 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -115,12 +115,26 @@ struct ds1wm_data {
 static inline void ds1wm_write_register(struct ds1wm_data *ds1wm_data, u32 reg,
 					u8 val)
 {
-	__raw_writeb(val, ds1wm_data->map + (reg << ds1wm_data->bus_shift));
+	struct device *dev = &ds1wm_data->pdev->dev;
+	struct ds1wm_driver_data *pdata = dev_get_platdata(dev);
+
+	if (pdata->write)
+		pdata->write(ds1wm_data->map, reg, val);
+	else
+		__raw_writeb(val, ds1wm_data->map +
+			(reg << ds1wm_data->bus_shift));
 }
 
 static inline u8 ds1wm_read_register(struct ds1wm_data *ds1wm_data, u32 reg)
 {
-	return __raw_readb(ds1wm_data->map + (reg << ds1wm_data->bus_shift));
+	struct device *dev = &ds1wm_data->pdev->dev;
+	struct ds1wm_driver_data *pdata = dev_get_platdata(dev);
+
+	if (pdata->read)
+		return pdata->read(ds1wm_data->map, reg);
+	else
+		return __raw_readb(ds1wm_data->map +
+				(reg << ds1wm_data->bus_shift));
 }
 
 
diff --git a/include/linux/mfd/ds1wm.h b/include/linux/mfd/ds1wm.h
index 38a372a..c2d41d3 100644
--- a/include/linux/mfd/ds1wm.h
+++ b/include/linux/mfd/ds1wm.h
@@ -10,4 +10,6 @@ struct ds1wm_driver_data {
 	/* ds1wm implements the precise timings of*/
 	/* a reset pulse/presence detect sequence.*/
 	unsigned int reset_recover_delay;
+	void (*write)(void __iomem *map, u32 reg, u8 val);
+	u8 (*read)(void __iomem *map, u32 reg);
 };
-- 
2.5.0
