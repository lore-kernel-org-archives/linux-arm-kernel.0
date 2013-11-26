From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:32:10 +0900
Subject: [PATCH RFC v2 08/17] ARM: shmobile: r8a7779: Add helper to read mode
 pins
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385451139-29686-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and use helper to read mode pins.
This will be re-used when moving marzen-reference to
the common clock framework.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c        | 11 ++---------
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7779.c        | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index b7ce0e7..decf122 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -25,6 +25,7 @@
 #include <linux/clkdev.h>
 #include <mach/clock.h>
 #include <mach/common.h>
+#include <mach/r8a7779.h>
 
 /*
  *		MD1 = 1			MD1 = 0
@@ -59,9 +60,6 @@
 #define MSTPCR6		IOMEM(0xffc80058)
 #define MSTPCR7		IOMEM(0xffc80040)
 
-#define MODEMR		0xffcc0020
-
-
 /* ioremap() through clock mapping mandatory to avoid
  * collision with ARM coherent DMA virtual memory range.
  */
@@ -213,14 +211,9 @@ static struct clk_lookup lookups[] = {
 
 void __init r8a7779_clock_init(void)
 {
-	void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
-	u32 mode;
+	u32 mode = r8a7779_read_mode_pins();
 	int k, ret = 0;
 
-	BUG_ON(!modemr);
-	mode = ioread32(modemr);
-	iounmap(modemr);
-
 	if (mode & MD(1)) {
 		plla_clk.rate = 1500000000;
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 5014145..bd66cd82 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -39,6 +39,7 @@ extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_init_late(void);
+extern u32 r8a7779_read_mode_pins(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 8f94531..4e3fbfb 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -874,6 +874,20 @@ void __init r8a7779_add_standard_devices_dt(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+#define MODEMR		0xffcc0020
+
+u32 __init r8a7779_read_mode_pins(void)
+{
+	void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
+	u32 mode;
+
+	BUG_ON(!modemr);
+	mode = ioread32(modemr);
+	iounmap(modemr);
+
+	return mode;
+}
+
 static const char *r8a7779_compat_dt[] __initdata = {
 	"renesas,r8a7779",
 	NULL,
-- 
1.8.4
