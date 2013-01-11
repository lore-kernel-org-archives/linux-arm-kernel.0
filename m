From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Jan 2013 17:43:11 +0000
Subject: [kvmarm] [PATCH v2 2/2] ARM: KVM: Power State Coordination
 Interface implementation
In-Reply-To: <CANM98qJ2ZSwxMWFRWiunTQtoV7iFb3fn3Cf6VWvOndBcU=+Tmg@mail.gmail.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
 <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
 <20130111171232.GH23505@n2100.arm.linux.org.uk>	<50F04AD5.6020703@arm.com>
 <CANM98qJ2ZSwxMWFRWiunTQtoV7iFb3fn3Cf6VWvOndBcU=+Tmg@mail.gmail.com>
Message-ID: <50F04F2F.80306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/13 17:33, Christoffer Dall wrote:
> On Fri, Jan 11, 2013 at 12:24 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 11/01/13 17:12, Russell King - ARM Linux wrote:
>>> On Thu, Jan 10, 2013 at 04:06:45PM +0000, Marc Zyngier wrote:
>>>> +int kvm_psci_call(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>>>> +    unsigned long val;
>>>> +
>>>> +    switch (psci_fn) {
>>>> +    case KVM_PSCI_FN_CPU_OFF:
>>>> +            kvm_psci_vcpu_off(vcpu);
>>>> +            val = KVM_PSCI_RET_SUCCESS;
>>>> +            break;
>>>> +    case KVM_PSCI_FN_CPU_ON:
>>>> +            val = kvm_psci_vcpu_on(vcpu);
>>>> +            break;
>>>> +    case KVM_PSCI_FN_CPU_SUSPEND:
>>>> +    case KVM_PSCI_FN_MIGRATE:
>>>> +            val = KVM_PSCI_RET_NI;
>>>> +            break;
>>>> +
>>>> +    default:
>>>> +            return -1;
>>>> +    }
>>>> +
>>>> +    *vcpu_reg(vcpu, 0) = val;
>>>> +    return 0;
>>>> +}
>>>
>>> We were discussing recently on #kernel about kernel APIs and the way that
>>> our integer-returning functions pretty much use 0 for success, and -errno
>>> for failures, whereas our pointer-returning functions are a mess.
>>>
>>> And above we have something returning -1 to some other chunk of code outside
>>> this compilation unit.  That doesn't sound particularly clever to me.
>>
>> The original code used to return -EINVAL, see:
>> https://lists.cs.columbia.edu/pipermail/kvmarm/2013-January/004509.html
>>
>> Christoffer (Cc-ed) didn't like this, hence the -1. I'm happy to revert
>> the code to its original state though.
>>
> I don't want to return -EINVAL, because for the rest of the KVM code
> this would mean kill the guest.
> 
> The convention used in other archs of KVM as well as for ARM is that
> the handle_exit functions return:
> 
> -ERRNO: Error, report this error to user space
> 0: Everything is fine, but return to user space to let it do I/O
> emulation and whatever it wants to do
> 1: Everything is fine, return directly to the guest without going to user space

That is assuming we propagate the handle_exit convention down to the
leaf calls, and I object to that. The 3 possible values only apply to
handle_exit, and we should keep that convention as local as possible,
because this is the odd case.

> And then you do:
> if (handle_something() == 0)
>     return 1;
> 
> which I thought was confusing, so I said make the function a bool, to
> avoid the confusion, like Rusty did for all the coprocessor emulation
> functions.

I don't see a compelling reason to propagate this convention to areas
that do not require it. In the PSCI case, we have a basic
handled/not-handled state, the later indicating the reason. The exit
handling functions can convert the error codes to whatever the run loop
requires.

> There are obviously other ways to handle the "return 1" case, like
> having an extra state that you carry around, and we can change all the
> code to do that, but I just don't think it's worth it, as we are in
> fact quite close to the existing kernel API.

-- 
Jazz is not dead. It just smells funny...
