From: gaku.inami.xw@bp.renesas.com (Gaku Inami)
Date: Tue, 25 Nov 2014 17:25:51 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7790 CCI configuration
Message-ID: <54743D0F.5080307@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the settings of CCI-400 for enabling ca15/ca7 snoop on r8a7790.
Needed to configure the CCI boot cluster port regardless of MCPM.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---

Changes since version 1:
- Fix a way to wait for the register read.

 arch/arm/mach-shmobile/smp-r8a7790.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 9c3da13..b65d908 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -25,6 +25,12 @@
 #include "pm-rcar.h"
 #include "r8a7790.h"
 
+#define CCI_BASE	0xf0090000
+#define CCI_SLAVE3	0x4000
+#define CCI_SLAVE4	0x5000
+#define CCI_SNOOP	0x0000
+#define CCI_STATUS	0x000c
+
 static struct rcar_sysc_ch r8a7790_ca15_scu = {
 	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
 	.isr_bit = 12, /* CA15-SCU */
@@ -48,6 +54,8 @@ static struct rcar_apmu_config r8a7790_apmu_config[] = {
 
 static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 {
+	void __iomem *p;
+
 	/* let APMU code install data related to shmobile_boot_vector */
 	shmobile_smp_apmu_prepare_cpus(max_cpus,
 				       r8a7790_apmu_config,
@@ -57,6 +65,17 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 	r8a7790_pm_init();
 	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
+
+	/* enable snoop and DVM */
+	p = ioremap_nocache(CCI_BASE, 0x8000);
+	writel_relaxed(readl_relaxed(p + CCI_SLAVE3 + CCI_SNOOP) | 0x3,
+		p + CCI_SLAVE3 + CCI_SNOOP);    /* ca15 */
+	writel_relaxed(readl_relaxed(p + CCI_SLAVE4 + CCI_SNOOP) | 0x3,
+		p + CCI_SLAVE4 + CCI_SNOOP);    /* ca7 */
+	while (readl_relaxed(p + CCI_STATUS))
+		cpu_relax();
+	/* wait for pending bit low */
+	iounmap(p);
 }
 
 struct smp_operations r8a7790_smp_ops __initdata = {
-- 
1.7.9.5
