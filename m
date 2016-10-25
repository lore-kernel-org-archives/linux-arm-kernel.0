From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 25 Oct 2016 10:34:38 -0700
Subject: [PATCH] ARM: imx6: Fix GPC probe error path
Message-ID: <1477416878-30353-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPC may fail to instantiate with

imx-gpc: probe of 20dc000.gpc failed with error -22

which is returned from of_genpd_add_provider_onecell(). The error path
does not call pm_genpd_remove(). This results in the following crash
later on.

Unhandled fault: page domain fault (0x01b) at 0x00000040
pgd = c0204000
[00000040] *pgd=00000000
Internal error: : 1b [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 108 Comm: kworker/0:3 Not tainted 4.9.0-rc2 #8
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Workqueue: pm genpd_power_off_work_fn
task: c759ea00 task.stack: c766a000
PC is at mutex_lock+0xc/0x4c
LR is at regulator_disable+0x28/0x64
...
[<c0bc2694>] (mutex_lock) from [<c06e4e8c>] (regulator_disable+0x28/0x64)
[<c06e4e8c>] (regulator_disable) from [<c0323b68>] (imx6q_pm_pu_power_off+0x90/0x98)
[<c0323b68>] (imx6q_pm_pu_power_off) from [<c07efb04>] (genpd_poweroff+0x114/0x1d4)
[<c07efb04>] (genpd_poweroff) from [<c07efdc0>] (genpd_power_off_work_fn+0x20/0x2c)
[<c07efdc0>] (genpd_power_off_work_fn) from [<c0358f70>] (process_one_work+0x138/0x34c)
[<c0358f70>] (process_one_work) from [<c03591bc>] (worker_thread+0x38/0x510)
[<c03591bc>] (worker_thread) from [<c035e48c>] (kthread+0xdc/0xf4)
[<c035e48c>] (kthread) from [<c0307eb8>] (ret_from_fork+0x14/0x3c)

This is seen with multi_v7_defconfig and imx6dl-sabrelite.dtb running in
qemu (v2.7 patched to fix a qemu related problem). The error return from
of_genpd_add_provider_onecell() is not seen in v4.8 and may be caused by
a devicetree change (this is a wild guess only), but that is a different
problem.

Fixes: 00eb60a8b4f7 ("ARM: imx6: gpc: Add PU power domain for GPU/VPU")
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Several bisect attempts trying to track down "imx-gpc: probe ... failed
with error -22" point to commit 00e729c93395 ("Merge tag 'armsoc-dt' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc"). I have not
been able to track down the real culprit. Part of the problem is that
CONFIG_REGULATOR_ANATOP must be enabled for the problem to be seen, and
CONFIG_ARCH_AT91 causes compile errors for some sequence of commits between
v4.8 and v4.9-rc1. But even after taking this into account, the bisect
results always point to 00e729c93395. If anyone has an idea how to track
down that problem, or what might be causing it, please let me know.

 arch/arm/mach-imx/gpc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 0df062d8b2c9..f3f40045b4c9 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -409,6 +409,7 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 {
 	struct clk *clk;
 	int i;
+	int ret;
 
 	imx6q_pu_domain.reg = pu_reg;
 
@@ -431,9 +432,14 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 		return 0;
 
 	pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
-	return of_genpd_add_provider_onecell(dev->of_node,
-					     &imx_gpc_onecell_data);
+	ret = of_genpd_add_provider_onecell(dev->of_node,
+					    &imx_gpc_onecell_data);
+	if (ret)
+		goto genpd_remove;
+	return 0;
 
+genpd_remove:
+	pm_genpd_remove(&imx6q_pu_domain.base);
 clk_err:
 	while (i--)
 		clk_put(imx6q_pu_domain.clk[i]);
-- 
2.5.0
