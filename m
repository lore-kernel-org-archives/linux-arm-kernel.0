From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 17 Nov 2011 09:50:12 +0800
Subject: [RFC 1/1] ARM: imx6q: move clock register map to machine_desc.map_io
Message-ID: <1321494612-24795-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the map is in machine_desc.timer.init, the registers will not be
able to access after bootup (probably after "Freeing init memory").

Error log:
Freeing init memory: 112K
Unable to handle kernel paging request at virtual address f42c4024
pgd = ebb70000
[f42c4024] *pgd=3bff6841, *pte=00007911, *ppte=1393f240
Internal error: Oops: 27 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (3.2.0-rc1-00286-gd291ffb #77)
PC is at _clk_get_rate+0x4c/0x10c
LR is at clk_get_rate+0x40/0x50
pc : [<c0018798>]    lr : [<c00190a4>]    psr: 60000013
sp : ebb63d78  ip : c02f668c  fp : bee4da2c
r10: c042f54c  r9 : eb9e8400  r8 : 00000000
r7 : 00000000  r6 : eb921b60  r5 : 00000000  r4 : 0000003f
r3 : f42c4024  r2 : c041b4f0  r1 : c041a404  r0 : c041a404
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 3bb70059  DAC: 00000015
Process modprobe (pid: 273, stack limit = 0xebb622e8)
Stack: (0xebb63d78 to 0xebb64000)
3d60:                                                       c001874c eb921b60
3d80: eb9e8400 c00190a4 c0196fa8 c0196f48 c0196fa8 eb921b60 eb9e8400 c0196fb8
3da0: 00000000 00000000 eb9e8400 eb890150 eb9e8400 eb921b60 00000000 c0193d68
3dc0: eb890150 eb9e8400 eb890180 eb83ea20 ebb62000 c0194db0 eb879a80 00500001
3de0: eb83ea20 00000001 ebb62000 c018a838 00000101 eb425810 c008ccac 00000003
3e00: eb8e3c80 ebb62000 eb425810 eb83ea20 c044792c 00000000 c044792c 00000000
3e20: bee4da2c c008d508 00000000 00000000 eb83ea20 eb426f58 eb80e3a0 eb425810
3e40: c008d3fc 00000000 00000000 c00881f0 ebb63ef8 00000101 eb425810 00000022
3e60: 00000000 00000000 00000000 c0096884 eb4064d8 c042b298 bee4da2c eb40fed0
3e80: 0000002f eb425810 ebb63ef8 ebb63f78 00000000 ebb63eb4 ebb62000 ebb62000
3ea0: 00000000 c0096e28 ebb63ec4 eb802f60 00000002 eb80e3a0 eb426f58 c02c558c
3ec0: eb802f60 00000000 00000020 00000001 ebb63f78 ebb53000 ffffff9c ffffff9c
3ee0: ebb62000 00000000 bee4da2c c00971e4 00000041 ebb2bba0 eb80e3a0 eb426f58
3f00: 05b6719b 00000007 ebb53005 eb80e3a0 eb401318 eb425810 00000101 00000000
3f20: 00000000 00000000 c04166a0 403acafc 40000013 c0086fbc eb8178c0 eb8178c8
3f40: 00000000 ebb62000 bee4da2c 00000101 00000000 00000000 403be000 ebb53000
3f60: 00000101 00000000 00000001 c0088f74 00000000 eb8178c0 00000101 00000000
3f80: 00000022 00000100 ebb62000 0001a2d8 00000014 403be000 00000005 c000df68
3fa0: 00000000 c000ddc0 0001a2d8 00000014 403acafc 00000101 00000000 0000000a
3fc0: 0001a2d8 00000014 403be000 00000005 00000001 00000002 0000ed98 bee4da2c
3fe0: 00000000 bee4d96c 4036cb75 4036494c 60000010 403acafc 3bffe821 3bffec21
[<c0018798>] (_clk_get_rate+0x4c/0x10c) from [<c00190a4>] (clk_get_rate+0x40/0x50)
[<c00190a4>] (clk_get_rate+0x40/0x50) from [<c0196f48>] (imx_setup_ufcr.isra.5+0x10/0x70)
[<c0196f48>] (imx_setup_ufcr.isra.5+0x10/0x70) from [<c0196fb8>] (imx_startup+0x10/0x260)
[<c0196fb8>] (imx_startup+0x10/0x260) from [<c0193d68>] (uart_startup+0x64/0x20c)
[<c0193d68>] (uart_startup+0x64/0x20c) from [<c0194db0>] (uart_open+0xd4/0x140)
[<c0194db0>] (uart_open+0xd4/0x140) from [<c018a838>] (tty_open+0x1d0/0x49c)
[<c018a838>] (tty_open+0x1d0/0x49c) from [<c008d508>] (chrdev_open+0x10c/0x1ec)
[<c008d508>] (chrdev_open+0x10c/0x1ec) from [<c00881f0>] (__dentry_open.isra.16+0x228/0x2ec)
[<c00881f0>] (__dentry_open.isra.16+0x228/0x2ec) from [<c0096884>] (do_last.isra.40+0x31c/0x6c8)
[<c0096884>] (do_last.isra.40+0x31c/0x6c8) from [<c0096e28>] (path_openat+0xb8/0x38c)
[<c0096e28>] (path_openat+0xb8/0x38c) from [<c00971e4>] (do_filp_open+0x2c/0x80)
[<c00971e4>] (do_filp_open+0x2c/0x80) from [<c0088f74>] (do_sys_open+0xdc/0x174)
[<c0088f74>] (do_sys_open+0xdc/0x174) from [<c000ddc0>] (ret_fast_syscall+0x0/0x30)
Code: 1afffff9 e5923004 e592500c e5924014 (e5933000)
---[ end trace e6f14f4cf9b4ac85 ]---

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/clock-imx6q.c |    8 --------
 arch/arm/mach-imx/mach-imx6q.c  |    7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 613a1b9..a9351eb 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -19,7 +19,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <asm/div64.h>
-#include <asm/mach/map.h>
 #include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -1948,19 +1947,12 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	return 0;
 }
 
-static struct map_desc imx6q_clock_desc[] = {
-	imx_map_entry(MX6Q, CCM, MT_DEVICE),
-	imx_map_entry(MX6Q, ANATOP, MT_DEVICE),
-};
-
 int __init mx6q_clocks_init(void)
 {
 	struct device_node *np;
 	void __iomem *base;
 	int i, irq;
 
-	iotable_init(imx6q_clock_desc, ARRAY_SIZE(imx6q_clock_desc));
-
 	/* retrieve the freqency of fixed clocks from device tree */
 	for_each_compatible_node(np, NULL, "fixed-clock") {
 		u32 rate;
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 8bf5fa3..a1bc9f7 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -20,6 +20,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 
@@ -30,10 +31,16 @@ static void __init imx6q_init_machine(void)
 	imx6q_pm_init();
 }
 
+static struct map_desc imx6q_clock_desc[] = {
+	imx_map_entry(MX6Q, CCM, MT_DEVICE),
+	imx_map_entry(MX6Q, ANATOP, MT_DEVICE),
+};
+
 static void __init imx6q_map_io(void)
 {
 	imx_lluart_map_io();
 	imx_scu_map_io();
+	iotable_init(imx6q_clock_desc, ARRAY_SIZE(imx6q_clock_desc));
 }
 
 static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
-- 
1.7.5.4
