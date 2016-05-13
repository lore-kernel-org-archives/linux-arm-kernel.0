From: dave.long@linaro.org (David Long)
Date: Fri, 13 May 2016 16:02:12 -0400
Subject: [PATCH v12 00/10] arm64: Add kernel probes (kprobes) support
In-Reply-To: <5733E9E0.1060504@huawei.com>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <573350B2.4010701@arm.com> <5733E9E0.1060504@huawei.com>
Message-ID: <573632C4.9010501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2016 10:26 PM, Li Bin wrote:
>
>
> on 2016/5/11 23:33, James Morse wrote:
>> Hi David,
>>
>> On 27/04/16 19:52, David Long wrote:
>>> From: "David A. Long" <dave.long@linaro.org>
>>>
>>> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
>>> first seen in October 2013. This version attempts to address concerns raised by
>>> reviewers and also fixes problems discovered during testing.
>>>
>>> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
>>> and return probes(kretprobes) support for ARM64.
>>>
>>> The kprobes mechanism makes use of software breakpoint and single stepping
>>> support available in the ARM v8 kernel.
>>
>> I applied this series on v4.6-rc7, and built the sample kprobes. They work fine,
>> unless I throw ftrace into the mix too.
>>
>> I enabled the function_graph tracer, then tried to load the jprobe example module:
>> -------------------------%<-------------------------
>> root at ubuntu:/sys/kernel/debug/tracing# insmod /root/jprobe_example.ko
>> Planted jprobe at ffffff80080c8f20, handler addr ffffff8000bb3000
>> root at ubuntu:/sys/kernel/debug/tracing# jprobe: clone_flags = 0x1200011, stack_st
>> art = 0x0 stack_size = 0x0
>> Bad mode in Synchronous Abort handler detected, code 0x86000005 -- IABT (current
>>   EL)
>> CPU: 5 PID: 1047 Comm: systemd-udevd Not tainted 4.6.0-rc7+ #4064
>> Hardware name: ARM Juno development board (r1) (DT)
>> task: ffffffc975948300 ti: ffffffc974e4c000 task.ti: ffffffc974e4c000
>> PC is at 0x0
>> LR is at 0x0
>>
>> pc : [<0000000000000000>] lr : [<0000000000000000>] pstate: 60000145
>> sp : ffffffc974e4ff00
>> x29: 0000000001200011 x28: ffffffc974e4c000
>> x27: ffffff80088d0000 x26: 00000000000000dc
>> x25: 0000000000000120 x24: 0000000000000015
>> x23: 0000000060000000 x22: 0000007fa1b40e60
>> x21: 0000007fa1ce70d0 x20: 0000000000000000
>> x19: 0000000000000000 x18: 0000000000000a03
>> x17: 0000007fa1b40d90 x16: ffffff80080c9708
>> x15: 003b9aca00000000 x14: 0000007fddb7e5c0
>> x13: 0000007fa1b40e2c x12: 0000000000d00ff0
>> x11: ffffff8009c4d000 x10: ffffff800920c000
>> x9 : ffffff8008f5c000 x8 : ffffffc976c06800
>> x7 : 000000000006daf2 x6 : 0000000000000015
>> x5 : 0000000000000004 x4 : ffffffc96e8690a0
>> x3 : 0000001ed7cbab74 x2 : ffffffc96e869000
>> x1 : 0000000000000000 x0 : 0000000000000000
>>
>> Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP
>> Modules linked in: jprobe_example
>> CPU: 5 PID: 1047 Comm: systemd-udevd Not tainted 4.6.0-rc7+ #4064
>> Hardware name: ARM Juno development board (r1) (DT)
>> task: ffffffc975948300 ti: ffffffc974e4c000 task.ti: ffffffc974e4c000
>> PC is at 0x0
>> LR is at 0x0
>>
>> pc : [<0000000000000000>] lr : [<0000000000000000>] pstate: 60000145
>> sp : ffffffc974e4ff00
>> x29: 0000000001200011 x28: ffffffc974e4c000
>> x27: ffffff80088d0000 x26: 00000000000000dc
>> x25: 0000000000000120 x24: 0000000000000015
>> x23: 0000000060000000 x22: 0000007fa1b40e60
>> x21: 0000007fa1ce70d0 x20: 0000000000000000
>> x19: 0000000000000000 x18: 0000000000000a03
>> x17: 0000007fa1b40d90 x16: ffffff80080c9708
>> x15: 003b9aca00000000 x14: 0000007fddb7e5c0
>> x13: 0000007fa1b40e2c x12: 0000000000d00ff0
>> x11: ffffff8009c4d000 x10: ffffff800920c000
>> x9 : ffffff8008f5c000 x8 : ffffffc976c06800
>> x7 : 000000000006daf2 x6 : 0000000000000015
>> x5 : 0000000000000004 x4 : ffffffc96e8690a0
>> x3 : 0000001ed7cbab74 x2 : ffffffc96e869000
>> x1 : 0000000000000000 x0 : 0000000000000000
>>
>> Process systemd-udevd (pid: 1047, stack limit = 0xffffffc974e4c020)
>> Stack: (0xffffffc974e4ff00 to 0xffffffc974e50000)
>> ff00: 0000000000000417 0000007fa1ce76f0 00000000000000dc 0000000000000417
>> ff20: 00000000ffffffff 0000007fddb7ecf8 0000000000000005 ffffffffffffffff
>> ff40: 00000000ff000001 003b9aca00000000 000000555b3868b0 0000007fa1b40d90
>> ff60: 0000000000000a03 0000007fddb7e5c0 0000000000000000 0000007fddb7e5e0
>> ff80: 000000555b358000 000000558f56f0e0 0000000000000000 000000558f574f00
>> ffa0: 000000558f574f00 00000000000004fa 000000558f56f010 0000007fddb7e600
>> ffc0: 0000007fa1b40e2c 0000007fddb7e5c0 0000007fa1b40e60 0000000060000000
>> ffe0: 0000000001200011 00000000000000dc 0004000084000200 0800000002000000
>> Call trace:
>> [<          (null)>]           (null)
>> Code: bad PC value
>> ---[ end trace 35d24aad799c2941 ]---
>> -------------------------%<-------------------------
>>
>
> To solve this, it should pause function tracing before the jprobe handler is called
> and unpause it before it returns back to the function it probed.
>
> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
> index db2d95c..b21ed00 100644
> --- a/arch/arm64/kernel/kprobes.c
> +++ b/arch/arm64/kernel/kprobes.c
> @@ -714,6 +714,7 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>
>          instruction_pointer_set(regs, (long)jp->entry);
>          preempt_disable();
> +       pause_graph_tracing();
>          return 1;
>   }
>
> @@ -757,6 +758,7 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>                          show_regs(regs);
>                          BUG();
>                  }
> +               unpause_graph_tracing();
>                  *regs = kcb->jprobe_saved_regs;
>                  memcpy((void *)stack_addr, kcb->jprobes_stack,
>                         MIN_STACK_SIZE(stack_addr));
>
>
> Li Bin
>
>>
>> Thanks,
>>
>>
>> James


Thanks for the suggested fix.

-dl
