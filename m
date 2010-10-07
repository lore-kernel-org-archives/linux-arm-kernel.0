From: x0132446@ti.com (David Anders)
Date: Thu,  7 Oct 2010 14:36:29 -0500
Subject: [PATCH 2/3] omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is
	not set
In-Reply-To: <1286480190-20632-1-git-send-email-x0132446@ti.com>
References: <1286480190-20632-1-git-send-email-x0132446@ti.com>
Message-ID: <1286480190-20632-3-git-send-email-x0132446@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid possible crash if CONFIG_MMC_OMAP_HS is not set.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index dc16884..9327ad4 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -116,7 +116,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 
 static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
 {
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
+	struct omap_mmc_platform_data *pdata;
+
+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev) {
+		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
+		return;
+	}
+	pdata = dev->platform_data;
 
 	pdata->init =	omap4_twl6030_hsmmc_late_init;
 }
-- 
1.7.0.4
