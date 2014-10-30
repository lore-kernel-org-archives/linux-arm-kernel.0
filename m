From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Thu, 30 Oct 2014 17:01:56 +0530
Subject: [PATCH 2/3] arm64: psci: fix cpu_suspend to check idle state type
 for index
In-Reply-To: <20141030101946.GA17843@red-moon>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
 <1414641338-25279-2-git-send-email-amit.daniel@samsung.com>
 <20141030101946.GA17843@red-moon>
Message-ID: <CADGdYn7J7eUkCZAGx+gjei4OSPBdLmrnhy1YwtkBqiEgEvyJUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 3:49 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Amit,
>
> On Thu, Oct 30, 2014 at 03:55:37AM +0000, Amit Daniel Kachhap wrote:
>> This fix rectifies the psci cpu_suspend to check the C-state type
>> corresponding to the requested index.
>
> Can you reword the commit log please ?
>
> "This fix rectifies the psci cpu_suspend implementation to check the
> PSCI power state parameter type field associated with the requested idle
> state index."
>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  arch/arm64/kernel/psci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index 2178d6e..4ebc146 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -530,7 +530,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>>       if (WARN_ON_ONCE(!index || !state))
>>               return -EINVAL;
>>
>> -     if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
>> +     if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
>>               ret = psci_ops.cpu_suspend(state[index - 1], 0);
>>       else
>>               ret = __cpu_suspend(index, psci_suspend_finisher);
>> --
>> 1.9.1
>
> Can you resend it as a single patch (ie this patch does not apply if
> patch 1 is missing, and I am not sure we need patch 1) and send it to
> Catalin and Will to merge it asap ?

Ok sure.

>
> Please add my:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> Thanks,
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
