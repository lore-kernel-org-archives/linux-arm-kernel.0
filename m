From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 21:50:16 +0900
Subject: [PATCH 01/02] ARM: shmobile: Introduce r8a7790_read_mode_pins()
In-Reply-To: <20130709125007.4388.15701.sendpatchset@w520>
References: <20130709125007.4388.15701.sendpatchset@w520>
Message-ID: <20130709125016.4388.47414.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Break out the r8a7790 boot mode code into a separate
function so it can be shared by multiple users.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7790.c        |   11 ++---------
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        |   14 ++++++++++++++
 3 files changed, 19 insertions(+), 9 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7790.c
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2013-07-09 20:03:09.000000000 +0900
@@ -24,6 +24,7 @@
 #include <linux/clkdev.h>
 #include <mach/clock.h>
 #include <mach/common.h>
+#include <mach/r8a7790.h>
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
@@ -42,8 +43,6 @@
  *	see "p1 / 2" on R8A7790_CLOCK_ROOT() below
  */
 
-#define MD(nr)	(1 << nr)
-
 #define CPG_BASE 0xe6150000
 #define CPG_LEN 0x1000
 
@@ -53,7 +52,6 @@
 #define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
 
-#define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
 #define SD3CKCR		0xE615007C
@@ -288,14 +286,9 @@ static struct clk_lookup lookups[] = {
 
 void __init r8a7790_clock_init(void)
 {
-	void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
-	u32 mode;
+	u32 mode = r8a7790_read_mode_pins();
 	int k, ret = 0;
 
-	BUG_ON(!modemr);
-	mode = ioread32(modemr);
-	iounmap(modemr);
-
 	switch (mode & (MD(14) | MD(13))) {
 	case 0:
 		R8A7790_CLOCK_ROOT(15, &extal_clk, 172, 208, 106, 88);
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-07-09 20:02:34.000000000 +0900
@@ -8,4 +8,7 @@ void r8a7790_pinmux_init(void);
 void r8a7790_init_delay(void);
 void r8a7790_timer_init(void);
 
+#define MD(nr) BIT(nr)
+u32 r8a7790_read_mode_pins(void);
+
 #endif /* __ASM_R8A7790_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-07-09 19:59:37.000000000 +0900
@@ -201,6 +201,20 @@ void __init r8a7790_add_standard_devices
 	r8a7790_register_thermal();
 }
 
+#define MODEMR 0xe6160060
+
+u32 __init r8a7790_read_mode_pins(void)
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
 void __init r8a7790_timer_init(void)
 {
 	void __iomem *cntcr;
