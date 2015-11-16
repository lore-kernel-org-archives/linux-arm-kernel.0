From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 16 Nov 2015 10:56:51 +0900
Subject: arm64 function_graph tracer panic with CONFIG_DYNAMIC_FTRACE
In-Reply-To: <56457A4B.601@linaro.org>
References: <20151112104243.GF5627@e104818-lin.cambridge.arm.com>
 <56457A4B.601@linaro.org>
Message-ID: <564937E3.3090501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

On 11/13/2015 02:51 PM, AKASHI Takahiro wrote:
> Catalin,
> (add lakml back to Cc)
>
> On 11/13/2015 01:01 AM, Catalin Marinas wrote:
>  > On Fri, Nov 13, 2015 at 12:00:42AM +0900, AKASHI Takahiro wrote:
>  >> If possible, please try again with "select HAVE_FUNCTION_GRAPH_FP_TEST" added
>  >> to CONFIG_ARM64.
>  >> It will insert an additional check. I hope this will help.
>  >
>  > So it looks the the frame is off by some amount:
>
> I was able to reproduce the problem on hikey, too.
>
>  > # echo function_graph > /sys/kernel/debug/tracing/current_tracer
>  > Bad frame pointer: expected ffffffc976b3bd50, received ffffffc976b3be60
>
> The difference of fp's was 0x110(sizeof(pt_reg_t)=0x120).
> It seems that an interrupt happened here (and we might have unwound one extra frame?).
>
>  >    from func psci_cpu_suspend return to ffffffc00008d058
>
> Always in the same place.
>
>  > ------------[ cut here ]------------
>  > WARNING: at /work/Linux/linux-2.6-aarch64/kernel/trace/trace_functions_graph.c:223
>  > Modules linked in:
>  >
>  > CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.3.0+ #584
>  > Hardware name: Juno (DT)
>  > task: ffffffc976b22f00 ti: ffffffc976b38000 task.ti: ffffffc976b38000
>  > PC is at ftrace_return_to_handler+0x11c/0x150
>  > LR is at ftrace_return_to_handler+0x11c/0x150
>  > pc : [<ffffffc000172034>] lr : [<ffffffc000172034>] pstate: 800001c5
>  > sp : ffffffc976b3bdd0
>  > x29: ffffffc976b3bdd0 x28: ffffffc0006c9000
>  > x27: ffffffc000a29f20 x26: ffffffc976b3bf70
>  > x25: 000000cc2c13e054 x24: 0000000000000004
>  > x23: ffffffc000aeb790 x22: 0000000000000002
>  > x21: ffffffc975503200 x20: ffffffc000aeb850
>  > x19: 0000000000000002 x18: ffffffc000b3a920
>  > x17: 0000000000000000 x16: 0000000000000000
>  > x15: ffffffc000b3a5bf x14: 3739636666666666
>  > x13: 6620646576696563 x12: 6572202c30356462
>  > x11: 3362363739636666 x10: 00000000000000fc
>  > x9 : ffffffc9768070c0 x8 : 0000000000001dd0
>  > x7 : ffffffc9760f4c80 x6 : ffffffc9760f4c00
>  > x5 : 00000000000084c0 x4 : 0000000000000001
>  > x3 : ffffffc976b3bc50 x2 : 0000000000000001
>  > x1 : 000000000000007f x0 : 000000000000007f
>  >
>  > ---[ end trace ac97c44ba7dabcce ]---
>  > Call trace:
>  > [<ffffffc000172034>] ftrace_return_to_handler+0x11c/0x150
>  > [<ffffffc0000924bc>] return_to_handler+0x1c/0x40
>  > [<ffffffc0000924a0>] return_to_handler+0x0/0x40
>  > [<ffffffc0000924a0>] return_to_handler+0x0/0x40
>  > [<ffffffc0000924a0>] return_to_handler+0x0/0x40
>  > [<ffffffc0000924a0>] return_to_handler+0x0/0x40
>  > [<ffffffc0000924a0>] return_to_handler+0x0/0x40
>  > [<ffffffc0000924a0>] return_to_handler+0x0/0x40
>
> These call stacks were:
>    (psci_cpu_suspend)
>    psci_suspend_finisher
>    (cpu_suspend_enter?)
>    cpu_suspend
>    cpu_psci_cpu_suspend
>    arm_cpuidle_suspend
>    arm_enter_idle_state
>    cpuidle_enter_state
>    cpuidle_enter
>    call_cpuidle
>    (cpu_startup_entry?)
>
> and if cpuidle is turned off(cpuidle.off=1), the panic never happens.
> That is all what I know at this moment.

