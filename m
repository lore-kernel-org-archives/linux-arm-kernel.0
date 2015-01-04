From: panand@redhat.com (Pratyush Anand)
Date: Sun, 04 Jan 2015 19:20:11 +0530
Subject: [RFC 3/8] Kernel/uprobe: Define arch_uprobe_exception_notify
 as __weak
In-Reply-To: <20150102174314.GA6761@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <c40bb09f1edad6899c3855eb56bf4a4f541c49f7.1420038188.git.panand@redhat.com>
 <20150102174314.GA6761@redhat.com>
Message-ID: <54A94513.20808@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 02 January 2015 11:13 PM, Oleg Nesterov wrote:
> On 12/31, Pratyush Anand wrote:
>>
>> Both ARM and ARM64 handle uprobe exceptions through their own hooks.So
>> nothing to be done in arch_uprobe_exception_notify except to return
>> NOTIFY_DONE. Implement this as weak default function and remove
>> definition from arm arch code.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>   arch/arm/kernel/uprobes.c |  6 ------
>>   kernel/events/uprobes.c   | 18 ++++++++++++++++++
>>   2 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/kernel/uprobes.c b/arch/arm/kernel/uprobes.c
>> index 56adf9c1fde0..0f3663ca82fc 100644
>> --- a/arch/arm/kernel/uprobes.c
>> +++ b/arch/arm/kernel/uprobes.c
>> @@ -178,12 +178,6 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
>>   	instruction_pointer_set(regs, utask->vaddr);
>>   }
>>
>> -int arch_uprobe_exception_notify(struct notifier_block *self,
>> -				 unsigned long val, void *data)
>> -{
>> -	return NOTIFY_DONE;
>> -}
>
> I agree, this is ugly. But I disagree with this change.
>
> I think we should simply kill uprobe_exception_nb and unexport
> arch_uprobe_exception_notify on x86/powerpc, and in fact I was going to do
> this a long ago.
>
> I'll send the patch later. Until then please add the dummy arch_uprobe_exception_notify()
> like arch/arm does, to make the generic code happy.

OK.

~Pratyush
>
> Oleg.
>
