From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 4 Jun 2013 10:34:14 +0800
Subject: [PATCH 1/2] ARM:prima2: move sirfsoc_of_rstc_init to .init_machine
In-Reply-To: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
References: <1370313255-20396-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1370313255-20396-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves sirfsoc_of_rstc_init from early_initcall to .init_machine
in machine descriptor, doing this way a multi_v7 kernel will not crash
on non-prima2 SOCs.

Without this patch the multi_v7 kernel panics if we boot it on any non
prima2 parts with below log:

Kernel panic - not syncing: unable to find compatible rstc node in dtb

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-rc3-00535-gc3cc4ac #62
[<c001387c>] (unwind_backtrace+0x0/0xf8) from [<c00111cc>]
(show_stack+0x10/0x14)
[<c00111cc>] (show_stack+0x10/0x14) from [<c03417f4>] (panic+0x90/0x1e4)
[<c03417f4>] (panic+0x90/0x1e4) from [<c04256d0>]
(sirfsoc_of_rstc_init+0x24/0x5c)
[<c04256d0>] (sirfsoc_of_rstc_init+0x24/0x5c) from [<c041f854>]
(do_one_initcall+0x90/0x150)
[<c041f854>] (do_one_initcall+0x90/0x150) from [<c041f978>]
(kernel_init_freeable+0x64/0x1c4)
[<c041f978>] (kernel_init_freeable+0x64/0x1c4) from [<c033d344>]
(kernel_init+0x8/0xe4)
[<c033d344>] (kernel_init+0x8/0xe4) from [<c000ded8>]
(ret_from_fork+0x14/0x3c)

Initially detected when booting Stih415 SOC with multi_v7_defconfig.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.c | 10 ++++++++++
 arch/arm/mach-prima2/common.h |  1 +
 arch/arm/mach-prima2/rstc.c   |  5 +----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index e588c21..383aa41 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -17,6 +17,13 @@
 #include <linux/of_platform.h>
 #include "common.h"
 
+void __init sirfsoc_init_mach(void)
+{
+	sirfsoc_of_rstc_init();
+	of_platform_populate(NULL, of_default_bus_match_table,
+		NULL, NULL);
+}
+
 void __init sirfsoc_init_late(void)
 {
 	sirfsoc_pm_init();
@@ -47,6 +54,7 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
+	.init_machine	= sirfsoc_init_mach,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
 	.restart	= sirfsoc_restart,
@@ -65,6 +73,7 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
+	.init_machine   = sirfsoc_init_mach,
 	.dma_zone_size	= SZ_256M,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2_dt_match,
@@ -84,6 +93,7 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
 	.init_time	= sirfsoc_init_time,
+	.init_machine   = sirfsoc_init_mach,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
 	.restart	= sirfsoc_restart,
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 81135cd..095a16f 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -20,6 +20,7 @@ extern struct smp_operations   sirfsoc_smp_ops;
 extern void sirfsoc_secondary_startup(void);
 extern void sirfsoc_cpu_die(unsigned int cpu);
 
+extern void __init sirfsoc_of_rstc_init(void);
 extern void __init sirfsoc_of_irq_init(void);
 extern void __init sirfsoc_of_clk_init(void);
 extern void sirfsoc_restart(char, const char *);
diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 435019c..60fae92 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -23,7 +23,7 @@ static struct of_device_id rstc_ids[]  = {
 	{},
 };
 
-static int __init sirfsoc_of_rstc_init(void)
+void __init sirfsoc_of_rstc_init(void)
 {
 	struct device_node *np;
 
@@ -36,10 +36,7 @@ static int __init sirfsoc_of_rstc_init(void)
 		panic("unable to map rstc cpu registers\n");
 
 	of_node_put(np);
-
-	return 0;
 }
-early_initcall(sirfsoc_of_rstc_init);
 
 int sirfsoc_reset_device(struct device *dev)
 {
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
