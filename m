From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 26 Feb 2013 11:30:40 -0600
Subject: [PATCH 13/14] ARM: OMAP2+: Convert NAND to retrieve GPMC settings
 from DT
In-Reply-To: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1361899842-30303-14-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with device-tree, retrieve GPMC settings for NAND from
the device-tree blob. This will allow us to remove all static settings
stored in the gpmc-nand.c in the future once the migration to
device-tree is complete.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index a4c8537..e3d4b72 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -137,8 +137,11 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 			return err;
 		}
 
-		/* Enable RD PIN Monitoring Reg */
-		if (gpmc_nand_data->dev_ready) {
+		if (gpmc_nand_data->of_node) {
+			gpmc_read_settings_dt(gpmc_nand_data->of_node,
+					      &nand_settings);
+		} else if (gpmc_nand_data->dev_ready) {
+			/* Enable RD PIN Monitoring Reg */
 			nand_settings.wait_on_read = true;
 			nand_settings.wait_on_write = true;
 		}
-- 
1.7.10.4
