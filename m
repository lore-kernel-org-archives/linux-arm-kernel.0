From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:57 +0100
Subject: [PATCH 2/5] ARM: shmobile: apmu: Add debug resource reset for
 secondary CPU boot
In-Reply-To: <cover.1483701101.git.horms+renesas@verge.net.au>
References: <cover.1483701101.git.horms+renesas@verge.net.au>
Message-ID: <10f778a97845e8b10af8878af99c9cfe6c31baf9.1483701101.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

In debug mode (MD21=1), reset requests derived from power-shutoff to the
AP-system CPU cores must be enabled before the AP-system CPU cores
resume from power-shutoff for the first time. Else resume may fail,
causing the system to hang during boot.

As setting these bits is a no-op in normal mode, there's no need to
check the actual state of MD21 first.

Inspired by CPU-specific patches in the BSP by Hisashi Nakamura
<hisashi.nakamura.ak@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 933f9b902405..7e4ca6788be5 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -35,12 +35,18 @@ static struct {
 #define PSTR_OFFS	 0x40		/* Power Status Register */
 #define CPUNCR_OFFS(n)	(0x100 + (0x10 * (n)))
 					/* CPUn Power Status Control Register */
+#define DBGRCR_OFFS	0x180		/* Debug Resource Reset Control Reg. */
 
 /* Power Status Register */
 #define CPUNST(r, n)	(((r) >> (n * 4)) & 3)	/* CPUn Status Bit */
 #define CPUST_RUN	0		/* Run Mode */
 #define CPUST_STANDBY	3		/* CoreStandby Mode */
 
+/* Debug Resource Reset Control Register */
+#define DBGCPUREN	BIT(24)		/* CPU Other Reset Request Enable */
+#define DBGCPUNREN(n)	BIT((n) + 20)	/* CPUn Reset Request Enable */
+#define DBGCPUPREN	BIT(19)		/* CPU Peripheral Reset Req. Enable */
+
 static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 {
 	/* request power on */
@@ -84,6 +90,8 @@ static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu)
 #ifdef CONFIG_SMP
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
+	u32 x;
+
 	if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
 		return;
 
@@ -91,6 +99,11 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 	apmu_cpus[cpu].bit = bit;
 
 	pr_debug("apmu ioremap %d %d %pr\n", cpu, bit, res);
+
+	/* Setup for debug mode */
+	x = readl(apmu_cpus[cpu].iomem + DBGRCR_OFFS);
+	x |= DBGCPUREN | DBGCPUNREN(bit) | DBGCPUPREN;
+	writel(x, apmu_cpus[cpu].iomem + DBGRCR_OFFS);
 }
 
 static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
-- 
2.7.0.rc3.207.g0ac5344
