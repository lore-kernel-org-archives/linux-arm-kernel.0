From: anup@brainfault.org (Anup Patel)
Date: Sun, 28 Apr 2013 17:18:03 +0530
Subject: [PATCH] ARM: KVM: Allow host virt timer irq to be different from
 guest timer virt irq
In-Reply-To: <459ddcd84aa2644e21efbbca56ff6870@localhost>
References: <1367050086-2902-1-git-send-email-anup.patel@linaro.org>
 <73b473edb8a9ea9a09f1df68345903d7@localhost>
 <CAAhSdy101B=4cK9nnLtQa7rG15D0CT_DsWD6k3FZ1EYz2nAfEw@mail.gmail.com>
 <459ddcd84aa2644e21efbbca56ff6870@localhost>
Message-ID: <CAAhSdy2kRBExvCZgbgXfrgOE5cvU7-mwpe8g-sWUmiN7P717Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 28, 2013 at 3:05 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Sat, 27 Apr 2013 17:49:31 +0530, Anup Patel <anup@brainfault.org>
> wrote:
>> On Sat, Apr 27, 2013 at 2:49 PM, Marc Zyngier <marc.zyngier@arm.com>
> wrote:
>>> On Sat, 27 Apr 2013 13:38:06 +0530, Anup Patel <anup.patel@linaro.org>
>>> wrote:
>>>> The arch_timer irq numbers (or PPI numbers) are implementation
> dependent
>>>> so, the host virtual timer irq number can be different from guest
>>> virtual
>>>> timer irq number.
>>>>
>>>> This patch ensures that host virtual timer irq number is read from DTB
>>> and
>>>> guest virtual timer irq is determined based on vcpu target type.
>
> [...]
>
>>>>
>>>> +int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
>>>> +                      const struct kvm_irq_level *irq)
>>>> +{
>>>> +     struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>>>> +
>>>> +     /*
>>>> +      * The vcpu timer irq number cannot be determined in
>>>> +      * kvm_timer_vcpu_init() because it is called much before
>>>> +      * kvm_vcpu_set_target(). To handle this, we determine
>>>> +      * vcpu timer irq number when the vcpu is resetted.
>>>> +      */
>>>> +     timer->irq = irq;
>>>> +
>>>> +     /*
>>>> +      * Make sure timer is disarmed.
>>>> +      */
>>>> +     timer_disarm(timer);
>>>
>>> What is that for? Timer has not been started yet, for the lack of an
> IRQ.
>>> Actually, the vcpu has never ran. Why would you need to disarm it?
>>
>> This is in case a vcpu is resetted  at runtime from user space or psci.
>> Also, since we have named it timer_vcpu_reset(), it made sense to
>> atleast disarm the timer.
>
> I would agree if the timer had a clearly defined reset state. The ARM ARM
> says that the timer register reset values are UNKNOWN. So at CPU reset, the
> timer is allowed to be in any possible state, including having a pending
> interrupt.
>
> This means the guest already has to deal with the situation, and I'd
> rather not give additional guarantees. Please remove this call from your
> next version of this patch.

Ok, I will remove it.

>
> Thanks,
>
>         M.
> --
> Fast, cheap, reliable. Pick two.

--Anup
