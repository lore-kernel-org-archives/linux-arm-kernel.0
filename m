From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 15 Jan 2014 21:26:04 +0900
Subject: [PATCH 02/04] ARM: shmobile: r8a7790 CA7-SCU enablement
In-Reply-To: <20140115122539.9437.63968.sendpatchset@w520>
References: <20140115122539.9437.63968.sendpatchset@w520>
Message-ID: <20140115122604.9437.98423.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Power on CA7 SCU in case of booting from a CA15 core.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
[damm at opensource.se: Converted to use broken out SYSC code]
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7790.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0001/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-01-15 14:34:03.000000000 +0900
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
@@ -54,6 +61,10 @@ static void __init r8a7790_smp_prepare_c
 	writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) | 0x5a5a0000,
 		       p + CA7RESCNT);
 	iounmap(p);
+
+	/* turn on power to SCU */
+	r8a7790_pm_init();
+	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
 
 struct smp_operations r8a7790_smp_ops __initdata = {
