From: Zhuoyu.Zhang@freescale.com (Zhuoyu Zhang)
Date: Mon, 24 Nov 2014 13:28:10 +0800
Subject: [PATCH v2 2/2] arm: ls1: provide a workaround for core soft reset
In-Reply-To: <1416806890-26920-1-git-send-email-Zhuoyu.Zhang@freescale.com>
References: <1416806890-26920-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Message-ID: <1416806890-26920-2-git-send-email-Zhuoyu.Zhang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>

Due to a hardware erratum, after core soft reset, core state machine
registers need to force release manually.

Signed-off-by: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>
---
 arch/arm/mach-imx/platsmp.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7735ebb..73c2289 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -41,6 +41,7 @@ u32 g_diag_reg;
 static void __iomem *scu_base;
 static void __iomem *dcfg_base;
 static void __iomem *scfg_base;
+static void __iomem *dcsr_rcpm2_base;
 static u32 secondary_pre_boot_entry;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -150,8 +151,25 @@ static int ls1021a_secondary_iomap(void)
 		goto scfg_err;
 	}
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcsr-rcpm");
+	if (!np) {
+		pr_err("%s: failed to find dcsr node.\n", __func__);
+		ret = -EINVAL;
+		goto dcsr_err;
+	}
+
+	dcsr_rcpm2_base = of_iomap(np, 1);
+	of_node_put(np);
+	if (!dcsr_rcpm2_base) {
+		pr_err("%s: failed to map dcsr.\n", __func__);
+		ret = -ENOMEM;
+		goto dcsr_err;
+	}
+
 	return 0;
 
+dcsr_err:
+	iounmap(scfg_base);
 scfg_err:
 	iounmap(dcfg_base);
 dcfg_err:
@@ -176,7 +194,7 @@ static int ls1021a_reset_secondary(unsigned int cpu)
 {
 	u32 tmp;
 
-	if (!scfg_base || !dcfg_base)
+	if (!scfg_base || !dcfg_base || !dcsr_rcpm2_base)
 		return -ENOMEM;
 
 	writel_relaxed(secondary_pre_boot_entry,
@@ -190,6 +208,15 @@ static int ls1021a_reset_secondary(unsigned int cpu)
 	iowrite32be(0x80000000, scfg_base + SCFG_CORESRENCR);
 	iowrite32be(0x80000000, scfg_base +
 				SCFG_CORE0_SFT_RST + STRIDE_4B * cpu);
+	mdelay(10);
+
+	/* LS1021a errata. after reset, core state machine registers
+	 * need to force release manually.
+	 */
+	iowrite32be(0x00000080, dcsr_rcpm2_base + DCSR_RCPM2_DEBUG1);
+	iowrite32be(0x00000080, dcsr_rcpm2_base + DCSR_RCPM2_DEBUG2);
+	iowrite32be(0, dcsr_rcpm2_base + DCSR_RCPM2_DEBUG1);
+	iowrite32be(0, dcsr_rcpm2_base + DCSR_RCPM2_DEBUG2);
 
 	/* Release secondary core */
 	iowrite32be(1 << cpu, dcfg_base + DCFG_CCSR_BRR);
-- 
2.1.0.27.g96db324
