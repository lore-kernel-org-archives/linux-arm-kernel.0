From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Mon, 3 Aug 2015 04:12:00 +0000
Subject: [Query] ARM64: Softlockup when using PSCI for secondary CPU_ON
Message-ID: <BY1PR0301MB1303EC5AAE8F0B4DAA70D15F82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM64 experts,

I am working on a Freescale ARM64 based SoC, which has 4 Cortex-A53 cores and I am using the
PSCI conducts to turn on the secondary CPUs via a custom implementation of a secure runtime
firmware (something similar to the ARM Trusted Firmware).

Following is my boot-flow:

- BootROM (runs in EL3, All secondaries are held up in reset) ->

- UEFI bootloader- PEI Phase (Runs only on Primary, starts up in EL3) ->

- Secure Firmware (runs in EL3, transitions primary core to EL2) ->

- UEFI bootloader- Rest of the Phases (Runs only on Primary, in EL2) ->

- UEFI Linux loader launches linux (Runs only on Primary, transitions core to EL1) ->

- Linux runs and calls PSCI conducts to turn on secondary cores via smc calls to secure run-time firmware ->

- Now I can see that the ARM64 linux is able to recognize that the secondaries are boot'ed properly:

PSCI Logs:
----------
psci: probing for conduit method from DT.
psci: PSCIv0.2 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
..

Architected cp15 timer(s) running at 25.00MHz (phys).
sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 2748779069440ns

..

CPU1: Booted secondary processor
Detected VIPT I-cache on CPU1
CPU2: Booted secondary processor
Detected VIPT I-cache on CPU2
CPU3: Booted secondary processor
Detected VIPT I-cache on CPU3
Brought up 4 CPUs
SMP: Total of 4 processors activated.


- However, when the Linux boot proceeds further, I see softlockups which usually show that one
of the secondaries was stuck in 'secondary_start_kernel' (detailed logs below).

- When I turn of CONFIG_SMP from the .config, I can see that the softlockups disappear. So, I am
correlating these softlockups to SMP and PSCI conducts.

- Any pointers on what can be going wrong here?

Detailed logs:
--------------

