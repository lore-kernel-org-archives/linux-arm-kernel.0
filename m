From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon,  6 Oct 2014 17:32:00 +0400
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
Message-ID: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 2111667b4677 ("ARM: pxa: call debug_ll_io_init for
earlyprintk")

This commit gives the following backtrace on PXA/tosa early in the boot
time when DEBUG_LL is enabled. It is due to overlap between uart memory
and PERIPH_ memory block mapped by pxa_map_io.

------------[ cut here ]------------
kernel BUG at /home/lumag/linux/mm/vmalloc.c:1143!
Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.17.0-00032-g8e0d202-dirty #23
task: c062a5a8 ti: c0620000 task.ti: c0620000
PC is at vm_area_add_early+0x54/0x84
LR is at add_static_vm_early+0xc/0x60
pc : [<c03e1100>]    lr : [<c03d9ef4>]    psr: 800001d3
sp : c0621f04  ip : c03efa74  fp : c03edf84
r10: c0637e98  r9 : 40000001  r8 : c03da57c
r7 : c3ffcfb0  r6 : 00000000  r5 : c3ffcfb0  r4 : 02000000
r3 : c3ffcfd8  r2 : f2100000  r1 : f4000000  r0 : c3ffcfb0
Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 00007977  Table: a0004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc06201c8)
Stack: (0xc0621f04 to 0xc0622000)
1f00:          c3ffcfd8 40000001 c3ffcfd8 c03ee08c c03da570 c03db90c c0637d24
1f20: 00000000 c03ec7cc c066e654 a0700000 000a0700 c03db914 c03db90c c03daf84
1f40: 00000000 000a0000 c0000000 c03ec7cc 000a0700 c0700000 ffff1000 000a3fff
1f60: 00001000 00000007 00000000 c03ec7cc c0008000 c03ed748 c0621fd4 c03d5d18
1f80: 69052d00 a03ec48c 00000000 c03d8ad0 0000006c 00007977 c036c6e8 00000001
1fa0: c0621fd4 c03ed744 c0628000 a0004000 69052d00 a03ec48c 00000000 c03d68d4
1fc0: 00000000 00000000 00000000 00000000 00000000 c03ed748 c0649894 c062801c
1fe0: c03ed744 c062b2f0 a0004000 69052d00 a03ec48c a0008040 00000000 00000000
[<c03e1100>] (vm_area_add_early) from [<c03d9ef4>] (add_static_vm_early+0xc/0x60)
[<c03d9ef4>] (add_static_vm_early) from [<c03da570>] (iotable_init.part.6+0xa8/0xb4)
[<c03da570>] (iotable_init.part.6) from [<c03db914>] (pxa25x_map_io+0x8/0x24)
[<c03db914>] (pxa25x_map_io) from [<c03daf84>] (paging_init+0x744/0x8d8)
[<c03daf84>] (paging_init) from [<c03d8ad0>] (setup_arch+0x354/0x608)
[<c03d8ad0>] (setup_arch) from [<c03d68d4>] (start_kernel+0xa8/0x3dc)
[<c03d68d4>] (start_kernel) from [<a0008040>] (0xa0008040)
Code: e5904008 e0811004 e1520001 2a000005 (e7f001f2)
---[ end trace f24b6c88ae00fa9a ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

Cc: <stable@vger.kernel.org>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 04b013f..d862607 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -99,6 +99,5 @@ static struct map_desc common_io_desc[] __initdata = {
 
 void __init pxa_map_io(void)
 {
-	debug_ll_io_init();
 	iotable_init(ARRAY_AND_SIZE(common_io_desc));
 }
-- 
2.1.1
