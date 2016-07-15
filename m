From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Fri, 15 Jul 2016 10:53:02 -0300
Subject: [PATCH] clk: imx7d: do not set the parent of IMX7D_ENET_AXI_ROOT_SRC
Message-ID: <1468590782-8436-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting the kernel on a imx7s-warp leads to several warnings like these:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:3536 lock_release+0x2f8/0x330
[    0.000000] releasing a pinned lock

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:2722 trace_hardirqs_on_caller+0x1ac/0x1f4
[    0.000000] DEBUG_LOCKS_WARN_ON(unlikely(early_boot_irqs_disabled))

[    0.000000] ---[ end trace cb88537fdc8fa201 ]---
[    0.000000] bad: scheduling from the idle thread!
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.7.0-rc7-next-20160715 #404

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:179 sched_clock_register+0x44/0x1f8
[    0.000000] Modules linked in:

[    0.000591] ------------[ cut here ]------------
[    0.000610] WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:179 sched_clock_register+0x44/0x1f8

[    0.002084] ------------[ cut here ]------------
[    0.002104] WARNING: CPU: 0 PID: 0 at init/main.c:576 start_kernel+0x258/0x3b0
[    0.002114] Interrupts were enabled early


This fix is along the same lines as 5e33ebff7edd ("clk: imx7d: do not
set parent of ethernet time/ref clocks") and the explanation from that
commit is:

"The reason for the warning is that setting the parent enables the ENET
 PLL since we are using CLK_OPS_PARENT_ENABLE. Enabling the ENET PLL can
 cause clk_pllv3_wait_lock to sleep. See also:
 commit fc8726a2c021 ("clk: core: support clocks which requires parents
 enable (part 2)")."

imx7s-warp does not even use the FEC interface, so we should not really
configure the parent of IMX7D_ENET_AXI_ROOT_SRC in the common MX7 clock
driver code.

The dts file should use the assigned-clocks/assigned-clock-parents method,
so simply remove the configuration of IMX7D_ENET_AXI_ROOT_SRC parent.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 6ed4f8f..9257972 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -860,8 +860,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
-	clk_set_parent(clks[IMX7D_ENET_AXI_ROOT_SRC], clks[IMX7D_PLL_ENET_MAIN_250M_CLK]);
-
 	/* set uart module clock's parent clock source that must be great then 80MHz */
 	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
-- 
1.9.1
