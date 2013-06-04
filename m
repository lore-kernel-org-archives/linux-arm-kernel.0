From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 4 Jun 2013 10:34:15 +0800
Subject: [PATCH 2/2] ARM:prima2:drop postcore_initcalls in pm module
In-Reply-To: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
References: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1370313255-20396-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch drops all postcore_initcalls in pm module and move these
functions to sirfsoc_pm_init which is init_late of machine desc.
Without this patch a multi_v7 kernel panics if we boot it on any
non prima2 parts with below log:

Kernel panic - not syncing: unable to find compatible pwrc node in dtb

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-rc3-00536-ge2f1bc1 #63
[<c001387c>] (unwind_backtrace+0x0/0xf8) from [<c00111cc>]
(show_stack+0x10/0x14)
[<c00111cc>] (show_stack+0x10/0x14) from [<c0341834>] (panic+0x90/0x1e4)
[<c0341834>] (panic+0x90/0x1e4) from [<c0425784>]
(sirfsoc_of_pwrc_init+0x24/0x58)
[<c0425784>] (sirfsoc_of_pwrc_init+0x24/0x58) from [<c041f854>]
(do_one_initcall+0x90/0x150)
[<c041f854>] (do_one_initcall+0x90/0x150) from [<c041fa10>]
(kernel_init_freeable+0xfc/0x1c4)
[<c041fa10>] (kernel_init_freeable+0xfc/0x1c4) from [<c033d384>]
(kernel_init+0x8/0xe4)
[<c033d384>] (kernel_init+0x8/0xe4) from [<c000ded8>]
(ret_from_fork+0x14/0x3c)
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.10.0-rc3-00536-ge2f1bc1 #63
[<c001387c>] (unwind_backtrace+0x0/0xf8) from [<c00111cc>]
(show_stack+0x10/0x14)
[<c00111cc>] (show_stack+0x10/0x14) from [<c0012030>]
(handle_IPI+0xf8/0x12c)
[<c0012030>] (handle_IPI+0xf8/0x12c) from [<c0008600>]
(gic_handle_irq+0x54/0x5c)
[<c0008600>] (gic_handle_irq+0x54/0x5c) from [<c000da80>]
(__irq_svc+0x40/0x50)
Exception stack(0xef079fa0 to 0xef079fe8)
9fa0: c0ddd6d8 00000000 000002d2 00000000 ef078000 c04888f5 00000001
c04888f5
9fc0: c045c490 c045c42c c0348f38 00000000 01000000 ef079fe8 c000f018
c000f01c
9fe0: 60000113 ffffffff
[<c000da80>] (__irq_svc+0x40/0x50) from [<c000f01c>]
(arch_cpu_idle+0x28/0x30)
[<c000f01c>] (arch_cpu_idle+0x28/0x30) from [<c0051080>]
(cpu_startup_entry+0x60/0x130)
[<c0051080>] (cpu_startup_entry+0x60/0x130) from [<6033dfc4>]
(0x6033dfc4)

Initially detected when booting Stih415 SOC with multi_v7_defconfig.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/pm.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index f7e347e..d57a97f 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -80,23 +80,12 @@ static int sirfsoc_pm_enter(suspend_state_t state)
 	return 0;
 }
 
-static const struct platform_suspend_ops sirfsoc_pm_ops = {
-	.enter = sirfsoc_pm_enter,
-	.valid = suspend_valid_only_mem,
-};
-
-int __init sirfsoc_pm_init(void)
-{
-	suspend_set_ops(&sirfsoc_pm_ops);
-	return 0;
-}
-
 static const struct of_device_id pwrc_ids[] = {
 	{ .compatible = "sirf,prima2-pwrc" },
 	{}
 };
 
-static int __init sirfsoc_of_pwrc_init(void)
+static void __init sirfsoc_of_pwrc_init(void)
 {
 	struct device_node *np;
 
@@ -113,10 +102,7 @@ static int __init sirfsoc_of_pwrc_init(void)
 		panic("unable to find base address of pwrc node in dtb\n");
 
 	of_node_put(np);
-
-	return 0;
 }
-postcore_initcall(sirfsoc_of_pwrc_init);
 
 static const struct of_device_id memc_ids[] = {
 	{ .compatible = "sirf,prima2-memc" },
@@ -147,4 +133,22 @@ static int __init sirfsoc_memc_init(void)
 {
 	return platform_driver_register(&sirfsoc_memc_driver);
 }
-postcore_initcall(sirfsoc_memc_init);
+
+static const struct platform_suspend_ops sirfsoc_pm_ops = {
+	.enter = sirfsoc_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+int __init sirfsoc_pm_init(void)
+{
+	int ret;
+
+	sirfsoc_of_pwrc_init();
+
+	ret = sirfsoc_memc_init();
+	if (ret)
+		return ret;
+
+	suspend_set_ops(&sirfsoc_pm_ops);
+	return 0;
+}
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
