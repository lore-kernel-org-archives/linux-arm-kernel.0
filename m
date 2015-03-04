From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 4 Mar 2015 12:39:48 +0800
Subject: [PATCH 3/3] early kprobes: x86: don't try to recover ftraced
 instruction before ftrace get ready.
In-Reply-To: <54F67DC9.2040707@hitachi.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
 <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
 <1425359345-38714-4-git-send-email-wangnan0@huawei.com>
 <20150303170633.GG3703@dhcp128.suse.cz> <54F66CF7.9010606@huawei.com>
 <54F67DC9.2040707@hitachi.com>
Message-ID: <54F68C94.20003@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/4 11:36, Masami Hiramatsu wrote:
> (2015/03/04 11:24), Wang Nan wrote:
>> On 2015/3/4 1:06, Petr Mladek wrote:
>>> On Tue 2015-03-03 13:09:05, Wang Nan wrote:
>>>> Before ftrace convertin instruction to nop, if an early kprobe is
>>>> registered then unregistered, without this patch its first bytes will
>>>> be replaced by head of NOP, which may confuse ftrace.
>>>>
>>>> Actually, since we have a patch which convert ftrace entry to nop
>>>> when probing, this problem should never be triggered. Provide it for
>>>> safety.
>>>>
>>>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>>>> ---
>>>>  arch/x86/kernel/kprobes/core.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
>>>> index 87beb64..c7d304d 100644
>>>> --- a/arch/x86/kernel/kprobes/core.c
>>>> +++ b/arch/x86/kernel/kprobes/core.c
>>>> @@ -225,6 +225,9 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
>>>>  	struct kprobe *kp;
>>>>  	unsigned long faddr;
>>>>  
>>>> +	if (!kprobes_on_ftrace_initialized)
>>>> +		return addr;
>>>
>>> This is not correct. The function has to return a buffer with the original
>>> code also when it is modified by normal kprobes. If it is a normal
>>> Kprobe, it reads the current code and replaces the first byte (INT3
>>> instruction) with the saved kp->opcode.
>>>
>>>> +
>>>>  	kp = get_kprobe((void *)addr);
>>>>  	faddr = ftrace_location(addr);
>>>
>>> IMHO, the proper fix might be to replace the above line with
>>>
>>> 	if (kprobes_on_ftrace_initialized)
>>> 		faddr = ftrace_location(addr);
>>> 	else
>>> 		faddr = 0UL;
>>>
>>> By other words, it might pretend that it is not a ftrace location
>>> when the ftrace is not ready yet.
>>>
>>
>> Thanks for your reply. I'll follow your suggection in my next version. I change
>> it as follow to enable the checking.
>>
>> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
>> index 4e3d5a9..3241677 100644
>> --- a/arch/x86/kernel/kprobes/core.c
>> +++ b/arch/x86/kernel/kprobes/core.c
>> @@ -234,6 +234,20 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
>> 	 */
>> 	if (WARN_ON(faddr && faddr != addr))
>> 		return 0UL;
>> +
>> +	/*
>> +	 * If ftrace is not ready yet, pretend this is not an ftrace
>> +	 * location, because currently the target instruction has not
>> +	 * been replaced by a NOP yet. When ftrace trying to convert
>> +	 * it to NOP, kprobe should be notified and the kprobe data
>> +	 * should be fixed at that time.
>> +	 *
>> +	 * Since it is possible that an early kprobe already on that
>> +	 * place, don't return addr directly.
>> +	 */
>> +	if (likely(kprobes_on_ftrace_initialized))
>> +		faddr = 0UL;
>> +
>> 	/*
>> 	 * Use the current code if it is not modified by Kprobe
>> 	 * and it cannot be modified by ftrace
>>
> 
> This is better, but I don't think we need bool XXX_initialized flags
> for each subfunctions. Those should be serialized.
> 
> Thank you,
> 

For this specific case, calling __recover_probed_insn() is mandatory for
can_boost(). However, we can disallow early kprobes to be unregistered before
ftrace is ready, and let ftrace fix all inconsistency by calling
kprobe_on_ftrace_get_old_insn(). Which will make things simpler, and constrain
the using scope of kprobes_on_ftrace_initialized to kernel/kprobes.c. The
cost is unable to do smoke test for early ftrace because it will remove all
kprobe before returning. I think it should be acceptable. What do you think?

Thank you.
