From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 27 Oct 2013 21:51:48 -0300
Subject: [PATCH 3/3] omap2: gpmc: Move legacy GPMC width setting
In-Reply-To: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1382921508-5104-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the introduction of gpmc_set_legacy(), move the GPMC width setting
to be done inside it. Currently, in the DT probed case, this is (wrongly)
done twice: first at gpmc_read_settings_dt(), and then based in the
NAND width setting.
Fix this and use only the value obtained from the DT.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 9dd40e7..174caec 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -74,6 +74,11 @@ static void gpmc_set_legacy(struct omap_nand_platform_data *gpmc_nand_data,
 		s->wait_on_read = true;
 		s->wait_on_write = true;
 	}
+
+	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
+		s->device_width = GPMC_DEVWIDTH_16BIT;
+	else
+		s->device_width = GPMC_DEVWIDTH_8BIT;
 }
 
 int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
@@ -118,11 +123,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 
 	s.device_nand = true;
 
-	if (gpmc_nand_data->devsize == NAND_BUSWIDTH_16)
-		s.device_width = GPMC_DEVWIDTH_16BIT;
-	else
-		s.device_width = GPMC_DEVWIDTH_8BIT;
-
 	err = gpmc_cs_program_settings(gpmc_nand_data->cs, &s);
 	if (err < 0)
 		goto out_free_cs;
-- 
1.8.1.5
