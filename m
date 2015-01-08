From: panand@redhat.com (Pratyush Anand)
Date: Thu, 08 Jan 2015 23:21:32 +0530
Subject: [RFC 6/8] ARM64: Handle TRAP_HWBRKPT for user mode as well
In-Reply-To: <20150108170152.GS11583@arm.com>
References: <cover.1420038188.git.panand@redhat.com>
 <1e0a9e778669bb2a2e40bf101eff8ae85110ce54.1420038188.git.panand@redhat.com>
 <20150102180523.GC6761@redhat.com> <20150108170152.GS11583@arm.com>
Message-ID: <54AEC3A4.9010709@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 08 January 2015 10:31 PM, Will Deacon wrote:
> On Fri, Jan 02, 2015 at 06:05:23PM +0000, Oleg Nesterov wrote:
>> Let me repeat once again that I know absolutely nothing about arm* ;)
>>
>> On 12/31, Pratyush Anand wrote:
>>>
>>> uprobe registers a handler at step_hook. So, single_step_handler now
>>> checks for user mode as well if there is a valid hook.
>>>
>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>> ---
>>>   arch/arm64/kernel/debug-monitors.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>>> index b056369fd47d..2676b8655241 100644
>>> --- a/arch/arm64/kernel/debug-monitors.c
>>> +++ b/arch/arm64/kernel/debug-monitors.c
>>> @@ -236,6 +236,9 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>>>   	if (!reinstall_suspended_bps(regs))
>>>   		return 0;
>>>
>>> +	if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
>>> +		return 0;
>>> +
>>>   	if (user_mode(regs)) {
>>>   		info.si_signo = SIGTRAP;
>>>   		info.si_errno = 0;
>>> @@ -251,9 +254,6 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>>>   		 */
>>>   		user_rewind_single_step(current);
>>>   	} else {
>>> -		if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
>>> -			return 0;
>>> -
>>
>> Agreed, we need something like this change...
>>
>> But did you verify that it can't break other users of register_step_hook() ?
>> The current handlers do not check user_mode() == F, they assume that they
>> can't be called otherwise.
>>
>> If this all is correct, please explain why in the changelog.
>
> I think you're right, and kgdb will need fixing with this change.

OK, I will fix kgdb  too when I will send next revision.

~Pratyush

>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
