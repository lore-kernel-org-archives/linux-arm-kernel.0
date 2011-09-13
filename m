From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Mon, 12 Sep 2011 18:17:18 -0700
Subject: [RFC PATCH] genirq: set pending flag for disabled level interrupt
In-Reply-To: <alpine.LFD.2.02.1109021046240.2723@ionos>
References: <1312820566-5842-1-git-send-email-adharmap@codeaurora.org>
	<alpine.LFD.2.02.1109021046240.2723@ionos>
Message-ID: <4E6EAF1E.6060608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2011 01:47 AM, Thomas Gleixner wrote:
>
> On Mon, 8 Aug 2011, Abhijeet Dharmapurikar wrote:
>
>> For hardware which has no wakeup source configuration facility, it needs
>> its wakeup interrupts unmasked.
>> If a wakeup edge interrupt triggered while the system was suspending the
>> edge flow handler marks it pending and masks the interrupt. The kernel
>> checks pending flag on wakeup interrupts and aborts suspend if one is set.
>>
>> If a wakeup level interrupt triggered while the system was suspending the
>> level flow handler masks the interrupt without setting the pending flag.
>> Suspend won't be aborted. This is fine as it is expected that a level
>> triggered interrupt will stay triggered and cause the system to resume.
>> This however doesn't work on chips that don't have wakeup configuration
>> in hardware because such chips need that interrupt unmasked for causing
>> a resume.
>>
>> Address that shortcoming by making the level flow handler set the pending
>> flag if a wakeup interrupt controlled by such a chip is triggered while
>> it is suspended.
>
> And how is that supposed to work ?
>
> check_irq_resend()
> {
>          if (irq_settings_is_level(desc))
>                  return;
> ...
>

Hmm, I missed this check. Sorry.

I will send another patch that extends check_wakeup_irqs().

>> Signed-off-by: Abhijeet Dharmapurikar<adharmap@codeaurora.org>
>> ---
>> If a level interrupt irq triggered right while the system was doing
>> suspend_noirqs, the level flow handler will mask that interrupt and when the
>> system went in to power collapse the interrupt controller did not wakeup the
>> phone. The interrupt controller needs an interrupt triggered and masked to
>> wakeup the phone - it does not have any wakeup interrupt configuration.
>> The solution presented here is to mark that level triggered
>> wakeup interrupt pending for chips with IRQCHIP_MASK_ON_SUSPEND. This will cause
>> check_wakeup_irqs to abort suspend.
>> Other solution would be to unmask such level interrupt in check_wakeup_irqs()
>> but that seemed like I was expanding and complicating check_wakeup_irqs()
>> duties - let me know if you think otherwise.
>> Note that we cannot unmask the interrupt in the level flow handler, that will
>> cause an interrupt storm.
>>
>>   include/linux/irq.h |    4 +++-
>>   kernel/irq/chip.c   |   16 +++++++++++++++-
>>   2 files changed, 18 insertions(+), 2 deletions(-)


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
