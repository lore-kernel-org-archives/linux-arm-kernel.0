From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 26 Oct 2012 17:27:21 +0000 (UTC)
Subject: [PATCH] ARM: OMAP1: CGRM: fix omap1_get_reset_sources() return
 type
Message-ID: <alpine.DEB.2.00.1210261726430.5988@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


An older version of the patch "ARM: OMAP1: create read_reset_sources()
function (for initial use by watchdog)" was sent upstream, which used
the wrong return type for the omap1_get_reset_sources() function.
Fix it to return a u32, which is what the WDTIMER platform_data
function pointer read_reset_sources() expects.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/common.h |    2 +-
 arch/arm/mach-omap1/reset.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index d6ac18d..ecd0bb6 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -94,6 +94,6 @@ extern int ocpi_enable(void);
 static inline int ocpi_enable(void) { return 0; }
 #endif
 
-extern int omap1_get_reset_sources(void);
+extern u32 omap1_get_reset_sources(void);
 
 #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index a0a9f97..0df5536 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -43,7 +43,7 @@ void omap1_restart(char mode, const char *cmd)
  * Returns bits that represent the last reset source for the SoC.  The
  * format is standardized across OMAPs for use by the OMAP watchdog.
  */
-int omap1_get_reset_sources(void)
+u32 omap1_get_reset_sources(void)
 {
 	int ret = 0;
 	u16 rs;
-- 
1.7.10.4
