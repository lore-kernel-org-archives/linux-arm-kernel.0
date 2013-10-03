From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Thu,  3 Oct 2013 15:32:17 -0500
Subject: [PATCH] imx6q: fix emergency restart
Message-ID: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Emergency restart (e.g. sysrq-b) BUGs and panics on i.MX6Q SABRE Lite:

kernel BUG at mm/vmalloc.c:1305!
Internal error: Oops - BUG: 0 [#1] SMP ARM
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.12.0-rc3-00059-g522d6d3-dirty #29
task: c0cf15d8 ti: c0ce6000 task.ti: c0ce6000
PC is at __get_vm_area_node.isra.36+0xe8/0xf8
LR is at get_vm_area_caller+0x40/0x48
pc : [<c00be184>]    lr : [<c00bed1c>]    psr: 20000193
sp : c0ce7db8  ip : c0ce6000  fp : 00004000
r10: c0cf2ab0  r9 : 020bc000  r8 : f0000000
r7 : 00000001  r6 : 000000d0  r5 : 00000001  r4 : c0ce7db8
r3 : 00010000  r2 : 00000001  r1 : 00000001  r0 : 00004000
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 3eec404a  DAC: 00000015
Process swapper/0 (pid: 0, stack limit = 0xc0ce6240)
...
[<c00be184>] (__get_vm_area_node.isra.36+0xe8/0xf8) from [<c00bed1c>] (get_vm_area_caller+0x40/0x48)
[<c00bed1c>] (get_vm_area_caller+0x40/0x48) from [<c00177c8>] (__arm_ioremap_pfn_caller+0x118/0x198)
[<c00177c8>] (__arm_ioremap_pfn_caller+0x118/0x198) from [<c001789c>] (__arm_ioremap_caller+0x54/0x5c)
[<c001789c>] (__arm_ioremap_caller+0x54/0x5c) from [<c00178d4>] (__arm_ioremap+0x18/0x1c)
[<c00178d4>] (__arm_ioremap+0x18/0x1c) from [<c03a8ef8>] (of_iomap+0x2c/0x34)
[<c03a8ef8>] (of_iomap+0x2c/0x34) from [<c001f454>] (imx6q_restart+0x24/0xa4)
[<c001f454>] (imx6q_restart+0x24/0xa4) from [<c000f82c>] (machine_restart+0x38/0x68)
[<c000f82c>] (machine_restart+0x38/0x68) from [<c0243bb8>] (__handle_sysrq+0xb0/0x17c)
[<c0243bb8>] (__handle_sysrq+0xb0/0x17c) from [<c025ce28>] (imx_rxint+0x1f4/0x264)
[<c025ce28>] (imx_rxint+0x1f4/0x264) from [<c025cfac>] (imx_int+0x114/0x184)
[<c025cfac>] (imx_int+0x114/0x184) from [<c0078894>] (handle_irq_event_percpu+0x54/0x194)
[<c0078894>] (handle_irq_event_percpu+0x54/0x194) from [<c0078a18>] (handle_irq_event+0x44/0x64)
[<c0078a18>] (handle_irq_event+0x44/0x64) from [<c007b484>] (handle_fasteoi_irq+0x80/0x148)
[<c007b484>] (handle_fasteoi_irq+0x80/0x148) from [<c0078258>] (generic_handle_irq+0x20/0x30)
[<c0078258>] (generic_handle_irq+0x20/0x30) from [<c000f44c>] (handle_IRQ+0x40/0x90)
[<c000f44c>] (handle_IRQ+0x40/0x90) from [<c0008758>] (gic_handle_irq+0x2c/0x5c)
[<c0008758>] (gic_handle_irq+0x2c/0x5c) from [<c00124c0>] (__irq_svc+0x40/0x50)
Exception stack(0xc0ce7f78 to 0xc0ce7fc0)
7f60:                                                       c181f858 00000000
7f80: 00001760 c0019b60 c0ce6000 c0d799d5 c0cee480 c04a65f4 00000001 c0cee408
7fa0: c0d799d5 00000000 00000000 c0ce7fc0 c000f7ac c000f7b0 60000013 ffffffff
[<c00124c0>] (__irq_svc+0x40/0x50) from [<c000f7b0>] (arch_cpu_idle+0x38/0x3c)
[<c000f7b0>] (arch_cpu_idle+0x38/0x3c) from [<c0077fa8>] (cpu_startup_entry+0x6c/0x134)
[<c0077fa8>] (cpu_startup_entry+0x6c/0x134) from [<c062bab0>] (start_kernel+0x328/0x334)
Code: e1a07713 eaffffd7 e3a04000 eafffff1 (e7f001f2)
---[ end trace 532bdf165bd117ce ]---
Kernel panic - not syncing: Fatal exception in interrupt

Mapping the watchdog via of_iomap() in imx6q_restart() is okay during
normal shutdown, but this code runs in interrupt context in response
to sysrq-b, which triggers the BUG_ON in __get_vm_area_node().

Fix this by mapping the watchdog in imx6q_init_machine() and caching
the pointer for use by imx6q_restart().

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/mach-imx/mach-imx6q.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 90372a2..e16b723 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -41,6 +41,7 @@
 #include "hardware.h"
 
 static u32 chip_revision;
+static void __iomem *wdog_base;
 
 int imx6q_revision(void)
 {
@@ -70,11 +71,6 @@ static void __init imx6q_init_revision(void)
 
 static void imx6q_restart(enum reboot_mode mode, const char *cmd)
 {
-	struct device_node *np;
-	void __iomem *wdog_base;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
-	wdog_base = of_iomap(np, 0);
 	if (!wdog_base)
 		goto soft;
 
@@ -192,8 +188,15 @@ static void __init imx6q_1588_init(void)
 
 static void __init imx6q_init_machine(void)
 {
+	struct device_node *np;
+
 	imx6q_enet_phy_init();
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
+	if (np)
+		wdog_base = of_iomap(np, 0);
+	pr_info("%s: wdog_base = %p\n", __func__, wdog_base);
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	imx_anatop_init();
-- 
1.8.3.1
