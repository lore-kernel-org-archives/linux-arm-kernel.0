From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 12 Sep 2018 14:03:43 +0100
Subject: [PATCH v5 05/27] arm64: Use daifflag_restore after bp_hardening
In-Reply-To: <71bb5289-b381-65da-c609-fa4a08640425@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
 <641119b9-3466-817d-3d6b-dd710c646b49@arm.com>
 <8f200315-1db9-1905-71ae-cb4269450b7c@arm.com>
 <71bb5289-b381-65da-c609-fa4a08640425@arm.com>
Message-ID: <1c6ede25-052f-c31e-255d-86055ee1e568@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/09/18 13:28, James Morse wrote:
> On 12/09/18 12:11, Julien Thierry wrote:
>> On 12/09/18 11:32, James Morse wrote:
>>> On 28/08/18 16:51, Julien Thierry wrote:
>>>> For EL0 entries requiring bp_hardening, daif status is kept at
>>>> DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
>>>> are enabled through local_irq_enable().
>>>>
>>>> Before using local_irq_* functions, daifflags should be properly restored
>>>> to a state where IRQs are enabled.
>>>
>>>> Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.
>>>
>>> Is this just for symmetry, or are you going on to add something to the daifflags
>>> state that local_irq_* functions won't change? (if so, could you allude to that
>>> in the commit message)
> 
>> What happens is that once we use ICC_PMR_EL1, local_irq_enable will not touch
>> PSR.I. And we are coming back from an entry where PSR.I was kept to 1 so
>> local_irq_enable was not actually enabling the interrupts. On the otherhand,
>> restore will affect both.
> 
> Got it. Thanks!
> 
> Does this mean stop_machine()s local_save_flags()/local_irq_restore() will not
> be symmetric around __apply_alternatives_multi_stop()?
> I see you add alternatives in these in patch 15, but I haven't got that far yet)
> 

It's a good point but it should be fine.
The changes to the irqflags make save/restore takes everything into 
consideration (PMR + PSR.I) because of situtations like this, 
enable/disable only toggle the PMR (so the goal is to not have PSR.I set 
before reaching path calling enable/disable).
Maybe I should add a comment for this in asm/irqflags.f when I add the 
alternatives, so that at least arch code can be wary of this.

> 
>> Another option is to have the asm macro "enable_da_f" also switch to PMR usage
>> (i.e. "just keep normal interrupts disabled"). Overall it would probably be
>> easier to reason with, but I'm just unsure whether it is acceptable to receive a
>> Pseudo NMI before having applied the bp_hardening.
> 
> Wouldn't this give the interrupt controller a headache? I assume IRQs really are
> masked when handle_arch_irq is called. (I know nothing about the gic)
> 

Yes, you're right, I missed that da_f gets unmasked right before the 
irq_handler... So unless I do some special case for irqs, enable_da_f is 
not the way to go.

Thanks,

-- 
Julien Thierry
