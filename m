From: anup@brainfault.org (Anup Patel)
Date: Thu, 27 Nov 2014 16:24:26 +0530
Subject: [RFC PATCH 0/6] ARM64: KVM: PMU infrastructure support
In-Reply-To: <5476FFAF.2010601@arm.com>
References: <CAMJs5B8VqS2-3dhSX+PBaQruzyXiYwaYRQ7vvWEMrHbvbjn+9A@mail.gmail.com>
 <CAAhSdy3iyMpXLh1Qq-TqZ-1W368kG0Oz9iE2McnJkYbA9ZaNPg@mail.gmail.com>
 <20141119152952.GB9776@lvm>
 <CAAhSdy2rQf-26SjeEspcc+LgwmhDr+QeYOOSyOUApF+0-8WdeA@mail.gmail.com>
 <20141121095922.GR19598@cbox>
 <CAAhSdy37W-iK2QznzVtwvZx427xDmm3kGEzN7KdOhvXvBuwwQQ@mail.gmail.com>
 <20141121114950.GB3401@cbox>
 <CAAhSdy3-+5T0sOEGHLtHbPQJ+3hXdZxL=695dq7PJ2J0qmVbTg@mail.gmail.com>
 <20141124143753.GO3401@cbox>
 <CAAhSdy0+Z8o6dx=Bq+Ep7ybQpTpj+QNJm4oJbKa8yCM7WS8oxg@mail.gmail.com>
 <20141125134239.GI31297@cbox>
 <CAAhSdy32G+-BVQk-=dWjfM1S-cytGavp4qq942m=3y7HUudguw@mail.gmail.com>
 <5476FFAF.2010601@arm.com>
