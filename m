From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 11:11:20 +0100
Subject: [PATCH] ARM: shmobile: rcar-gen2: Add more register documentation
In-Reply-To: <cover.1485425385.git.horms+renesas@verge.net.au>
References: <cover.1485425385.git.horms+renesas@verge.net.au>
Message-ID: <aa7f39d51e33555fc45645c08bc74a74e22b166f.1485425385.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 40 +++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index dd9ac366868f..0178da7ace82 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -20,14 +20,30 @@
 
 /* RST */
 #define RST		0xe6160000
-#define CA15BAR		0x0020
-#define CA7BAR		0x0030
-#define CA15RESCNT	0x0040
-#define CA7RESCNT	0x0044
+
+#define CA15BAR		0x0020		/* CA15 Boot Address Register */
+#define CA7BAR		0x0030		/* CA7 Boot Address Register */
+#define CA15RESCNT	0x0040		/* CA15 Reset Control Register */
+#define CA7RESCNT	0x0044		/* CA7 Reset Control Register */
+
+/* SYS Boot Address Register */
+#define SBAR_BAREN	BIT(4)		/* SBAR is valid */
+
+/* Reset Control Registers */
+#define CA15RESCNT_CODE	0xa5a50000
+#define CA15RESCNT_CPUS	0xf		/* CPU0-3 */
+#define CA7RESCNT_CODE	0x5a5a0000
+#define CA7RESCNT_CPUS	0xf		/* CPU0-3 */
+
 
 /* On-chip RAM */
 #define ICRAM1		0xe63c0000	/* Inter Connect RAM1 (4 KiB) */
 
+static inline u32 phys_to_sbar(phys_addr_t addr)
+{
+	return (addr >> 8) & 0xfffffc00;
+}
+
 /* SYSC */
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
@@ -82,22 +98,24 @@ void __init rcar_gen2_pm_init(void)
 
 	/* setup reset vectors */
 	p = ioremap_nocache(RST, 0x63);
-	bar = (boot_vector_addr >> 8) & 0xfffffc00;
+	bar = phys_to_sbar(boot_vector_addr);
 	if (has_a15) {
 		writel_relaxed(bar, p + CA15BAR);
-		writel_relaxed(bar | 0x10, p + CA15BAR);
+		writel_relaxed(bar | SBAR_BAREN, p + CA15BAR);
 
 		/* de-assert reset for CA15 CPUs */
-		writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) |
-				0xa5a50000, p + CA15RESCNT);
+		writel_relaxed((readl_relaxed(p + CA15RESCNT) &
+				~CA15RESCNT_CPUS) | CA15RESCNT_CODE,
+			       p + CA15RESCNT);
 	}
 	if (has_a7) {
 		writel_relaxed(bar, p + CA7BAR);
-		writel_relaxed(bar | 0x10, p + CA7BAR);
+		writel_relaxed(bar | SBAR_BAREN, p + CA7BAR);
 
 		/* de-assert reset for CA7 CPUs */
-		writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) |
-				0x5a5a0000, p + CA7RESCNT);
+		writel_relaxed((readl_relaxed(p + CA7RESCNT) &
+				~CA7RESCNT_CPUS) | CA7RESCNT_CODE,
+			       p + CA7RESCNT);
 	}
 	iounmap(p);
 
-- 
2.7.0.rc3.207.g0ac5344
