From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Oct 2016 10:20:56 -0200
Subject: [PATCH v3 2/2] ARM: imx: gpc: Fix the imx_gpc_genpd_init() error path
In-Reply-To: <1477138856-31696-1-git-send-email-festevam@gmail.com>
References: <1477138856-31696-1-git-send-email-festevam@gmail.com>
Message-ID: <1477138856-31696-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

If of_genpd_add_provider_onecell() fails the following kernel crash is
observed on a kernel built with multi_v7_defconfig:

[    1.739301] [00000040] *pgd=00000000
[    1.739310] Internal error: Oops: 5 [#1] SMP ARM
[    1.739319] Modules linked in:
[    1.739328] CPU: 1 PID: 95 Comm: kworker/1:4 Not tainted 4.8.0-11897-g6b5e09a #1
[    1.739331] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    1.739352] Workqueue: pm genpd_power_off_work_fn
[    1.739356] task: ee63d400 task.stack: ee70a000
[    1.739365] PC is at mutex_lock+0xc/0x4c
[    1.739374] LR is at regulator_disable+0x2c/0x60
[    1.739379] pc : [<c0bc0da0>]    lr : [<c06e4b10>]    psr: 60000013
[    1.739379] sp : ee70beb0  ip : 10624dd3  fp : ee6e6280
[    1.739382] r10: eefb0900  r9 : 00000000  r8 : c1309918
[    1.739385] r7 : 00000000  r6 : 00000040  r5 : 00000000  r4 : 00000040
[    1.739390] r3 : 0000004c  r2 : 7fffd540  r1 : 000001e4  r0 : 00000040

Instead of returning of_genpd_add_provider_onecell() directly,
we should check its return value and in the case of error we
should unwind the previously taken actions, which in these case are:
- Call imx6q_pm_pu_power_off()
- Set imx6q_pu_domain.reg back to NULL

Setting imx6q_pu_domain.reg to NULL in the error case is important 
as it will prevent further operations in the pu_reg regulator.

This kernel crash is not observed with imx_v6_v7_defconfig because
it selects GPU and VPU drivers, which are consumers of the GPC block
and thus change the refcount of the pu_reg regulator.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- Newly introduced

 arch/arm/mach-imx/gpc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index d0463e9..b54db47 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -408,7 +408,7 @@ static struct genpd_onecell_data imx_gpc_onecell_data = {
 static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 {
 	struct clk *clk;
-	int i;
+	int i, ret;
 
 	imx6q_pu_domain.reg = pu_reg;
 
@@ -432,12 +432,20 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 
 	for (i = 0; i < ARRAY_SIZE(imx_gpc_domains); i++)
 		pm_genpd_init(imx_gpc_domains[i], NULL, false);
-	return of_genpd_add_provider_onecell(dev->of_node,
+
+	ret =  of_genpd_add_provider_onecell(dev->of_node,
 					     &imx_gpc_onecell_data);
+	if (ret)
+		goto power_off;
+
+	return 0;
 
+power_off:
+	imx6q_pm_pu_power_off(&imx6q_pu_domain.base);
 clk_err:
 	while (i--)
 		clk_put(imx6q_pu_domain.clk[i]);
+	imx6q_pu_domain.reg = NULL;
 	return -EINVAL;
 }
 
-- 
2.7.4
