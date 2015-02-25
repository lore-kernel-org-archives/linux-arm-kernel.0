From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 25 Feb 2015 19:46:49 +0800
Subject: [RFC PATCH v3 00/26] Early kprobe: enable kprobes at very early
 booting stage.
In-Reply-To: <54EDADD6.5070404@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
 <54E6B139.20909@hitachi.com> <54EDADD6.5070404@huawei.com>
Message-ID: <54EDB629.4020908@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/25 19:11, Wang Nan wrote:
> On 2015/2/20 11:59, Masami Hiramatsu wrote:
>> Hi,
>>
>> Sorry for replying late.
>>
>> (2015/02/13 14:39), Wang Nan wrote:
>>> I fell very sorry for people who reviewed my v2 patch series yesterday
>>> at https://lkml.org/lkml/2015/2/12/234 because I didn't provide enough
>>> information in commit log. This v3 patch series add those missing
>>> commit messages. There are also 2 small fix based on v2:
>>>
>>>  1. Fixes ftrace_sort_mcount_area. Original patch doesn't work for module.
>>>  2. Wraps setting of kprobes_initialized in stop_machine() context.
>>
>> From the viewpoint of the maintenance, it seems over-engineered and
>> not general implementation. Please reconsider just initializing breakpoint
>> handler in earlier stage. Since those exceptions may happen anywhere,
>> those trap handlers setup very early stage. E.g. on x86, setup_arch()
>> setup early_trap_init() at beginning. So we just need to initialize
>> kprobes earlier.
> 
> I tried as your suggestion. For x86, int3 handler doesn't work correctly until
> trap_init(). I don't have enough time to look into this problem today (and I don't
> familiar with x86 architecture). Could you please have a look on it?
> 
> Thank you.
> 

Hi Masami,

Sorry for the noise. I have futher information may be useful.

I initialize kprobe and probed an instruction with int3 between setup_arch() and
trap_init(). It doesn't work at first. By dumping __log_buf[] I fount it reports NULL pointer panic.
With some random test I found following patch, which makes it works (looks like) correctly.

However I think there must be some reason to set dpl to '3' instead of '0' (set_mni_gate
use 0 as dpl). Do you have any suggestion on it?

Thank you.

------------- The patch ---------------
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9d2073e..ac29277 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -925,9 +925,9 @@ dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
 /* Set of traps needed for early debugging. */
 void __init early_trap_init(void)
 {
-       set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+       set_intr_gate_ist(X86_TRAP_DB, &debug, 0);
        /* int3 can be called from all */
-       set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+       set_intr_gate_ist(X86_TRAP_BP, &int3, 0);
 #ifdef CONFIG_X86_32
        set_intr_gate(X86_TRAP_PF, page_fault);
 #endif
