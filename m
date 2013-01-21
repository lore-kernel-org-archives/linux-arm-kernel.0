From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Jan 2013 19:08:45 +0100
Subject: [kvmarm] [PATCH v6 14/15] KVM: ARM: Power State Coordination
 Interface implementation
In-Reply-To: <CANM98qKDQrfSZC8knciajyeZWcX0CGObuYPrFA_RTEpUzBhBow@mail.gmail.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175918.29147.318.stgit@ubuntu> <50F81EF4.4020507@arm.com>
 <CANM98q+z2tj72qFtjDF1ZpKMGs876=hRLpKTEwYKnpCMzdpErg@mail.gmail.com>
 <75f43582106716efe7c8f1360e58732e@localhost>
 <CANM98q+6wd6YmK--Xb7=rKm7AyHE94pBnC_XsP+6UmuP31CziQ@mail.gmail.com>
 <832da358616729fd6a5d6522682b022f@localhost>
 <CANM98qKDQrfSZC8knciajyeZWcX0CGObuYPrFA_RTEpUzBhBow@mail.gmail.com>
Message-ID: <dfd76d65ce8e16c6792a47262d27dda2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jan 2013 12:54:22 -0500, Christoffer Dall
<c.dall@virtualopensystems.com> wrote:
> On Mon, Jan 21, 2013 at 12:43 PM, Marc Zyngier <marc.zyngier@arm.com>
> wrote:
>> On Mon, 21 Jan 2013 09:50:18 -0500, Christoffer Dall
>> <c.dall@virtualopensystems.com> wrote:
>>> On Mon, Jan 21, 2013 at 5:04 AM, Marc Zyngier <marc.zyngier@arm.com>
>> wrote:
>>>> On Sun, 20 Jan 2013 18:35:51 -0500, Christoffer Dall
>>>> <c.dall@virtualopensystems.com> wrote:
>>>>> On Thu, Jan 17, 2013 at 10:55 AM, Marc Zyngier
<marc.zyngier@arm.com>
>>>>> wrote:
>>>>>> On 16/01/13 17:59, Christoffer Dall wrote:
>>>>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>>>>
>>>>>>> Implement the PSCI specification (ARM DEN 0022A) to control
>>>>>>> virtual CPUs being "powered" on or off.
>>>>>>>
>>>>>>> PSCI/KVM is detected using the KVM_CAP_ARM_PSCI capability.
>>>>>>>
>>>>>>> A virtual CPU can now be initialized in a "powered off" state,
>>>>>>> using the KVM_ARM_VCPU_POWER_OFF feature flag.
>>>>>>>
>>>>>>> The guest can use either SMC or HVC to execute a PSCI function.
>>>>>>>
>>>>>>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>>>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>>>>>
>>>>>> A few bits went wrong when you reworked this patch. See below.
>>>>
>>>> [...]
>>>>
>>>>>>> @@ -443,13 +445,17 @@ static int handle_hvc(struct kvm_vcpu *vcpu,
>>>>>>> struct kvm_run *run)
>>>>>>>       trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
>>>>>>>                     vcpu->arch.hsr & HSR_HVC_IMM_MASK);
>>>>>>>
>>>>>>> +     if (kvm_psci_call(vcpu))
>>>>>>> +             return 1;
>>>>>>> +
>>>>>>>       return 1;
>>>>>>
>>>>>> No undef injection if there is no PSCI match?
>>>>
>>>> You haven't addressed this issue in you patch.
>>>>
>>> right, well, it's actually quite nice not having it give you an
>>> undefined exception when it logs the trace event. The psci protocol
>>> relies on a confirmation in form of a return value anyhow, so it was
>>> actually on purpose to remove it, so you can do things like easily
>>> measure exit times or probe places in the guest.
>>
>> If that's for tracing purpose, why don't you allocate another
hypercall?
>> Returning to the guest without signalling that nothing was executed
seems
>> very wrong to me.
>>
> hmm, yeah, maybe you're right.
> 
> I was just debating with myself whether an undefined isn't too rough.
> It made sense when we didn't have any kind of handling of hvc, but now
> an hvc isn't really an undefined instruction, and if we assume that we
> have a series of hypercalls, multiplexed by a number in r0, but you
> don't really know what's available on your VM host, it also seems very
> wrong to have an ABI that says, try it, and if it's not implemented
> handle the undefined exception.... Know what I mean? perhaps we should
> return -1 in r0 instead or something.

Aside from the API discovery discussion, my thoughts on the HVC semantics:
The way I see it, HVC effectively becomes an undefined instruction if the
upper layer doesn't know about the requested service. This is very
different from "I know what you mean, but I can't do it now". We should
really tell the guest "I have no clue what you're talking about", because
something is utterly wrong. This is a case of not being able to give the VM
the semantics it expects, and trying to paper over it.

Now, returning something in r0 could have been a possibility if it was
specified in the ARM ARM, and it is not. So we can already forget about it.

> We can of course argue that we should have an HVC discovery API or
> that everything should be set in device tree, but the latter doesn't
> really fit well with the way we do things now with qemu at least.

I still have hope for QEMU to move forward and eventually generate a DT
based on the host capabilities.

        M.
-- 
Fast, cheap, reliable. Pick two.