Message-ID: <CAAhSdy3US4H9DZLDmwawR6D22GUpQ8H5NqrZ8XvYJjhsnPzzRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 4:10 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 27/11/14 10:22, Anup Patel wrote:
>> On Tue, Nov 25, 2014 at 7:12 PM, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>>> On Tue, Nov 25, 2014 at 06:17:03PM +0530, Anup Patel wrote:
>>>> Hi Christoffer,
>>>>
>>>> On Mon, Nov 24, 2014 at 8:07 PM, Christoffer Dall
>>>> <christoffer.dall@linaro.org> wrote:
>>>>> On Mon, Nov 24, 2014 at 02:14:48PM +0530, Anup Patel wrote:
>>>>>> On Fri, Nov 21, 2014 at 5:19 PM, Christoffer Dall
>>>>>> <christoffer.dall@linaro.org> wrote:
>>>>>>> On Fri, Nov 21, 2014 at 04:06:05PM +0530, Anup Patel wrote:
>>>>>>>> Hi Christoffer,
>>>>>>>>
>>>>>>>> On Fri, Nov 21, 2014 at 3:29 PM, Christoffer Dall
>>>>>>>> <christoffer.dall@linaro.org> wrote:
>>>>>>>>> On Thu, Nov 20, 2014 at 08:17:32PM +0530, Anup Patel wrote:
>>>>>>>>>> On Wed, Nov 19, 2014 at 8:59 PM, Christoffer Dall
>>>>>>>>>> <christoffer.dall@linaro.org> wrote:
>>>>>>>>>>> On Tue, Nov 11, 2014 at 02:48:25PM +0530, Anup Patel wrote:
>>>>>>>>>>>> Hi All,
>>>>>>>>>>>>
>>>>>>>>>>>> I have second thoughts about rebasing KVM PMU patches
>>>>>>>>>>>> to Marc's irq-forwarding patches.
>>>>>>>>>>>>
>>>>>>>>>>>> The PMU IRQs (when virtualized by KVM) are not exactly
>>>>>>>>>>>> forwarded IRQs because they are shared between Host
>>>>>>>>>>>> and Guest.
>>>>>>>>>>>>
>>>>>>>>>>>> Scenario1
>>>>>>>>>>>> -------------
>>>>>>>>>>>>
>>>>>>>>>>>> We might have perf running on Host and no KVM guest
>>>>>>>>>>>> running. In this scenario, we wont get interrupts on Host
>>>>>>>>>>>> because the kvm_pmu_hyp_init() (similar to the function
>>>>>>>>>>>> kvm_timer_hyp_init() of Marc's IRQ-forwarding
>>>>>>>>>>>> implementation) has put all host PMU IRQs in forwarding
>>>>>>>>>>>> mode.
>>>>>>>>>>>>
>>>>>>>>>>>> The only way solve this problem is to not set forwarding
>>>>>>>>>>>> mode for PMU IRQs in kvm_pmu_hyp_init() and instead
>>>>>>>>>>>> have special routines to turn on and turn off the forwarding
>>>>>>>>>>>> mode of PMU IRQs. These routines will be called from
>>>>>>>>>>>> kvm_arch_vcpu_ioctl_run() for toggling the PMU IRQ
>>>>>>>>>>>> forwarding state.
>>>>>>>>>>>>
>>>>>>>>>>>> Scenario2
>>>>>>>>>>>> -------------
>>>>>>>>>>>>
>>>>>>>>>>>> We might have perf running on Host and Guest simultaneously
>>>>>>>>>>>> which means it is quite likely that PMU HW trigger IRQ meant
>>>>>>>>>>>> for Host between "ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);"
>>>>>>>>>>>> and "kvm_pmu_sync_hwstate(vcpu);" (similar to timer sync routine
>>>>>>>>>>>> of Marc's patchset which is called before local_irq_enable()).
>>>>>>>>>>>>
>>>>>>>>>>>> In this scenario, the updated kvm_pmu_sync_hwstate(vcpu)
>>>>>>>>>>>> will accidentally forward IRQ meant for Host to Guest unless
>>>>>>>>>>>> we put additional checks to inspect VCPU PMU state.
>>>>>>>>>>>>
>>>>>>>>>>>> Am I missing any detail about IRQ forwarding for above
>>>>>>>>>>>> scenarios?
>>>>>>>>>>>>
>>>>>>>>>>> Hi Anup,
>>>>>>>>>>
>>>>>>>>>> Hi Christoffer,
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I briefly discussed this with Marc.  What I don't understand is how it
>>>>>>>>>>> would be possible to get an interrupt for the host while running the
>>>>>>>>>>> guest?
>>>>>>>>>>>
>>>>>>>>>>> The rationale behind my question is that whenever you're running the
>>>>>>>>>>> guest, the PMU should be programmed exclusively with guest state, and
>>>>>>>>>>> since the PMU is per core, any interrupts should be for the guest, where
>>>>>>>>>>> it would always be pending.
>>>>>>>>>>
>>>>>>>>>> Yes, thats right PMU is programmed exclusively for guest when
>>>>>>>>>> guest is running and for host when host is running.
>>>>>>>>>>
>>>>>>>>>> Let us assume a situation (Scenario2 mentioned previously)
>>>>>>>>>> where both host and guest are using PMU. When the guest is
>>>>>>>>>> running we come back to host mode due to variety of reasons
>>>>>>>>>> (stage2 fault, guest IO, regular host interrupt, host interrupt
>>>>>>>>>> meant for guest, ....) which means we will return from the
>>>>>>>>>> "ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);" statement in the
>>>>>>>>>> kvm_arch_vcpu_ioctl_run() function with local IRQs disabled.
>>>>>>>>>> At this point we would have restored back host PMU context and
>>>>>>>>>> any PMU counter used by host can trigger PMU overflow interrup
>>>>>>>>>> for host. Now we will be having "kvm_pmu_sync_hwstate(vcpu);"
>>>>>>>>>> in the kvm_arch_vcpu_ioctl_run() function (similar to the
>>>>>>>>>> kvm_timer_sync_hwstate() of Marc's IRQ forwarding patchset)
>>>>>>>>>> which will try to detect PMU irq forwarding state in GIC hence it
>>>>>>>>>> can accidentally discover PMU irq pending for guest while this
>>>>>>>>>> PMU irq is actually meant for host.
>>>>>>>>>>
>>>>>>>>>> This above mentioned situation does not happen for timer
>>>>>>>>>> because virtual timer interrupts are exclusively used for guest.
>>>>>>>>>> The exclusive use of virtual timer interrupt for guest ensures that
>>>>>>>>>> the function kvm_timer_sync_hwstate() will always see correct
>>>>>>>>>> state of virtual timer IRQ from GIC.
>>>>>>>>>>
>>>>>>>>> I'm not quite following.
>>>>>>>>>
>>>>>>>>> When you call kvm_pmu_sync_hwstate(vcpu) in the non-preemtible section,
>>>>>>>>> you would (1) capture the active state of the IRQ pertaining to the
>>>>>>>>> guest and (2) deactive the IRQ on the host, then (3) switch the state of
>>>>>>>>> the PMU to the host state, and finally (4) re-enable IRQs on the CPU
>>>>>>>>> you're running on.
>>>>>>>>>
>>>>>>>>> If the host PMU state restored in (3) causes the PMU to raise an
>>>>>>>>> interrupt, you'll take an interrupt after (4), which is for the host,
>>>>>>>>> and you'll handle it on the host.
>>>>>>>>>
>>>>>>>> We only switch PMU state in assembly code using
>>>>>>>> kvm_call_hyp(__kvm_vcpu_run, vcpu)
>>>>>>>> so whenever we are in kvm_arch_vcpu_ioctl_run() (i.e. host mode)
>>>>>>>> the current hardware PMU state is for host. This means whenever
>>>>>>>> we are in host mode the host PMU can change state of PMU IRQ
>>>>>>>> in GIC even if local IRQs are disabled.
>>>>>>>>
>>>>>>>> Whenever we inspect active state of PMU IRQ in the
>>>>>>>> kvm_pmu_sync_hwstate() function using irq_get_fwd_state() API.
>>>>>>>> Here we are not guaranteed that IRQ forward state returned by the
>>>>>>>> irq_get_fwd_state() API is for guest only.
>>>>>>>>
>>>>>>>> The above situation does not manifest for virtual timer because
>>>>>>>> virtual timer registers are exclusively accessed by Guest and
>>>>>>>> virtual timer interrupt is only for Guest (never used by Host).
>>>>>>>>
>>>>>>>>> Whenever you schedule the guest VCPU again, you'll (a) disable
>>>>>>>>> interrupts on the CPU, (b) restore the active state of the IRQ for the
>>>>>>>>> guest, (c) restore the guest PMU state, (d) switch to the guest with
>>>>>>>>> IRQs enabled on the CPU (potentially).
>>>>>>>>
>>>>>>>> Here too, while we are between step (a) and step (b) the PMU HW
>>>>>>>> context is for host and any PMU counter can overflow. The step (b)
>>>>>>>> can actually override the PMU IRQ meant for Host.
>>>>>>>>
>>>>>>> Can you not simply switch the state from C-code after capturing the IRQ
>>>>>>> state then?  Everything should be accessible from EL1, right?
>>>>>>
>>>>>> Yes, I think that would be the only option. This also means I will need
>>>>>> to re-implement context switching for doing it in C-code.
>>>>>
>>>>> Yes, you'd add some inline assembly in the C-code to access the
>>>>> registers I guess.  Only thing I thought about after writing my original
>>>>> mail is whether you'll be counting events while context-swtiching and
>>>>> running on the host, which you actually don't want to.  Not sure if
>>>>> there's a better way to avoid that.
>>>>>
>>>>>>
>>>>>> What about the scenario1 which I had mentioned?
>>>>>>
>>>>>
>>>>> You have to consider enabling/disabling forwarding and setting/clearing
>>>>> the active state is part of the guest PMU state and all of it has to be
>>>>> context-switched.
>>>>
>>>> I found one more issue.
>>>>
>>>> If PMU irq is PPI then enabling/disabling forwarding will not
>>>> work because irqd_set_irq_forwarded() function takes irq_data
>>>> as argument which is member of irq_desc and irq_desc for PPIs
>>>> is not per_cpu. This means we cannot call irqd_set_irq_forwarded()
>>>> simultaneously from different host CPUs.
>>>>
>>
>> Hi Marc,
>>
>>> I'll let Marc answer this one and if this still applies to his view of
>>> how the next version of the forwarding series will look like.
>
> I'm looking at it at the moment.
>
> I'm inclined to say that we should fix the forwarding code to allow
> individual PPIs to be forwarded. This is a bit harder than what we're
> doing at the moment, but that's possible.
>
> Of course, that complicates the code a bit, as we have to make sure
> we're not premptable at that time.
>
> What do you think?

Currently, irqd_set_irq_forwarded() is lockless.

It would be great if we can update irqd_set_irq_forwarded() for PPIs
such that it remains irqd_set_irq_forwarded() lockless so that we
dont have much overhead when we enable/disable forwarding
state.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Regards,
Anup
