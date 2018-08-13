From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Tue, 14 Aug 2018 00:34:45 +0200
Subject: [PATCH v3 4/7] mtd: rawnand: ams-delta: request data port GPIO
 resource
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
Message-ID: <20180813223448.21316-5-jmkrzyszt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Data port used by the driver is actually an OMAP MPUIO device, already
under control of gpio-omap driver.  For that reason we used to not
request the memory region of the port as that would fail because the
region is already busy.  Despite that, we are still accessing the port
by just ioremapping it and performing read/write operations.  Moreover,
we are doing that without any proteciton from other users legally
manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over functions
exposed by the gpio-omap driver.  Before that happens, already prevent
from other users accessing the port pins by requesting an array of its
GPIO descriptors.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/ams-delta.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 48233d638d2a..09d6901fc94d 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -161,6 +161,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct mtd_info *mtd;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
+	struct gpio_descs *data_gpiods;
 	int err = 0;
 
 	if (!res)
@@ -261,6 +262,13 @@ static int ams_delta_init(struct platform_device *pdev)
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
+	/* Request array of data pins, initialize them as input */
+	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(data_gpiods)) {
+		err = PTR_ERR(data_gpiods);
+		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
+		goto out_mtd;
+	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
-- 
2.16.4
