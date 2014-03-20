From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 09:20:46 +0000
Subject: [PATCH v6 14/36] mtd: st_spi_fsm: Fetch boot-device from mode pins
In-Reply-To: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395307268-12721-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's important for us to determine which device was used to boot from in
order to make some correct decisions surrounding Power Management. On
each of the platforms which support the FSM this is communicated via
a set of mode pins held in the system configuration area. This patch
determine the boot device and stores the result.

Acked-by Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 83cf9df..6be2672 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -14,7 +14,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mtd/mtd.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -207,6 +209,7 @@ struct stfsm {
 	struct flash_info       *info;
 
 	uint32_t                fifo_dir_delay;
+	bool                    booted_from_spi;
 };
 
 struct stfsm_seq {
@@ -692,6 +695,47 @@ static int stfsm_init(struct stfsm *fsm)
 	return 0;
 }
 
+static void stfsm_fetch_platform_configs(struct platform_device *pdev)
+{
+	struct stfsm *fsm = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *regmap;
+	uint32_t boot_device_reg;
+	uint32_t boot_device_spi;
+	uint32_t boot_device;     /* Value we read from *boot_device_reg */
+	int ret;
+
+	/* Booting from SPI NOR Flash is the default */
+	fsm->booted_from_spi = true;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(regmap))
+		goto boot_device_fail;
+
+	/* Where in the syscon the boot device information lives */
+	ret = of_property_read_u32(np, "st,boot-device-reg", &boot_device_reg);
+	if (ret)
+		goto boot_device_fail;
+
+	/* Boot device value when booted from SPI NOR */
+	ret = of_property_read_u32(np, "st,boot-device-spi", &boot_device_spi);
+	if (ret)
+		goto boot_device_fail;
+
+	ret = regmap_read(regmap, boot_device_reg, &boot_device);
+	if (ret)
+		goto boot_device_fail;
+
+	if (boot_device != boot_device_spi)
+		fsm->booted_from_spi = false;
+
+	return;
+
+boot_device_fail:
+	dev_warn(&pdev->dev,
+		 "failed to fetch boot device, assuming boot from SPI\n");
+}
+
 static int stfsm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -734,6 +778,8 @@ static int stfsm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	stfsm_fetch_platform_configs(pdev);
+
 	/* Detect SPI FLASH device */
 	info = stfsm_jedec_probe(fsm);
 	if (!info)
-- 
1.8.3.2
