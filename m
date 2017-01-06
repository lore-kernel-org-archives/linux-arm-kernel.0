From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:56 +0100
Subject: [PATCH 1/5] ARM: shmobile: apmu: Add more register documentation
In-Reply-To: <cover.1483701101.git.horms+renesas@verge.net.au>
References: <cover.1483701101.git.horms+renesas@verge.net.au>
Message-ID: <460d4117a4714f3e9ae600974df03632139728ec.1483701101.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 0c6bb458b7a4..933f9b902405 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -31,9 +31,15 @@ static struct {
 	int bit;
 } apmu_cpus[NR_CPUS];
 
-#define WUPCR_OFFS 0x10
-#define PSTR_OFFS 0x40
-#define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
+#define WUPCR_OFFS	 0x10		/* Wake Up Control Register */
+#define PSTR_OFFS	 0x40		/* Power Status Register */
+#define CPUNCR_OFFS(n)	(0x100 + (0x10 * (n)))
+					/* CPUn Power Status Control Register */
+
+/* Power Status Register */
+#define CPUNST(r, n)	(((r) >> (n * 4)) & 3)	/* CPUn Status Bit */
+#define CPUST_RUN	0		/* Run Mode */
+#define CPUST_STANDBY	3		/* CoreStandby Mode */
 
 static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 {
@@ -59,7 +65,7 @@ static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
 	int k;
 
 	for (k = 0; k < 1000; k++) {
-		if (((readl_relaxed(p + PSTR_OFFS) >> (bit * 4)) & 0x03) == 3)
+		if (CPUNST(readl_relaxed(p + PSTR_OFFS), bit) == CPUST_STANDBY)
 			return 1;
 
 		mdelay(1);
-- 
2.7.0.rc3.207.g0ac5344
