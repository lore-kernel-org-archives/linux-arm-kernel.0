From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Oct 2016 17:50:15 -0200
Subject: [PATCH v2] ARM: imx: gpc: Initialize all power domains
In-Reply-To: <CAOMZO5Cjs5sPTQ4=w-hGS3dQ3LNPRfmbkGk6PTKhJDdXK5UYCQ@mail.gmail.com>
References: <1477013309-2808-1-git-send-email-festevam@gmail.com>
 <20161021031116.GG30578@tiger>
 <CAOMZO5Cjs5sPTQ4=w-hGS3dQ3LNPRfmbkGk6PTKhJDdXK5UYCQ@mail.gmail.com>
Message-ID: <CAOMZO5A5pVm6a2yC2mbZmuVujgVQWXDndKtqsp3y7S2OjwVrWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 5:18 PM, Fabio Estevam <festevam@gmail.com> wrote:

> imx_v6_v7_defconfig selects GPU and VPU drivers, which are consumers
> of the GPC driver and change the refcount of the pu_reg regulator.
>
> I think we should not continue to boot in case imx_gpc_probe() fails.
>
> So I will send a patch series with this patch and another one that
> prevents the boot when  imx_gpc_probe() fails.

So in addition to the original patch, I would like to add a second one
in the series to treat the imx_gpc_probe() case.

Option 1:

commit eb8aad1447e2227d5706dfa628bdb4c82381202e
Author: Fabio Estevam <festevam@gmail.com>
Date:   Fri Oct 21 11:31:06 2016 -0200

    ARM: imx: gpc: Fix the imx_gpc_genpd_init() error path

    If of_genpd_add_provider_onecell() fails the following kernel crash is
    observed on a kernel built with multi_v7_defconfig:

    [    1.723358] Unable to handle kernel NULL pointer dereference at
virtual address 00000040
    [    1.731500] pgd = c0204000
    [    1.731863] hctosys: unable to open rtc device (rtc0)
    [    1.739301] [00000040] *pgd=00000000
    [    1.739310] Internal error: Oops: 5 [#1] SMP ARM
    [    1.739319] Modules linked in:
    [    1.739328] CPU: 1 PID: 95 Comm: kworker/1:4 Not tainted
4.8.0-11897-g6b5e09a #1
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
    should unwind the previously actions, which in these case are:
    - Call imx6q_pm_pu_power_off()
    - Set imx6q_pu_domain.reg back to NULL

    Setting imx6q_pu_domain.reg to NULL in the error case is required
    as it will prevent further operations on the pu_reg regulator.

    This kernel crash is not observed with imx_v6_v7_defconfig because
    it selects GPU and VPU drivers, which are consumers of the GPC block.

    Signed-off-by: Fabio Estevam <festevam@gmail.com>

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index d0463e9..b54db47 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -408,7 +408,7 @@ static struct genpd_onecell_data imx_gpc_onecell_data = {
 static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 {
        struct clk *clk;
-       int i;
+       int i, ret;

        imx6q_pu_domain.reg = pu_reg;

@@ -432,12 +432,20 @@ static int imx_gpc_genpd_init(struct device
*dev, struct regulator *pu_reg)

        for (i = 0; i < ARRAY_SIZE(imx_gpc_domains); i++)
                pm_genpd_init(imx_gpc_domains[i], NULL, false);
-       return of_genpd_add_provider_onecell(dev->of_node,
+
+       ret =  of_genpd_add_provider_onecell(dev->of_node,
                                             &imx_gpc_onecell_data);
+       if (ret)
+               goto power_off;
+
+       return 0;

+power_off:
+       imx6q_pm_pu_power_off(&imx6q_pu_domain.base);
 clk_err:
        while (i--)
                clk_put(imx6q_pu_domain.clk[i]);
+       imx6q_pu_domain.reg = NULL;
        return -EINVAL;
 }

Or we can not even try to boot the kernel:

Option 2:

--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -459,7 +459,13 @@ static int imx_gpc_probe(struct platform_device *pdev)
                return ret;
        }

-       return imx_gpc_genpd_init(&pdev->dev, pu_reg);
+       ret = imx_gpc_genpd_init(&pdev->dev, pu_reg);
+       /*
+        * If imx_gpc_probe() fails we should better not continue
+        * to boot as the SoC may be in an impredictable state
+        */
+       BUG_ON(ret);
+       return ret;
 }

I am more inclined towards option 2, but would like to get some feedback first.
