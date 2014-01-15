From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 15 Jan 2014 21:26:22 +0900
Subject: [PATCH 04/04] ARM: shmobile: r8a7790 CCI configuration
In-Reply-To: <20140115122539.9437.63968.sendpatchset@w520>
References: <20140115122539.9437.63968.sendpatchset@w520>
Message-ID: <20140115122622.9437.27236.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Add the settings of CCI-400 for enabling ca15/ca7 snoop on r8a7790.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7790.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- 0005/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-01-15 15:40:56.000000000 +0900
@@ -28,6 +28,11 @@
 #define CA15RESCNT	0x0040
 #define CA7RESCNT	0x0044
 #define MERAM		0xe8080000
+#define CCI_BASE	0xf0090000
+#define CCI_SLAVE3	0x4000
+#define CCI_SLAVE4	0x5000
+#define CCI_SNOOP	0x0000
+#define CCI_STATUS	0x000c
 
 static struct rcar_sysc_ch r8a7790_ca15_scu = {
 	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
@@ -71,6 +76,16 @@ static void __init r8a7790_smp_prepare_c
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
+	while (__raw_readl(p + CCI_STATUS));
+	/* wait for pending bit low */
+	iounmap(p);
 }
 
 struct smp_operations r8a7790_smp_ops __initdata = {
