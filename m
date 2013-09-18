From: nm@ti.com (Nishanth Menon)
Date: Wed, 18 Sep 2013 09:05:42 -0500
Subject: [PATCH] ARM: OMAP5: id: Remove ES1.0 support
In-Reply-To: <5239AE35.8030406@ti.com>
References: <5239AE35.8030406@ti.com>
Message-ID: <1379513142-11125-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 ES1.0 was intended as a test chip and has major register level
differences w.r.t ES2.0 revision of the chip. All register defines,
dts support has been solely added for ES2.0 version of the chip.
Further, all ES1.0 chips and platforms are supposed to have been
removed from circulation. Hence, there is no need to further retain
any resemblence of ES1.0 support in id detection code.

Remove the omap_revision handling and BUG() instead to prevent folks
who mistakenly try an older unsupported chip and report bogus errors.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
ref: http://marc.info/?l=linux-omap&m=137951198232339&w=2
based on 3.12-rc1 tag

 arch/arm/mach-omap2/id.c  |    8 ++++----
 arch/arm/mach-omap2/soc.h |    2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 0289adc..4f8f1cb 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -576,8 +576,8 @@ void __init omap5xxx_check_revision(void)
 	case 0xb942:
 		switch (rev) {
 		case 0:
-			omap_revision = OMAP5430_REV_ES1_0;
-			break;
+			/* No support for ES1.0 Test chip */
+			BUG();
 		case 1:
 		default:
 			omap_revision = OMAP5430_REV_ES2_0;
@@ -587,8 +587,8 @@ void __init omap5xxx_check_revision(void)
 	case 0xb998:
 		switch (rev) {
 		case 0:
-			omap_revision = OMAP5432_REV_ES1_0;
-			break;
+			/* No support for ES1.0 Test chip */
+			BUG();
 		case 1:
 		default:
 			omap_revision = OMAP5432_REV_ES2_0;
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 4588df1..076bd90 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -455,9 +455,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP4470_REV_ES1_0	(OMAP447X_CLASS | (0x10 << 8))
 
 #define OMAP54XX_CLASS		0x54000054
-#define OMAP5430_REV_ES1_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x10 << 8))
 #define OMAP5430_REV_ES2_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x20 << 8))
-#define OMAP5432_REV_ES1_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x10 << 8))
 #define OMAP5432_REV_ES2_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x20 << 8))
 
 void omap2xxx_check_revision(void);
-- 
1.7.9.5
