From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 Jan 2014 13:46:55 +0000
Subject: [PATCH v4 12/37] mtd: st_spi_fsm: Fetch platform specific
 configurations
In-Reply-To: <1389188840-14306-1-git-send-email-lee.jones@linaro.org>
References: <1389188840-14306-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1389188840-14306-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All supported platforms are able to pass specific configurations via
the Device Tree on boot. Here we add a function which is to be called
during the probing process which will extract them, or make other
assumptions based on capabilities provided.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index efd8fdb..1803f94 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -654,6 +654,16 @@ static int stfsm_init(struct stfsm *fsm)
 	return 0;
 }
 
+static void stfsm_fetch_platform_configs(struct platform_device *pdev)
+{
+	struct stfsm *fsm = platform_get_drvdata(pdev);
+	struct flash_info *info = fsm->info;
+
+	/* Use device size to determine address width */
+	if (info->sector_size * info->n_sectors > 0xFFFFFF)
+		info->flags |= FLASH_FLAG_32BIT_ADDR;
+}
+
 static int stfsm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -712,6 +722,8 @@ static int stfsm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsm);
 
+	stfsm_fetch_platform_configs(pdev);
+
 	fsm->mtd.dev.parent	= &pdev->dev;
 	fsm->mtd.type		= MTD_NORFLASH;
 	fsm->mtd.writesize	= 4;
-- 
1.8.3.2
