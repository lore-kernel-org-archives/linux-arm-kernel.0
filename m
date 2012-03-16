From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 16 Mar 2012 14:49:54 +0200
Subject: [PATCH] OMAP: HSMMC: avoid erratum workaround when transceiver is
 attached
Message-ID: <1331902194-4679-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If transceiver is attached to a MMC host of ES2.1 OMAP, it seems
2.1.1.128 erratum doesn't apply and there is no data corruption,
probably because of different signal timing. The workaround for this
erratum disables multiblock reads, which causes dramatic loss of
performance (over 75% slower), so avoid it when transceiver is present.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 100db62..b0268ea 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -506,6 +506,13 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	if (oh->dev_attr != NULL) {
 		mmc_dev_attr = oh->dev_attr;
 		mmc_data->controller_flags = mmc_dev_attr->flags;
+		/*
+		 * erratum 2.1.1.128 doesn't apply if board has
+		 * a transceiver is attached
+		 */
+		if (hsmmcinfo->transceiver)
+			mmc_data->controller_flags &=
+				~OMAP_HSMMC_BROKEN_MULTIBLOCK_READ;
 	}
 
 	pdev = platform_device_alloc(name, ctrl_nr - 1);
-- 
1.7.0.4
