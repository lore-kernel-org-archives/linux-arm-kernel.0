From: stefan@agner.ch (Stefan Agner)
Date: Tue, 19 Jun 2018 10:16:19 +0200
Subject: Dynamic ftrace self test broken on ARM
In-Reply-To: <20180618175437.3e6c85a1@gandalf.local.home>
References: <65fb14b356bc0a414f1fe5cf5c6eb395@agner.ch>
 <20180618175437.3e6c85a1@gandalf.local.home>
Message-ID: <b9f269ed2143688c38cdcbba7367b101@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.06.2018 23:54, Steven Rostedt wrote:
> On Mon, 18 Jun 2018 23:09:04 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> Hi,
>>
>> On a ARM (i.MX 7) I noticed today that the kernel crashes after dynamic
>> ftrace self test. I tried v4.18-rc1 first, but it seems that at least
>> also v4.17 is affected.
>>
> 
> 
>> VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
>> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
>> max_idle_ns: 19112604462750000 ns
>> futex hash table entries: 512 (order: 3, 32768 bytes)
>> Running postponed tracer tests:
>> Testing tracer function: PASSED
>> Testing dynamic ftrace: PASSED
>> Testing dynamic ftrace ops #1:
>> (1 0 1 0 0)
>> (1 1 2 0 0)
>> (2 1 3 0 93620)
>> (2 2 4 0 93807) PASSED
>> Testing dynamic ftrace ops #2:
>> (1 0 1 96630 0)
>> (1 1 2 96804 0)
>> (2 1 3 1 342)
>> (2 2 4 121 462) PASSED
>> Testing ftrace recursion: PASSED
>> Testing ftrace recursion safe: PASSED
>> Testing ftrace regs: PASSED
>> Testing tracer nop: PASSED
>> Testing tracer function_graph: PASSED
>> pinctrl core: initialized pinctrl subsystem
>> Unable to handle kernel paging request at virtual address c0ca14e4
>> pgd = (ptrval)
>> [c0ca14e4] *pgd=80c1940e(bad)
>> Internal error: Oops: 80d [#1] SMP ARM
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0 #564
>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>> PC is at skb_init+0x50/0x7c
>> LR is at kmem_cache_create_usercopy+0x10c/0x320
>> pc : [<c0e63b80>]    lr : [<c023bd5c>]    psr: 60000013
>> sp : dc11be98  ip : dc11be58  fp : dc11bebc
>> r10: c0e006f0  r9 : c0e82820  r8 : c0faa8c0
>> r7 : c0e63a10  r6 : 00000000  r5 : 00000000  r4 : c0ca14e4
>> r3 : c0eb72c8  r2 : 00000000  r1 : 1ea8b000  r0 : dc0eef00
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> Control: 10c5387d  Table: 8000406a  DAC: 00000051
>> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
>> Stack: (0xdc11be98 to 0xdc11c000)
>> be80:                                                       00000018
>> 00000030
>> bea0: 00000000 c07fda4c 00000000 ffffe000 dc11bedc dc11bec0 c0e63a38
>> c0e63b3c
>> bec0: c0e5d488 c0170c64 c0fa7140 c0fa7140 dc11bf44 dc11bee0 c0103080
>> c0e63a1c
>> bee0: c0145d74 c0e006fc c0bf3c00 c0bf3ca4 c0bf3cf0 c0c03b98 00000000
>> c0bf3c7c
>> bf00: 00000001 00000001 c0bf6c04 c0cf0b68 dffffc66 00000000 00000000
>> c0fa7140
>> bf20: c0e82844 00000002 c0fa7140 c0eb6264 00000002 c0faa8c0 dc11bf94
>> dc11bf48
>> bf40: c0e011d8 c0103038 00000001 00000001 00000000 c0e006f0 00000000
>> c0f09fc0
>> bf60: c0cf0b68 000000dc c0989c58 00000000 c0989c58 00000000 00000000
>> 00000000
>> bf80: 00000000 00000000 dc11bfac dc11bf98 c0989c70 c0e00f74 00000000
>> c0989c58
>> bfa0: 00000000 dc11bfb0 c01010e8 c0989c64 00000000 00000000 00000000
>> 00000000
>> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000
>> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000
>> 00000000
>> [<c0e63b80>] (skb_init) from [<c0e63a38>] (sock_init+0x28/0xc8)
>> [<c0e63a38>] (sock_init) from [<c0103080>] (do_one_initcall+0x54/0x1e8)
>> [<c0103080>] (do_one_initcall) from [<c0e011d8>]
>> (kernel_init_freeable+0x270/0x308)
>> [<c0e011d8>] (kernel_init_freeable) from [<c0989c70>]
>> (kernel_init+0x18/0x124)
>> [<c0989c70>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>> Exception stack(0xdc11bfb0 to 0xdc11bff8)
>> bfa0:                                     00000000 00000000 00000000
>> 00000000
>> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 00000000
>> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> Code: e58d3000 e3a010b8 e3a03a42 ebcf6033 (e5840000)
>> ---[ end trace fff84001ba23c9c9 ]---
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> [    2.292924]
>> CPU1: stopping
>> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D           4.17.0 #564
>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>> [<c01128a4>] (unwind_backtrace) from [<c010d868>] (show_stack+0x20/0x24)
>> [<c010d868>] (show_stack) from [<c0975590>] (dump_stack+0x90/0xa4)
>> [<c0975590>] (dump_stack) from [<c0110608>] (handle_IPI+0x2dc/0x2fc)
>> [<c0110608>] (handle_IPI) from [<c010233c>] (gic_handle_irq+0x9c/0xa0)
>> [<c010233c>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
>> Exception stack(0xdc14df18 to 0xdc14df60)
>> df00:                                                       00000000
>> 00000324
>> df20: df957420 c011c4c0 ffffe000 c0f05d28 c0f05d6c 00000002 00000000
>> c0f05d80
>> df40: 00000000 dc14df74 dc14df78 dc14df68 c0109938 c010993c 60000013
>> ffffffff
>> [<c0101a0c>] (__irq_svc) from [<c010993c>] (arch_cpu_idle+0x48/0x4c)
>> [<c010993c>] (arch_cpu_idle) from [<c098f81c>]
>> (default_idle_call+0x30/0x3c)
>> [<c098f81c>] (default_idle_call) from [<c01566a4>] (do_idle+0x1bc/0x284)
>> [<c01566a4>] (do_idle) from [<c0156a18>] (cpu_startup_entry+0x28/0x30)
>> [<c0156a18>] (cpu_startup_entry) from [<c01100b0>]
>> (secondary_start_kernel+0x158/0x164)
>> [<c01100b0>] (secondary_start_kernel) from [<8010274c>] (0x8010274c)
>> ---[ end Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x0000000b
>>  ]---
>>
>> I tested with imx_v6_v7_defconfig and enabled the following options:
>>
>> CONFIG_DYNAMIC_FTRACE=y
>>
>> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
>>
>> CONFIG_FTRACE_MCOUNT_RECORD=y
>>
>> CONFIG_FTRACE_SELFTEST=y
>>
>> CONFIG_FTRACE_STARTUP_TEST=y
>>
>> I guess startup test should leave the kernel unencumbered?
>>
>>
> 
> I'm guessing that it boots fine with CONFIG_FTRACE_STARTUP_TEST=n? Can
> you try disable the tracers to see if it's the function graph or
> function tracer that is causing the issue? That is, turn off
> CONFIG_FUNCTION_GRAPH_TRACER and test it again, and if that crashes,
> turn off CONFIG_FUNCTION_TRACER to make sure the crash goes away there
> too.

Without CONFIG_FTRACE_STARTUP_TEST the kernel boots fine.

CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
# CONFIG_SCHED_TRACER is not set
CONFIG_FTRACE_STARTUP_TEST=y

Crashes with the same stack trace.

# CONFIG_FUNCTION_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_FTRACE_STARTUP_TEST=y

Runs tracer tests and boots fine.

--
Stefan
