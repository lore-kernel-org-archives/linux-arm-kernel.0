From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Nov 2015 10:42:43 +0000
Subject: arm64 function_graph tracer panic with CONFIG_DYNAMIC_FTRACE
Message-ID: <20151112104243.GF5627@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

I was trying to assess what's working/not working in ftrace on arm64 and
whether your recent patches are meant for 4.4 or can wait until 4.5.
However, without any patches applied on a 4.3 kernel, enabling the
function_graph tracer when CONFIG_DYNAMIC_FTRACE is enabled panics the
kernel. Strangely, it does not happen if only a single CPU is on.
However, with function_graph tracer on, onlining a second CPU leads to a
similar panic.

Below is the kernel panic with 2 CPUs online on a Juno board. There
isn't much stack trace information for CPU 5 where the fault happened,
the frame pointer (x29) seems corrupted as well. Any idea? Thanks.

# echo function_graph > /sys/kernel/debug/tracing/current_tracer
swapper/5[0]: undefined instruction: pc=ffffffc000a46698
Code: 0009ccf8 ffffffc0 00000000 00000000 (00000030)
Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 5 PID: 0 Comm: swapper/5 Not tainted 4.3.0 #574
Hardware name: Juno (DT)
task: ffffffc976b23ac0 ti: ffffffc976b3c000 task.ti: ffffffc976b3c000
PC is at cpu_online_bits+0x0/0x8
LR is at cpu_online_bits+0x0/0x8
pc : [<ffffffc000a46698>] lr : [<ffffffc000a46698>] pstate: 600001c5
sp : ffffffc976b3ff40
x29: 0000000000000002 x28: ffffffc000100c0c
x27: ffffffc000aeb790 x26: ffffffc9758d5800
x25: 0000000000000002 x24: ffffffc0000924a0
x23: ffffffc976b3ff40 x22: ffffffc00056841c
x21: ffffffc000a25b80 x20: ffffffc000aeb790
x19: ffffffc9758d5800 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000 x14: 0000000000000000
x13: 0000000000000000 x12: 0000000034d5d91d
x11: 0000000000000000 x10: 0000000000001000
x9 : ffffffc9768070c0 x8 : 00000000000007d8
x7 : 0000001b280eb7c4 x6 : 0000000000000015
x5 : 000000000000000a x4 : ffffffc0792a4990
x3 : ffffffffffffffa1 x2 : ffffffc0792a4800
x1 : ffffffc0000949e0 x0 : ffffffffffffffa1

Process swapper/5 (pid: 0, stack limit = 0xffffffc976b3c020)
Stack: (0xffffffc976b3ff40 to 0xffffffc976b40000)
ff40: ffffffc976b3ff70 ffffffc0000924a0 ffffffc976b3c000 ffffffc000a46000
ff60: ffffffc000b20000 0000001b27d716c0 ffffffc976b3ffd0 ffffffc000090208
ff80: 0000000000000005 0000000000000e12 ffffffc000b306a0 0000000000000000
ffa0: 0000000000000000 0000000000000000 0000000080b65000 0000000080b68000
ffc0: ffffffc0000827f0 0000000000000000 0000000000000000 00000000800827dc
ffe0: 0000000000000000 0000000000000000 068824085611a721 280b8a0b05808446
Call trace:
Code: 0009ccf8 ffffffc0 00000000 00000000 (00000030)
---[ end trace 702bb2ed35464601 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
CPU4: stopping
CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D         4.3.0 #574
Hardware name: Juno (DT)
Call trace:
[<ffffffc00008aaa8>] dump_backtrace+0x0/0x150
[<ffffffc00008ac1c>] show_stack+0x24/0x30
[<ffffffc0003b21a0>] dump_stack+0x90/0xd0
[<ffffffc000090880>] handle_IPI+0x280/0x290
[<ffffffc00008255c>] gic_handle_irq+0x94/0xb0
Exception stack(0xffffffc976b3bd70 to 0xffffffc976b3be90)
bd60:                                   0000001b2ed1ee8c ffffffc000aeb850
bd80: ffffffc976b3bec0 ffffffc0005681dc 0000000080000145 ffffffc00009244c
bda0: 0000000000000000 0000000000000001 ffffffc976b38000 0000000000000003
bdc0: ffffffc976b38000 ffffffc000a282a8 ffffffc976b38000 ffffffc0000ecb28
bde0: 00000000000006ed ffffffc9768070c0 00000000000007e0 ffffffc0006d04a8
be00: 0000000000000001 0000000000005a0e 0000000000000001 ffffffc0006d04a8
be20: 0000000000000000 0000000000000000 0000000000000001 0000001b2ed1ee8c
be40: ffffffc000aeb850 ffffffc9758d5600 0000000000000000 ffffffc000aeb790
be60: 0000000000000004 0000001b2e40a7ec ffffffc976b3bf70 ffffffc000a29f20
be80: ffffffc0006c9000 ffffffc976b3bec0
[<ffffffc0000855ac>] el1_irq+0x6c/0xe0
[<ffffffc00056842c>] cpuidle_enter+0x34/0x48
[<ffffffc000100c30>] call_cpuidle+0x48/0x80
[<ffffffc000100e90>] cpu_startup_entry+0x228/0x308
[<ffffffc000090208>] secondary_start_kernel+0x130/0x158
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

-- 
Catalin
