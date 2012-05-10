From: r.sricharan@ti.com (R Sricharan)
Date: Thu, 10 May 2012 22:36:55 +0530
Subject: [PATCH 4/4] ARM: OMAP: counter-32k: Select the CR register offset
 using the IP scheme.
In-Reply-To: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1336669615-16454-5-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP socs has a legacy and a highlander version of the
32k sync counter IP. The register offsets vary between the
highlander and the legacy scheme. So use the 'SCHEME'
bits(30-31) of the revision register to distinguish between
the two versions and choose the CR register offset accordingly.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/plat-omap/counter_32k.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index b2f634b..cbd939d 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -28,7 +28,10 @@
 #include <plat/clock.h>
 
 /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
-#define OMAP2_32KSYNCNT_CR_OFF		0x10
+#define OMAP2_32KSYNCNT_REV_OFF		0x0
+#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
+#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
+#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
 
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
@@ -83,9 +86,16 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	int ret;
 
 	/*
-	 * 32k sync Counter register offset is@0x10
+	 * 32k sync Counter IP register offsets vary between the
+	 * highlander version and the legacy ones.
+	 * The 'SCHEME' bits(30-31) of the revision register is used
+	 * to identify the version.
 	 */
-	sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF;
+	if (__raw_readl(vbase + OMAP2_32KSYNCNT_REV_OFF) &
+						OMAP2_32KSYNCNT_REV_SCHEME)
+		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_HIGH;
+	else
+		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
 
 	/*
 	 * 120000 rough estimate from the calculations in
-- 
1.7.1