preempt self-detected stall on CPU { 3}  (t=17194 jiffies g=-267 c=-268 q=1)
Task dump for CPU 0:
swapper/0       R  running task        0     0      0 0x00000000
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000000
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
Task dump for CPU 2:
swapper/2       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
[<ffffffc0000a4828>] irq_exit+0x80/0xd0
[<ffffffc0000da6a8>] __handle_domain_irq+0x64/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0790d7e30 to 0xffffffc0790d7f50)
7e20:                                     790d4000 ffffffc0 0070457c ffffffc0
7e40: 790d7f70 ffffffc0 00086164 ffffffc0 00000000 00000000 00000000 00000000
7e60: 7fea4b1c ffffffc0 7fea4b1c ffffffc0 78c24170 ffffffc0 790d7ef0 ffffffc0
7e80: 00000000 00000000 7feb3458 ffffffc0 790d7f10 ffffffc0 000f6548 ffffffc0
7ea0: 00763000 ffffffc0 00763c00 ffffffc0 73316280 00000050 006fe000 ffffffc0
7ec0: 006fe000 ffffffc0 00639c98 ffffffc0 005184b8 ffffffc0 80785000 00000000
7ee0: 000815e0 ffffffc0 80000000 00000040 000001f5 00000000 00000148 00000000
7f00: 790d7f10 ffffffc0 000f6544 ffffffc0 790d7f50 ffffffc0 000f6c14 ffffffc0
7f20: 7fea4f38 ffffffc0 7332edf8 00000050 007044f8 ffffffc0 0075480a ffffffc0
7f40: 00000001 00000000 7fea4f38 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8
Task dump for CPU 3:
swapper/3       R  running task        0     0      1 0x00000000
Call trace:
[<ffffffc000089148>] dump_backtrace+0x0/0x12c
[<ffffffc000089284>] show_stack+0x10/0x1c
[<ffffffc0000c2b84>] sched_show_task+0xa8/0x100
[<ffffffc0000c5cbc>] dump_cpu_task+0x3c/0x4c
[<ffffffc0000e213c>] rcu_dump_cpu_stacks+0x98/0xe8
[<ffffffc0000e58c0>] rcu_check_callbacks+0x438/0x78c
[<ffffffc0000e8f5c>] update_process_times+0x38/0x6c
[<ffffffc0000f6978>] tick_sched_handle.isra.16+0x1c/0x68
[<ffffffc0000f6a04>] tick_sched_timer+0x40/0x7c
[<ffffffc0000e9628>] __run_hrtimer.isra.34+0x48/0x104
[<ffffffc0000e9cbc>] hrtimer_interrupt+0xd4/0x268
[<ffffffc00041bea4>] arch_timer_handler_phys+0x28/0x38
[<ffffffc0000de1d8>] handle_percpu_devid_irq+0x74/0x98
[<ffffffc0000da388>] generic_handle_irq+0x30/0x4c
[<ffffffc0000da6a4>] __handle_domain_irq+0x60/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0790dbe30 to 0xffffffc0790dbf50)
be20:                                     790d8000 ffffffc0 0070457c ffffffc0
be40: 790dbf70 ffffffc0 00086164 ffffffc0 00000000 00000000 00000000 00000000
be60: 7feb1b1c ffffffc0 00000000 00000000 00000000 00000000 790dbef0 ffffffc0
be80: 00000000 00000000 00000000 00000000 790c9ab0 ffffffc0 790dbd90 ffffffc0
bea0: ffffcea0 00000000 01010101 01010101 00000038 00000000 00000000 00000000
bec0: b0b80a34 0000007f b0cb5598 0000007f 0017b670 ffffffc0 b0c3c100 0000007f
bee0: ce1e74a0 0000007f 790d8000 ffffffc0 0070457c ffffffc0 007044f8 ffffffc0
bf00: 0075480a ffffffc0 00000001 00000000 00639c98 ffffffc0 005184b8 ffffffc0
bf20: 80785000 00000000 000815e0 ffffffc0 80000000 00000040 790dbf70 ffffffc0
bf40: 00086160 ffffffc0 790dbf70 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8
[<ffffffc0000d1c04>] cpu_startup_entry+0xe8/0x12c
[<ffffffc000091910>] secondary_start_kernel+0x124/0x134

 { 0}  (t=17194 jiffies g=-267 c=-268 q=1)
