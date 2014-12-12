From: b20788@freescale.com (Anson Huang)
Date: Fri, 12 Dec 2014 13:45:38 +0800
Subject: [PATCH] arm: imx: create temporary irq_desc of #32 irq for GPC
 operation
Message-ID: <1418363138-19805-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_get_irq_data may return NULL if irq_data is NOT ready,
it is fine for now because imx6q_set_lpm is called after all
irq_data is ready. But in linux-next branch where irq descriptor
alloc is moved to behind the imx6q_set_lpm called by
(9a1091e irqchip: gic: Support hierarchy irq domain), below crash
occurs, as all we need is a irq number passed to GPC module, rather
than making sure irq_data is ready before imx6q_set_lpm is called,
let's create a temporary variable of irq_desc for GPC to unmask/mask the
irq #32 we want, then below issue fixed.

[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[    0.000000] pgd = 80004000
[    0.000000] [00000004] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.18.0-rc7-next-20141204-dirty #854
[    0.000000] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    0.000000] task: 809882b0 ti: 8097c000 task.ti: 8097c000
[    0.000000] PC is at imx_gpc_irq_unmask+0x1c/0x70
[    0.000000] LR is at vprintk_emit+0x304/0x5fc
[    0.000000] pc : [<80026508>]    lr : [<8006b54c>]    psr: 600001d3
[    0.000000] sp : 8097dea8  ip : 8097de00  fp : 8097debc
[    0.000000] r10: c0818078  r9 : c0818074  r8 : c081807c
[    0.000000] r7 : 00000078  r6 : 809e5030  r5 : 00000000  r4 : 00000000
[    0.000000] r3 : 809882b0  r2 : 00000000  r1 : 8097dd70  r0 : 00000019
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387d  Table: 1000404a  DAC: 00000015
[    0.000000] Process swapper/0 (pid: 0, stack limit = 0x8097c238)
[    0.000000] Stack: (0x8097dea8 to 0x8097e000)
[    0.000000] dea0:                   00000000 00000000 8097dedc 8097dec0 8002747c 800264f8
[    0.000000] dec0: 809e4568 809e4568 80974198 809e4568 8097df6c 8097dee0 8093474c 80027418
[    0.000000] dee0: c0818060 00000018 00000000 8098b348 00000000 8098b348 0000001a be7d2bd0
[    0.000000] df00: c081803c c0818020 c0818024 c0818028 c0818034 c0818048 c0818060 c0818038
[    0.000000] df20: c081802c c0818068 c0818030 c0818014 c081801c c081806c c0818018 c0818080
[    0.000000] df40: 016e3600 00000001 be7d2bd0 be0027c0 00000000 809d3e2c 00000001 809d3d18
[    0.000000] df60: 8097dfa4 8097df70 8095c09c 80930fac 00000000 00000000 00000000 00000000
[    0.000000] df80: 00000001 809e3a40 ffffffff 8096a108 412fc09a befffa40 8097dfb4 8097dfa8
[    0.000000] dfa0: 809225fc 8095bfb4 8097dff4 8097dfb8 8091eb74 809225dc ffffffff ffffffff
[    0.000000] dfc0: 8091e6d0 00000000 00000000 8096a108 809e3cd4 8098496c 8096a104 809899fc
[    0.000000] dfe0: 1000406a 00000000 00000000 8097dff8 10008074 8091e930 00000000 00000000
[    0.000000] Backtrace:
[    0.000000] [<800264ec>] (imx_gpc_irq_unmask) from [<8002747c>] (imx6q_set_lpm+0x70/0x114)
[    0.000000]  r5:00000000 r4:00000000
[    0.000000] [<8002740c>] (imx6q_set_lpm) from [<8093474c>] (imx6q_clocks_init+0x37ac/0x37b4)
[    0.000000]  r7:809e4568 r6:80974198 r5:809e4568 r4:809e4568
[    0.000000] [<80930fa0>] (imx6q_clocks_init) from [<8095c09c>] (of_clk_init+0xf4/0x184)
[    0.000000]  r10:809d3d18 r9:00000001 r8:809d3e2c r7:00000000 r6:be0027c0 r5:be7d2bd0
[    0.000000]  r4:00000001
[    0.000000] [<8095bfa8>] (of_clk_init) from [<809225fc>] (time_init+0x2c/0x38)
[    0.000000]  r10:befffa40 r9:412fc09a r8:8096a108 r7:ffffffff r6:809e3a40 r5:00000001
[    0.000000]  r4:00000000
[    0.000000] [<809225d0>] (time_init) from [<8091eb74>] (start_kernel+0x250/0x3dc)
[    0.000000] [<8091e924>] (start_kernel) from [<10008074>] (0x10008074)
[    0.000000]  r10:00000000 r8:1000406a r7:809899fc r6:8096a104 r5:8098496c r4:809e3cd4
[    0.000000] Code: e1a04000 e1a01000 e59f004c eb1a63c7 (e5943004)
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/pm-imx6.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index c653dd4..05eff18 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -257,7 +257,10 @@ static void imx6q_enable_wb(bool enable)
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
-	struct irq_data *iomuxc_irq_data = irq_get_irq_data(32);
+	struct irq_data iomuxc_irq_data;
+
+	iomuxc_irq_data.irq = 32;
+
 	u32 val = readl_relaxed(ccm_base + CLPCR);
 
 	val &= ~BM_CLPCR_LPM;
@@ -312,9 +315,9 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	 * 3) Software should mask IRQ #32 right after CCM Low-Power mode
 	 *    is set (set bits 0-1 of CCM_CLPCR).
 	 */
-	imx_gpc_irq_unmask(iomuxc_irq_data);
+	imx_gpc_irq_unmask(&iomuxc_irq_data);
 	writel_relaxed(val, ccm_base + CLPCR);
-	imx_gpc_irq_mask(iomuxc_irq_data);
+	imx_gpc_irq_mask(&iomuxc_irq_data);
 
 	return 0;
 }
-- 
1.7.9.5