I think I fixed the problem.
As you can see stack dump traces above, psci_cpu_suspend() and psci_suspend_finisher()
are called in cpu suspend path, but they never return in cpu resume path and
cpu_suspend() will resume directly via cpu_resume(). So those two functions should not be
ftrace'd.

Please try this patch:
----8<----
 From c3aaaab52cf51879ae8e112f80790075425ba9be Mon Sep 17 00:00:00 2001
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Mon, 16 Nov 2015 10:29:21 +0900
Subject: [PATCH] arm64: disable ftrace in suspend path


Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
  arch/arm64/kernel/psci.c    |    2 +-
  arch/arm64/kernel/suspend.c |    2 +-
  drivers/firmware/psci.c     |    2 +-
  3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f67f35b..78414d7 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -178,7 +178,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
  }
  #endif

-static int psci_suspend_finisher(unsigned long index)
+static int notrace psci_suspend_finisher(unsigned long index)
  {
  	u32 *state = __this_cpu_read(psci_power_state);

diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 44ca414..12280ef 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -19,7 +19,7 @@ extern int __cpu_suspend_enter(unsigned long arg, int (*fn)(unsigned long));
   * save_ptr: address of the location where the context physical address
   *           must be saved
   */
-void notrace __cpu_suspend_save(struct cpu_suspend_ctx *ptr,
+void __cpu_suspend_save(struct cpu_suspend_ctx *ptr,
  				phys_addr_t *save_ptr)
  {
  	*save_ptr = virt_to_phys(ptr);
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 838298f..8fce2c5 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -129,7 +129,7 @@ static u32 psci_get_version(void)
  	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
  }

-static int psci_cpu_suspend(u32 state, unsigned long entry_point)
+static int notrace psci_cpu_suspend(u32 state, unsigned long entry_point)
  {
  	int err;
  	u32 fn;
-- 
1.7.9.5
---->8----

There are some other functions which are called by cpu_suspend(), e.g. psci_system_suspend().
Should we apply a similar fix to them?

Thanks,
-Takahiro AKASHI


> -Takahiro AKASHI
>
>
>  > [<ffffffc000090208>] secondary_start_kernel+0x130/0x158
>  > Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  > pgd = ffffffc000b68000
>  > [00000000] *pgd=00000009f69ea003, *pud=00000009f69ea003, *pmd=00000009f69eb003, *pte=006000002c010707
>  > Internal error: Oops: 96000006 [#1] PREEMPT SMP
>    [snip]
>
>
> On 11/12/2015 07:42 PM, Catalin Marinas wrote:
>> Hi Takahiro,
>>
>> I was trying to assess what's working/not working in ftrace on arm64 and
>> whether your recent patches are meant for 4.4 or can wait until 4.5.
>> However, without any patches applied on a 4.3 kernel, enabling the
>> function_graph tracer when CONFIG_DYNAMIC_FTRACE is enabled panics the
>> kernel. Strangely, it does not happen if only a single CPU is on.
>> However, with function_graph tracer on, onlining a second CPU leads to a
>> similar panic.
>>
>> Below is the kernel panic with 2 CPUs online on a Juno board. There
>> isn't much stack trace information for CPU 5 where the fault happened,
>> the frame pointer (x29) seems corrupted as well. Any idea? Thanks.
>>
>> # echo function_graph > /sys/kernel/debug/tracing/current_tracer
>> swapper/5[0]: undefined instruction: pc=ffffffc000a46698
>> Code: 0009ccf8 ffffffc0 00000000 00000000 (00000030)
>> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 5 PID: 0 Comm: swapper/5 Not tainted 4.3.0 #574
>> Hardware name: Juno (DT)
>> task: ffffffc976b23ac0 ti: ffffffc976b3c000 task.ti: ffffffc976b3c000
>> PC is at cpu_online_bits+0x0/0x8
>> LR is at cpu_online_bits+0x0/0x8
>> pc : [<ffffffc000a46698>] lr : [<ffffffc000a46698>] pstate: 600001c5
>> sp : ffffffc976b3ff40
>> x29: 0000000000000002 x28: ffffffc000100c0c
>> x27: ffffffc000aeb790 x26: ffffffc9758d5800
>> x25: 0000000000000002 x24: ffffffc0000924a0
>> x23: ffffffc976b3ff40 x22: ffffffc00056841c
>> x21: ffffffc000a25b80 x20: ffffffc000aeb790
>> x19: ffffffc9758d5800 x18: 0000000000000000
>> x17: 0000000000000000 x16: 0000000000000000
>> x15: 0000000000000000 x14: 0000000000000000
>> x13: 0000000000000000 x12: 0000000034d5d91d
>> x11: 0000000000000000 x10: 0000000000001000
>> x9 : ffffffc9768070c0 x8 : 00000000000007d8
>> x7 : 0000001b280eb7c4 x6 : 0000000000000015
>> x5 : 000000000000000a x4 : ffffffc0792a4990
>> x3 : ffffffffffffffa1 x2 : ffffffc0792a4800
>> x1 : ffffffc0000949e0 x0 : ffffffffffffffa1
>>
>> Process swapper/5 (pid: 0, stack limit = 0xffffffc976b3c020)
>> Stack: (0xffffffc976b3ff40 to 0xffffffc976b40000)
>> ff40: ffffffc976b3ff70 ffffffc0000924a0 ffffffc976b3c000 ffffffc000a46000
>> ff60: ffffffc000b20000 0000001b27d716c0 ffffffc976b3ffd0 ffffffc000090208
>> ff80: 0000000000000005 0000000000000e12 ffffffc000b306a0 0000000000000000
>> ffa0: 0000000000000000 0000000000000000 0000000080b65000 0000000080b68000
>> ffc0: ffffffc0000827f0 0000000000000000 0000000000000000 00000000800827dc
>> ffe0: 0000000000000000 0000000000000000 068824085611a721 280b8a0b05808446
>> Call trace:
>> Code: 0009ccf8 ffffffc0 00000000 00000000 (00000030)
>> ---[ end trace 702bb2ed35464601 ]---
>> Kernel panic - not syncing: Attempted to kill the idle task!
>> CPU4: stopping
>> CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D         4.3.0 #574
>> Hardware name: Juno (DT)
>> Call trace:
>> [<ffffffc00008aaa8>] dump_backtrace+0x0/0x150
>> [<ffffffc00008ac1c>] show_stack+0x24/0x30
>> [<ffffffc0003b21a0>] dump_stack+0x90/0xd0
>> [<ffffffc000090880>] handle_IPI+0x280/0x290
>> [<ffffffc00008255c>] gic_handle_irq+0x94/0xb0
>> Exception stack(0xffffffc976b3bd70 to 0xffffffc976b3be90)
>> bd60:                                   0000001b2ed1ee8c ffffffc000aeb850
>> bd80: ffffffc976b3bec0 ffffffc0005681dc 0000000080000145 ffffffc00009244c
>> bda0: 0000000000000000 0000000000000001 ffffffc976b38000 0000000000000003
>> bdc0: ffffffc976b38000 ffffffc000a282a8 ffffffc976b38000 ffffffc0000ecb28
>> bde0: 00000000000006ed ffffffc9768070c0 00000000000007e0 ffffffc0006d04a8
>> be00: 0000000000000001 0000000000005a0e 0000000000000001 ffffffc0006d04a8
>> be20: 0000000000000000 0000000000000000 0000000000000001 0000001b2ed1ee8c
>> be40: ffffffc000aeb850 ffffffc9758d5600 0000000000000000 ffffffc000aeb790
>> be60: 0000000000000004 0000001b2e40a7ec ffffffc976b3bf70 ffffffc000a29f20
>> be80: ffffffc0006c9000 ffffffc976b3bec0
>> [<ffffffc0000855ac>] el1_irq+0x6c/0xe0
>> [<ffffffc00056842c>] cpuidle_enter+0x34/0x48
>> [<ffffffc000100c30>] call_cpuidle+0x48/0x80
>> [<ffffffc000100e90>] cpu_startup_entry+0x228/0x308
>> [<ffffffc000090208>] secondary_start_kernel+0x130/0x158
>> ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>>
