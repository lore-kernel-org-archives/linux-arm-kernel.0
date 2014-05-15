From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:32:01 +0900
Subject: [PATCH v6 06/17] ARM: shmobile: r8a7779: Add helper to read mode pins
In-Reply-To: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153532-23675-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and use helper to read mode pins.
This will be re-used when moving marzen-reference to
the common clock framework.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

There seems to be some scope to share this code
with similar code in setup-rcar-gen2.c

v6
* As suggested by Geert Uytterhoeven
  - Cache result

v2 - v5
* No change
---
 arch/arm/mach-shmobile/clock-r8a7779.c        | 11 ++---------
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7779.c        | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index a13298b..e9d3348 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -25,6 +25,7 @@
 #include <linux/clkdev.h>
 #include <mach/clock.h>
 #include <mach/common.h>
+#include <mach/r8a7779.h>
 
 /*
  *		MD1 = 1			MD1 = 0
@@ -52,9 +53,6 @@
 #define MSTPCR3		IOMEM(0xffc8003c)
 #define MSTPSR1		IOMEM(0xffc80044)
 
-#define MODEMR		0xffcc0020
-
-
 /* ioremap() through clock mapping mandatory to avoid
  * collision with ARM coherent DMA virtual memory range.
  */
@@ -207,14 +205,9 @@ static struct clk_lookup lookups[] = {
 
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
index 88eecea..d5ba2d8 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -32,6 +32,7 @@ extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_init_late(void);
+extern u32 r8a7779_read_mode_pins(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index d197b5a..6d091bd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -762,6 +762,24 @@ void __init r8a7779_add_standard_devices_dt(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+#define MODEMR		0xffcc0020
+
+u32 __init r8a7779_read_mode_pins(void)
+{
+	static u32 mode;
+	static bool mode_valid;
+
+	if (!mode_valid) {
+		void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
+		BUG_ON(!modemr);
+		mode = ioread32(modemr);
+		iounmap(modemr);
+		mode_valid = true;
+	}
+
+	return mode;
+}
+
 static const char *r8a7779_compat_dt[] __initdata = {
 	"renesas,r8a7779",
 	NULL,
-- 
1.8.5.2
