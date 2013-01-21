From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 21 Jan 2013 09:50:18 -0500
Subject: [kvmarm] [PATCH v6 14/15] KVM: ARM: Power State Coordination
 Interface implementation
In-Reply-To: <75f43582106716efe7c8f1360e58732e@localhost>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175918.29147.318.stgit@ubuntu> <50F81EF4.4020507@arm.com>
 <CANM98q+z2tj72qFtjDF1ZpKMGs876=hRLpKTEwYKnpCMzdpErg@mail.gmail.com>
 <75f43582106716efe7c8f1360e58732e@localhost>
Message-ID: <CANM98q+6wd6YmK--Xb7=rKm7AyHE94pBnC_XsP+6UmuP31CziQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 5:04 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Sun, 20 Jan 2013 18:35:51 -0500, Christoffer Dall
> <c.dall@virtualopensystems.com> wrote:
>> On Thu, Jan 17, 2013 at 10:55 AM, Marc Zyngier <marc.zyngier@arm.com>
>> wrote:
>>> On 16/01/13 17:59, Christoffer Dall wrote:
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> Implement the PSCI specification (ARM DEN 0022A) to control
>>>> virtual CPUs being "powered" on or off.
>>>>
>>>> PSCI/KVM is detected using the KVM_CAP_ARM_PSCI capability.
>>>>
>>>> A virtual CPU can now be initialized in a "powered off" state,
>>>> using the KVM_ARM_VCPU_POWER_OFF feature flag.
>>>>
>>>> The guest can use either SMC or HVC to execute a PSCI function.
>>>>
>>>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>>
>>> A few bits went wrong when you reworked this patch. See below.
>
> [...]
>
>>>> @@ -443,13 +445,17 @@ static int handle_hvc(struct kvm_vcpu *vcpu,
>>>> struct kvm_run *run)
>>>>       trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
>>>>                     vcpu->arch.hsr & HSR_HVC_IMM_MASK);
>>>>
>>>> +     if (kvm_psci_call(vcpu))
>>>> +             return 1;
>>>> +
>>>>       return 1;
>>>
>>> No undef injection if there is no PSCI match?
>
> You haven't addressed this issue in you patch.
>
right, well, it's actually quite nice not having it give you an
undefined exception when it logs the trace event. The psci protocol
relies on a confirmation in form of a return value anyhow, so it was
actually on purpose to remove it, so you can do things like easily
measure exit times or probe places in the guest.

Let me know what you think.
