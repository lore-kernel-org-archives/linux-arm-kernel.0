From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:23 +0900
Subject: [PATCH 13/17] ata: pata_samsung_cf: removes s5pc100 related ata codes
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-14-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes support for s5pc100 ata because of no more support
S5PC100 SoC in mainline.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tejun Heo <tj@kernel.org>

gpio: samsung: remove s5p64x0 related gpio codes

This patch removes gpio codes for s5p6440 and s5p6450 SoCs.
---
 drivers/ata/pata_samsung_cf.c                |   13 -------------
 include/linux/platform_data/ata-samsung_cf.h |    1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index fb52883..2578fc1 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -54,7 +54,6 @@
 
 enum s3c_cpu_type {
 	TYPE_S3C64XX,
-	TYPE_S5PC100,
 	TYPE_S5PV210,
 };
 
@@ -476,10 +475,6 @@ static void pata_s3c_hwinit(struct s3c_ide_info *info,
 		writel(0x1b, info->ide_addr + S3C_ATA_IRQ_MSK);
 		break;
 
-	case TYPE_S5PC100:
-		pata_s3c_cfg_mode(info->sfr_addr);
-		/* FALLTHROUGH */
-
 	case TYPE_S5PV210:
 		/* Configure as little endian */
 		pata_s3c_set_endian(info->ide_addr, 0);
@@ -549,11 +544,6 @@ static int __init pata_s3c_probe(struct platform_device *pdev)
 		info->sfr_addr = info->ide_addr + 0x1800;
 		info->ide_addr += 0x1900;
 		info->fifo_status_reg = 0x94;
-	} else if (cpu_type == TYPE_S5PC100) {
-		ap->ops = &pata_s5p_port_ops;
-		info->sfr_addr = info->ide_addr + 0x1800;
-		info->ide_addr += 0x1900;
-		info->fifo_status_reg = 0x84;
 	} else {
 		ap->ops = &pata_s5p_port_ops;
 		info->fifo_status_reg = 0x84;
@@ -653,9 +643,6 @@ static struct platform_device_id pata_s3c_driver_ids[] = {
 		.name		= "s3c64xx-pata",
 		.driver_data	= TYPE_S3C64XX,
 	}, {
-		.name		= "s5pc100-pata",
-		.driver_data	= TYPE_S5PC100,
-	}, {
 		.name		= "s5pv210-pata",
 		.driver_data	= TYPE_S5PV210,
 	},
diff --git a/include/linux/platform_data/ata-samsung_cf.h b/include/linux/platform_data/ata-samsung_cf.h
index c2049e3..748e716 100644
--- a/include/linux/platform_data/ata-samsung_cf.h
+++ b/include/linux/platform_data/ata-samsung_cf.h
@@ -29,7 +29,6 @@ extern void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata);
 
 /* architecture-specific IDE configuration */
 extern void s3c64xx_ide_setup_gpio(void);
-extern void s5pc100_ide_setup_gpio(void);
 extern void s5pv210_ide_setup_gpio(void);
 
 #endif /*__ATA_SAMSUNG_CF_H */
-- 
1.7.10.4
