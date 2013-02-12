From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Feb 2013 16:49:54 +0100
Subject: [PATCH] HACK: ARM: Fix generic timer broadcast for TWD
Message-ID: <1360684194-10894-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following crash when booting on Tegra:

	[  123.346233] Unable to handle kernel NULL pointer dereference at virtual address 00000000
	[  123.354346] pgd = c0004000
	[  123.357071] [00000000] *pgd=00000000
	[  123.360687] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
	[  123.366614] Modules linked in:
	[  123.369702] CPU: 0    Not tainted  (3.8.0-rc7-next-20130212-00002-ga12b34b-dirty #21)
	[  123.377541] PC is at 0x0
	[  123.380123] LR is at tick_do_broadcast.constprop.3+0x74/0xb0
	[  123.385802] pc : [<00000000>]    lr : [<c0064344>]    psr: 20000193
	[  123.385802] sp : c06ede18  ip : 00000002  fp : 00000004
	[  123.397285] r10: c06e8a60  r9 : c06f4f10  r8 : c06f4ca0
	[  123.402520] r7 : 0000001c  r6 : b7bf7c40  r5 : c07537d8  r4 : 00000000
	[  123.409055] r3 : 00000000  r2 : 004ac000  r1 : 00000004  r0 : c07537e4
	[  123.415594] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
	[  123.422999] Control: 10c5387d  Table: 1ada804a  DAC: 00000015
	[  123.428756] Process swapper/0 (pid: 0, stack limit = 0xc06ec238)
	[  123.434771] Stack: (0xc06ede18 to 0xc06ee000)
	[  123.439145] de00:                                                       00000002 ffffffff
	[  123.447348] de20: 7fffffff c0064434 b7bec890 c0707840 b7bf7c40 0000001c 00000000 c0707800
	[  123.455547] de40: df815ad0 00000000 00000000 00000049 c072e8b3 df815a80 00000001 c022db34
	[  123.463749] de60: c022db10 c0079a14 0000001c c0b8ca68 b7bf3dc0 df815a80 df815ad0 c0707800
	[  123.471950] de80: fe000100 df9cb380 c06ec000 c04eb1ac 00000000 c0079b94 df815a80 df815ad0
	[  123.480148] dea0: 00000000 c007c7b0 c007c734 00000049 00000049 c0079410 c06e91f0 c000ec38
	[  123.488349] dec0: fe00010c c06f5048 c06edee8 c00086d4 c005dd20 c032c13c 60000113 ffffffff
	[  123.496549] dee0: c06edf1c c000e000 c06edf30 3b9aca00 b7bf2650 0000001c b718bcc0 0000001c
	[  123.504747] df00: c0b8c3e8 00000001 df9cb380 c06ec000 c04eb1ac 00000000 00000015 c06edf30
	[  123.512945] df20: c005dd20 c032c13c 60000113 ffffffff b7bf2650 0000001c 00000000 c04eb1ac
	[  123.521144] df40: 00000000 df9cb394 c0b8c3e8 c0b8c3e8 c06f9de0 c032be10 df9cb394 c0b8c3e8
	[  123.529341] df60: 00000001 c032dd30 0000004c c0b8c3e8 c0777c94 00000001 c06f9de0 00000000
	[  123.537541] df80: c072ea88 c032bf40 c06ec000 c072ea88 c06ec000 c06f43f4 c04eb1ac c000f008
	[  123.545740] dfa0: c06f4d00 00000000 c072e9c0 c0b89140 ffffffff 411fc090 3fffffff c06b47bc
	[  123.553939] dfc0: ffffffff ffffffff c06b42ec 00000000 00000000 c06ddcd0 00000000 10c5387d
	[  123.562138] dfe0: c06f43f0 c06ddccc c06f8aa4 0000406a 00000000 00008074 00000000 00000000
	[  123.570369] [<c0064344>] (tick_do_broadcast.constprop.3+0x74/0xb0) from [<c0064434>] (tick_handle_oneshot_broadcast+0xb4/0x108)
	[  123.581897] [<c0064434>] (tick_handle_oneshot_broadcast+0xb4/0x108) from [<c022db34>] (tegra_timer_interrupt+0x24/0x2c)
	[  123.592727] [<c022db34>] (tegra_timer_interrupt+0x24/0x2c) from [<c0079a14>] (handle_irq_event_percpu+0x50/0x194)
	[  123.603022] [<c0079a14>] (handle_irq_event_percpu+0x50/0x194) from [<c0079b94>] (handle_irq_event+0x3c/0x5c)
	[  123.612887] [<c0079b94>] (handle_irq_event+0x3c/0x5c) from [<c007c7b0>] (handle_fasteoi_irq+0x7c/0x138)
	[  123.622314] [<c007c7b0>] (handle_fasteoi_irq+0x7c/0x138) from [<c0079410>] (generic_handle_irq+0x20/0x30)
	[  123.631923] [<c0079410>] (generic_handle_irq+0x20/0x30) from [<c000ec38>] (handle_IRQ+0x38/0x94)
	[  123.640740] [<c000ec38>] (handle_IRQ+0x38/0x94) from [<c00086d4>] (gic_handle_irq+0x28/0x5c)
	[  123.649204] [<c00086d4>] (gic_handle_irq+0x28/0x5c) from [<c000e000>] (__irq_svc+0x40/0x70)
	[  123.657561] Exception stack(0xc06edee8 to 0xc06edf30)
	[  123.662637] dee0:                   c06edf30 3b9aca00 b7bf2650 0000001c b718bcc0 0000001c
	[  123.670839] df00: c0b8c3e8 00000001 df9cb380 c06ec000 c04eb1ac 00000000 00000015 c06edf30
	[  123.679027] df20: c005dd20 c032c13c 60000113 ffffffff
	[  123.684125] [<c000e000>] (__irq_svc+0x40/0x70) from [<c032c13c>] (cpuidle_wrap_enter+0x48/0x94)
	[  123.692858] [<c032c13c>] (cpuidle_wrap_enter+0x48/0x94) from [<c032be10>] (cpuidle_enter_state+0x14/0x70)
	[  123.702461] [<c032be10>] (cpuidle_enter_state+0x14/0x70) from [<c032dd30>] (cpuidle_enter_state_coupled+0x208/0x2a0)
	[  123.713013] [<c032dd30>] (cpuidle_enter_state_coupled+0x208/0x2a0) from [<c032bf40>] (cpuidle_idle_call+0xd4/0x124)
	[  123.723475] [<c032bf40>] (cpuidle_idle_call+0xd4/0x124) from [<c000f008>] (cpu_idle+0xb0/0x124)
	[  123.732228] [<c000f008>] (cpu_idle+0xb0/0x124) from [<c06b47bc>] (start_kernel+0x2a4/0x2f4)
	[  123.740586] Code: bad PC value
	[  123.743668] ---[ end trace ceed8db1ca3c192e ]---
	[  123.748297] Kernel panic - not syncing: Fatal exception in interrupt
	[  125.143549] SMP: failed to stop secondary CPUs

Note that I have close to no clue what I'm doing, so the patch might be
the completely wrong thing to do. An alternative I had initially thought
about was to check for NULL before calling the clock_event_device's
.broadcast() function.

The reason why I chose to always assign .broadcast instead is that a
previous patch (3d06770: Add generic timer broadcast support) aims at
generically implementing broadcast support on ARM and providing a
tick_broadcast() implementation for this purpose so it seemed like the
right thing to do.

The above-mentioned patch for some reason removed the assignment to the
.broadcast() member for apparently no reason, so maybe that was just
done by mistake?

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5f73f70..472ba9d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -467,7 +467,7 @@ void tick_broadcast(const struct cpumask *mask)
 	smp_cross_call(mask, IPI_TIMER);
 }
 #else
-#define smp_timer_broadcast	NULL
+#define tick_broadcast NULL
 #endif
 
 static void broadcast_timer_set_mode(enum clock_event_mode mode,
@@ -513,6 +513,8 @@ static void __cpuinit percpu_timer_setup(void)
 
 	if (!lt_ops || lt_ops->setup(evt))
 		broadcast_timer_setup(evt);
+
+	evt->broadcast = tick_broadcast;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.8.1.2
