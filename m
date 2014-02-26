From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:50 +0900
Subject: [PATCH 4/7] ARM: shmobile: r8a7790 CA7-SCU enablement
In-Reply-To: <cover.1393400446.git.horms+renesas@verge.net.au>
References: <cover.1393400446.git.horms+renesas@verge.net.au>
Message-ID: <0445ded61aac0c1a6f43b4be1a2ca2ca47b77eb8.1393400446.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Power on CA7 SCU in case of booting from a CA15 core.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
[damm at opensource.se: Converted to use broken out SYSC code]
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 015e275..beb47ae 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -19,6 +19,8 @@
 #include <linux/io.h>
 #include <asm/smp_plat.h>
 #include <mach/common.h>
+#include <mach/pm-rcar.h>
+#include <mach/r8a7790.h>
 
 #define RST		0xe6160000
 #define CA15BAR		0x0020
@@ -27,6 +29,11 @@
 #define CA7RESCNT	0x0044
 #define MERAM		0xe8080000
 
+static struct rcar_sysc_ch r8a7790_ca7_scu = {
+	.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
+	.isr_bit = 21, /* CA7-SCU */
+};
+
 static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 {
 	void __iomem *p;
@@ -54,6 +61,10 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 	writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) | 0x5a5a0000,
 		       p + CA7RESCNT);
 	iounmap(p);
+
+	/* turn on power to SCU */
+	r8a7790_pm_init();
+	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
 
 struct smp_operations r8a7790_smp_ops __initdata = {
-- 
1.8.5.2
