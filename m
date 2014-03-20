From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 09:20:43 +0000
Subject: [PATCH v6 11/36] mtd: st_spi_fsm: Use device size to determine
 address width
In-Reply-To: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395307268-12721-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take some known parameters, namely size and number of sectors and use
them to determine weather a device can support 32bit addressing or not.
If it can, set the associated flash capability flag for latter use.

Acked-by Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 2740ae1..5a1b470 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -671,6 +671,10 @@ static int stfsm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	fsm->info = info;
 
+	/* Use device size to determine address width */
+	if (info->sector_size * info->n_sectors > 0x1000000)
+		info->flags |= FLASH_FLAG_32BIT_ADDR;
+
 	fsm->mtd.dev.parent	= &pdev->dev;
 	fsm->mtd.type		= MTD_NORFLASH;
 	fsm->mtd.writesize	= 4;
-- 
1.8.3.2
