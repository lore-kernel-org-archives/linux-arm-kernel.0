From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 15 Jan 2013 09:32:29 -0500
Subject: [PATCH v5 2/4] ARM: KVM: arch_timers: Add guest timer core support
In-Reply-To: <50F53868.4060208@arm.com>
References: <20130108184259.46758.17939.stgit@ubuntu>
 <20130108184320.46758.56628.stgit@ubuntu>
 <20130114151837.GC18935@mudshark.cambridge.arm.com>
 <CANM98qJZH0q-TU942pA363g4h-CENUPiA=b5D0hJyBwrHQ0g7A@mail.gmail.com>
 <50F53868.4060208@arm.com>
Message-ID: <CANM98q+5hLwJ463ZxdN6WKMYSvU8BvGVy0=EcP8MGY4UTtEzkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 6:07 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 14/01/13 19:19, Christoffer Dall wrote:
>> On Mon, Jan 14, 2013 at 10:18 AM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Tue, Jan 08, 2013 at 06:43:20PM +0000, Christoffer Dall wrote:
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> Add some the architected timer related infrastructure, and support timer
>>>> interrupt injection, which can happen as a resultof three possible
>>>> events:
>>>>
>>>> - The virtual timer interrupt has fired while we were still
>>>>   executing the guest
>>>> - The timer interrupt hasn't fired, but it expired while we
>>>>   were doing the world switch
>>>> - A hrtimer we programmed earlier has fired
>>>
>>> [...]
>>>
>>>> +void kvm_timer_sync_to_cpu(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +       struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>>>> +
>>>> +       /*
>>>> +        * We're about to run this vcpu again, so there is no need to
>>>> +        * keep the background timer running, as we're about to
>>>> +        * populate the CPU timer again.
>>>> +        */
>>>> +       timer_disarm(timer);
>>>> +}
>>>> +
>>>> +void kvm_timer_sync_from_cpu(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +       struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>>>> +       cycle_t cval, now;
>>>> +       u64 ns;
>>>> +
>>>> +       /* Check if the timer is enabled and unmasked first */
>>>> +       if ((timer->cntv_ctl & 3) != 1)
>>>> +               return;
>>>> +
>>>> +       cval = timer->cntv_cval;
>>>> +       now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
>>>> +
>>>> +       BUG_ON(timer_is_armed(timer));
>>>> +
>>>> +       if (cval <= now) {
>>>> +               /*
>>>> +                * Timer has already expired while we were not
>>>> +                * looking. Inject the interrupt and carry on.
>>>> +                */
>>>> +               kvm_timer_inject_irq(vcpu);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       ns = cyclecounter_cyc2ns(timecounter->cc, cval - now);
>>>> +       timer_arm(timer, ns);
>>>> +}
>>>
>>> Please use flush/sync terminology to match the rest of arch/arm/.
>>>
>> ok, the following fixes this for both timers and the vgic:
>>
>> commit 1b68f39459dbc797f6766c103edf2c1053984161
>> Author: Christoffer Dall <c.dall@virtualopensystems.com>
>> Date:   Mon Jan 14 14:16:31 2013 -0500
>>
>>     KVM: ARM: vgic: use sync/flush terminology
>>
>>     Use sync/flush for saving state to/from CPUs to be consistent with
>>     other uses in arch/arm.
>
> Sync and flush on their own are pretty inexpressive. Consider changing
> it to {flush,sync}_hwstate, so we're consistent with what VFP does.
>
sure