Task dump for CPU 0:
swapper/0       R  running task        0     0      0 0x00000000
Call trace:
[<ffffffc000089148>] dump_backtrace+0x0/0x12c
[<ffffffc000089284>] show_stack+0x10/0x1c
[<ffffffc0000c2b84>] sched_show_task+0xa8/0x100
[<ffffffc0000c5cbc>] dump_cpu_task+0x3c/0x4c
[<ffffffc0000e213c>] rcu_dump_cpu_stacks+0x98/0xe8
[<ffffffc0000e58c0>] rcu_check_callbacks+0x438/0x78c
[<ffffffc0000e8f5c>] update_process_times+0x38/0x6c
[<ffffffc0000f6978>] tick_sched_handle.isra.16+0x1c/0x68
[<ffffffc0000f6a04>] tick_sched_timer+0x40/0x7c
[<ffffffc0000e9628>] __run_hrtimer.isra.34+0x48/0x104
[<ffffffc0000e9cbc>] hrtimer_interrupt+0xd4/0x268
[<ffffffc00041bea4>] arch_timer_handler_phys+0x28/0x38
[<ffffffc0000de1d8>] handle_percpu_devid_irq+0x74/0x98
[<ffffffc0000da388>] generic_handle_irq+0x30/0x4c
[<ffffffc0000da6a4>] __handle_domain_irq+0x60/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0006fbde0 to 0xffffffc0006fbf00)
bde0: 006f8000 ffffffc0 0070457c ffffffc0 006fbf20 ffffffc0 00086164 ffffffc0
be00: 00000000 00000000 00000000 00000000 7fe8ab1c ffffffc0 7fe8ab1c ffffffc0
be20: 7741ee00 ffffffc0 006fbea0 ffffffc0 00000000 00000000 666d6873 fefefeff
be40: 0070aaf0 ffffffc0 006fbd40 ffffffc0 7f7f7f7f 7f7f7f7f 01010101 01010101
be60: 00000020 00000000 00000000 00000000 b0b80a34 0000007f b0cb5598 0000007f
be80: 0017b670 ffffffc0 b0c3c100 0000007f ce1e74a0 0000007f 006f8000 ffffffc0
bea0: 0070457c ffffffc0 007044f8 ffffffc0 0075480a ffffffc0 00000001 00000000
bec0: 00639c98 ffffffc0 005184b8 ffffffc0 80785000 00000000 00080270 ffffffc0
bee0: 80000000 00000040 006fbf20 ffffffc0 00086160 ffffffc0 006fbf20 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8
[<ffffffc0000d1c04>] cpu_startup_entry+0xe8/0x12c
[<ffffffc000508d88>] rest_init+0x7c/0x88
[<ffffffc0006bc98c>] start_kernel+0x39c/0x3b4
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000000
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
Task dump for CPU 2:
swapper/2       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
[<ffffffc0000a4828>] irq_exit+0x80/0xd0
[<ffffffc0000da6a8>] __handle_domain_irq+0x64/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0790d7e30 to 0xffffffc0790d7f50)
7e20:                                     790d4000 ffffffc0 0070457c ffffffc0
7e40: 790d7f70 ffffffc0 00086164 ffffffc0 00000000 00000000 00000000 00000000
7e60: 7fea4b1c ffffffc0 7fea4b1c ffffffc0 78c24170 ffffffc0 790d7ef0 ffffffc0
7e80: 00000000 00000000 7feb3458 ffffffc0 790d7f10 ffffffc0 000f6548 ffffffc0
7ea0: 00763000 ffffffc0 00763c00 ffffffc0 73316280 00000050 006fe000 ffffffc0
7ec0: 006fe000 ffffffc0 00639c98 ffffffc0 005184b8 ffffffc0 80785000 00000000
7ee0: 000815e0 ffffffc0 80000000 00000040 000001f5 00000000 00000148 00000000
7f00: 790d7f10 ffffffc0 000f6544 ffffffc0 790d7f50 ffffffc0 000f6c14 ffffffc0
7f20: 7fea4f38 ffffffc0 7332edf8 00000050 007044f8 ffffffc0 0075480a ffffffc0
7f40: 00000001 00000000 7fea4f38 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8

