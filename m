From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  1 Oct 2013 00:21:14 -0300
Subject: [PATCH 3/3] ARM: mach-imx: mm-imx5: Retrieve iomuxc base address from
 dt
In-Reply-To: <1380597674-31122-1-git-send-email-festevam@gmail.com>
References: <1380597674-31122-1-git-send-email-festevam@gmail.com>
Message-ID: <1380597674-31122-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

As mx53 is a dt-only SoC, we should retrieve the iomuxc base address from the 
device tree, instead of using the old MX53_IO_ADDRESS method.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx5.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index 2cafcf0..d1d5260 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -89,8 +89,15 @@ void __init imx51_init_early(void)
 
 void __init imx53_init_early(void)
 {
+	struct device_node *np;
+	void __iomem *base;
+
 	mxc_set_cpu_type(MXC_CPU_MX53);
-	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx53-iomuxc");
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+	mxc_iomux_v3_init(base);
 	imx_src_init();
 }
 
-- 
1.8.1.2
