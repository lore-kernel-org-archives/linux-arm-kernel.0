From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 8 Oct 2012 11:07:11 +0530
Subject: [PATCH v2 05/14] ARM: OMAP2+: onenand: connected soc info in pdata
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Message-ID: <6065bed749924f28a3d268145d1b7c980a3c97eb.1349672877.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

onenand driver needs to know whether soc is falling under
34xx family to properly handle onenand. But driver is not
supposed to do cpu_is_* check, hence educate platform data
with this information. Driver can make use of it to avoid
cpu_is_* check.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c              | 5 +++++
 include/linux/platform_data/mtd-onenand-omap2.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 544d501..f0b677a 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -409,6 +409,11 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
 	}
 
+	if (cpu_is_omap34xx())
+		gpmc_onenand_data->flags |= ONENAND_IN_OMAP34XX;
+	else
+		gpmc_onenand_data->flags &= ~ONENAND_IN_OMAP34XX;
+
 	err = gpmc_cs_request(gpmc_onenand_data->cs, ONENAND_IO_SIZE,
 				(unsigned long *)&gpmc_onenand_resource.start);
 	if (err < 0) {
diff --git a/include/linux/platform_data/mtd-onenand-omap2.h b/include/linux/platform_data/mtd-onenand-omap2.h
index 21bb0ff..ef9c60d 100644
--- a/include/linux/platform_data/mtd-onenand-omap2.h
+++ b/include/linux/platform_data/mtd-onenand-omap2.h
@@ -14,6 +14,7 @@
 
 #define ONENAND_SYNC_READ	(1 << 0)
 #define ONENAND_SYNC_READWRITE	(1 << 1)
+#define	ONENAND_IN_OMAP34XX	(1 << 2)
 
 struct omap_onenand_platform_data {
 	int			cs;
-- 
1.7.12