INFO: rcu_preempt detected stalls on CPUs/tasks: { 1 2} (detected by 0, t=287104493908 jiffies, g=-267, c=-268, q=2)
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
Task dump for CPU 2:
swapper/2       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
[<ffffffc0000a4828>] irq_exit+0x80/0xd0
[<ffffffc0000da6a8>] __handle_domain_irq+0x64/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0790d7e30 to 0xffffffc0790d7f50)
7e20:                                     790d4000 ffffffc0 0070457c ffffffc0
7e40: 790d7f70 ffffffc0 00086164 ffffffc0 00000000 00000000 00000000 00000000
7e60: 7fea4b1c ffffffc0 7fea4b1c ffffffc0 790d7e90 ffffffc0 000ef710 ffffffc0
7e80: 007638c8 ffffffc0 00000007 00000000 790d7f10 ffffffc0 000f6548 ffffffc0
7ea0: 00763000 ffffffc0 00763c00 ffffffc0 73316280 00000050 006fe000 ffffffc0
7ec0: 006fe000 ffffffc0 00639c98 ffffffc0 005184b8 ffffffc0 80785000 00000000
7ee0: 000815e0 ffffffc0 80000000 00000040 000001f5 00000000 00000148 00000000
7f00: 790d7f10 ffffffc0 000f6544 ffffffc0 790d7f50 ffffffc0 000f6c14 ffffffc0
7f20: 7fea4f38 ffffffc0 7332edf8 00000050 007044f8 ffffffc0 0075480a ffffffc0
7f40: 00000001 00000000 7fea4f38 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8
INFO: rcu_preempt detected stalls on CPUs/tasks: { 1 2} (detected by 0, t=287104508993 jiffies, g=-267, c=-268, q=6)
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
Task dump for CPU 2:
swapper/2       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
[<ffffffc0000a4828>] irq_exit+0x80/0xd0
[<ffffffc0000da6a8>] __handle_domain_irq+0x64/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0790d7e30 to 0xffffffc0790d7f50)
7e20:                                     790d4000 ffffffc0 0070457c ffffffc0
7e40: 790d7f70 ffffffc0 00086164 ffffffc0 00000000 00000000 00000000 00000000
7e60: 7fea4b1c ffffffc0 7fea4b1c ffffffc0 790d7e90 ffffffc0 000ef710 ffffffc0
7e80: 007638c8 ffffffc0 00000007 00000000 790d7f10 ffffffc0 000f6548 ffffffc0
7ea0: 00763000 ffffffc0 00763c00 ffffffc0 73316280 00000050 006fe000 ffffffc0
7ec0: 006fe000 ffffffc0 00639c98 ffffffc0 005184b8 ffffffc0 80785000 00000000
7ee0: 000815e0 ffffffc0 80000000 00000040 000001f5 00000000 00000148 00000000
7f00: 790d7f10 ffffffc0 000f6544 ffffffc0 790d7f50 ffffffc0 000f6c14 ffffffc0
7f20: 7fea4f38 ffffffc0 7332edf8 00000050 007044f8 ffffffc0 0075480a ffffffc0
7f40: 00000001 00000000 7fea4f38 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8
INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0, t=354658509690 jiffies, g=-267, c=-268, q=6)
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
NMI watchdog: BUG: soft lockup - CPU#1 stuck for 8524s! [swapper/1:0]
Modules linked in:

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.3+ #18
Hardware name: LS1043A RDB Board (DT)
task: ffffffc0790c8000 ti: ffffffc0790d0000 task.ti: ffffffc0790d0000
PC is at arch_cpu_idle+0x10/0x18
LR is at arch_cpu_idle+0xc/0x18
pc : [<ffffffc000086164>] lr : [<ffffffc000086160>] pstate: 60000045
sp : ffffffc0790d3f70
x29: ffffffc0790d3f70 x28: 0000004080000000
x27: ffffffc0000815e0 x26: 0000000080785000
x25: ffffffc0005184b8 x24: ffffffc000639c98
x23: 0000000000000001 x22: ffffffc00075480a
x21: ffffffc0007044f8 x20: ffffffc00070457c
x19: ffffffc0790d0000 x18: 000000000000000e
x17: 0000000000000007 x16: 0000000000000001
x15: 0000000000000007 x14: 0fffffffffffffff
x13: 0000000000000010 x12: ffffffc0006fe000
x11: 00000000005e0000 x10: 00000000ffffcea0
x9 : ffffffc0790d3d90 x8 : ffffffc0790c8530
x7 : 0000000000000001 x6 : 0000000000000000
x5 : ffffffc0790d3ef0 x4 : ffffffc0790f8000
x3 : ffffffc07fe97b1c x2 : ffffffc07fe97b1c
x1 : 0000000000000000 x0 : 0000000000000000

INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0, t=575334887890 jiffies, g=-267, c=-268, q=6)
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
sched: RT throttling activated
INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0, t=576460802941 jiffies, g=-267, c=-268, q=6)
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0, t=642888903855 jiffies, g=-267, c=-268, q=6)
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
hrtimer: interrupt took 8635652818586378360 ns
INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0, t=864691196905 jiffies, g=-267, c=-268, q=6)
Task dump for CPU 1:
swapper/1       R  running task        0     0      1 0x00000002
Call trace:
[<ffffffc00008655c>] __switch_to+0x74/0x8c
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:249 clockevents_program_event+0xf4/0x104()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G             L 3.19.3+ #18
Hardware name: LS1043A RDB Board (DT)
Call trace:
[<ffffffc000089148>] dump_backtrace+0x0/0x12c
[<ffffffc000089284>] show_stack+0x10/0x1c
[<ffffffc00050e2c0>] dump_stack+0x88/0xd8
[<ffffffc0000a0cb4>] warn_slowpath_common+0x94/0xcc
[<ffffffc0000a0db0>] warn_slowpath_null+0x14/0x20
[<ffffffc0000f40d0>] clockevents_program_event+0xf0/0x104
[<ffffffc0000f6044>] tick_program_event+0x28/0x34
[<ffffffc0000e9d78>] hrtimer_interrupt+0x190/0x268
[<ffffffc00041bea4>] arch_timer_handler_phys+0x28/0x38
[<ffffffc0000de1d8>] handle_percpu_devid_irq+0x74/0x98
[<ffffffc0000da388>] generic_handle_irq+0x30/0x4c
[<ffffffc0000da6a4>] __handle_domain_irq+0x60/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0006fbde0 to 0xffffffc0006fbf00)
bde0: 006f8000 ffffffc0 0070457c ffffffc0 006fbf20 ffffffc0 00086164 ffffffc0
be00: 00000000 00000000 00000000 00000000 7fe8ab1c ffffffc0 7fe8ab1c ffffffc0
be20: 7741ee00 ffffffc0 006fbea0 ffffffc0 5035998f 780000d7 00763bc0 ffffffc0
be40: 0070aaf0 ffffffc0 006fbd40 ffffffc0 036568cc 00000002 0004baf6 00000000
be60: 00000018 00000000 e8000000 00000003 0000003f 00000000 30000000 0ebd9208
be80: 00190250 ffffffc0 b0c411b0 0000007f ce1e77d0 0000007f 006f8000 ffffffc0
bea0: 0070457c ffffffc0 007044f8 ffffffc0 0075480a ffffffc0 00000001 00000000
bec0: 00639c98 ffffffc0 005184b8 ffffffc0 80785000 00000000 00080270 ffffffc0
bee0: 80000000 00000040 006fbf20 ffffffc0 00086160 ffffffc0 006fbf20 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8
[<ffffffc0000d1c04>] cpu_startup_entry+0xe8/0x12c
[<ffffffc000508d88>] rest_init+0x7c/0x88
[<ffffffc0006bc98c>] start_kernel+0x39c/0x3b4
---[ end trace 5a3a0a43fd142b8b ]---
WARNING: CPU: 2 PID: 0 at kernel/time/clockevents.c:249 clockevents_program_event+0xf4/0x104()
Modules linked in:
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        W    L 3.19.3+ #18
Hardware name: LS1043A RDB Board (DT)
Call trace:
[<ffffffc000089148>] dump_backtrace+0x0/0x12c
[<ffffffc000089284>] show_stack+0x10/0x1c
[<ffffffc00050e2c0>] dump_stack+0x88/0xd8
[<ffffffc0000a0cb4>] warn_slowpath_common+0x94/0xcc
[<ffffffc0000a0db0>] warn_slowpath_null+0x14/0x20
[<ffffffc0000f40d0>] clockevents_program_event+0xf0/0x104
[<ffffffc0000f6044>] tick_program_event+0x28/0x34
[<ffffffc0000e9d78>] hrtimer_interrupt+0x190/0x268
[<ffffffc00041bea4>] arch_timer_handler_phys+0x28/0x38
[<ffffffc0000de1d8>] handle_percpu_devid_irq+0x74/0x98
[<ffffffc0000da388>] generic_handle_irq+0x30/0x4c
[<ffffffc0000da6a4>] __handle_domain_irq+0x60/0xb0
[<ffffffc00008141c>] gic_handle_irq+0x34/0x80
Exception stack(0xffffffc0790d7e30 to 0xffffffc0790d7f50)
7e20:                                     790d4000 ffffffc0 0070457c ffffffc0
7e40: 790d7f70 ffffffc0 00086164 ffffffc0 00000000 00000000 00000000 00000000
7e60: 7fea4b1c ffffffc0 0041bf50 ffffffc0 00000020 00000000 00000000 00000000
7e80: 7fea4c88 ffffffc0 7fea5070 ffffffc0 790c8ff0 ffffffc0 790d7d90 ffffffc0
7ea0: 005191c4 ffffffc0 005191c0 ffffffc0 00000000 00989680 00000000 00000000
7ec0: 00000008 00000000 00000000 00000000 00000001 00000000 00000007 00000000
7ee0: 0000000e 00000000 790d4000 ffffffc0 0070457c ffffffc0 007044f8 ffffffc0
7f00: 0075480a ffffffc0 00000001 00000000 00639c98 ffffffc0 005184b8 ffffffc0
7f20: 80785000 00000000 000815e0 ffffffc0 80000000 00000040 790d7f70 ffffffc0
7f40: 00086160 ffffffc0 790d7f70 ffffffc0
[<ffffffc000084da4>] el1_irq+0x64/0xd8
[<ffffffc0000d1c04>] cpu_startup_entry+0xe8/0x12c
[<ffffffc000091910>] secondary_start_kernel+0x124/0x134

Regards,
Bhupesh
