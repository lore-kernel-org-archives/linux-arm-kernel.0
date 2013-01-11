From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 11 Jan 2013 13:18:13 -0500
Subject: [kvmarm] [PATCH v2 2/2] ARM: KVM: Power State Coordination
 Interface implementation
In-Reply-To: <50F05562.3070107@arm.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
 <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
 <20130111171232.GH23505@n2100.arm.linux.org.uk>
 <50F04AD5.6020703@arm.com>
 <CANM98qJ2ZSwxMWFRWiunTQtoV7iFb3fn3Cf6VWvOndBcU=+Tmg@mail.gmail.com>
 <50F04F2F.80306@arm.com>
 <CANM98qLRsdFGxU6S5q2EqtCAmK8fOnbGWi8qXBktyuRkSaPAJg@mail.gmail.com>
 <50F05562.3070107@arm.com>
Message-ID: <CANM98qKXFazk6COcKB1x6dfi5R+ooJNCk+wv=wD=2vdSOCXD0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 1:09 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 11/01/13 17:48, Christoffer Dall wrote:
>> On Fri, Jan 11, 2013 at 12:43 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 11/01/13 17:33, Christoffer Dall wrote:
>>>> On Fri, Jan 11, 2013 at 12:24 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>> On 11/01/13 17:12, Russell King - ARM Linux wrote:
>>>>>> On Thu, Jan 10, 2013 at 04:06:45PM +0000, Marc Zyngier wrote:
>>>>>>> +int kvm_psci_call(struct kvm_vcpu *vcpu)
>>>>>>> +{
>>>>>>> +    unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>>>>>>> +    unsigned long val;
>>>>>>> +
>>>>>>> +    switch (psci_fn) {
>>>>>>> +    case KVM_PSCI_FN_CPU_OFF:
>>>>>>> +            kvm_psci_vcpu_off(vcpu);
>>>>>>> +            val = KVM_PSCI_RET_SUCCESS;
>>>>>>> +            break;
>>>>>>> +    case KVM_PSCI_FN_CPU_ON:
>>>>>>> +            val = kvm_psci_vcpu_on(vcpu);
>>>>>>> +            break;
>>>>>>> +    case KVM_PSCI_FN_CPU_SUSPEND:
>>>>>>> +    case KVM_PSCI_FN_MIGRATE:
>>>>>>> +            val = KVM_PSCI_RET_NI;
>>>>>>> +            break;
>>>>>>> +
>>>>>>> +    default:
>>>>>>> +            return -1;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    *vcpu_reg(vcpu, 0) = val;
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>
>>>>>> We were discussing recently on #kernel about kernel APIs and the way that
>>>>>> our integer-returning functions pretty much use 0 for success, and -errno
>>>>>> for failures, whereas our pointer-returning functions are a mess.
>>>>>>
>>>>>> And above we have something returning -1 to some other chunk of code outside
>>>>>> this compilation unit.  That doesn't sound particularly clever to me.
>>>>>
>>>>> The original code used to return -EINVAL, see:
>>>>> https://lists.cs.columbia.edu/pipermail/kvmarm/2013-January/004509.html
>>>>>
>>>>> Christoffer (Cc-ed) didn't like this, hence the -1. I'm happy to revert
>>>>> the code to its original state though.
>>>>>
>>>> I don't want to return -EINVAL, because for the rest of the KVM code
>>>> this would mean kill the guest.
>>>>
>>>> The convention used in other archs of KVM as well as for ARM is that
>>>> the handle_exit functions return:
>>>>
>>>> -ERRNO: Error, report this error to user space
>>>> 0: Everything is fine, but return to user space to let it do I/O
>>>> emulation and whatever it wants to do
>>>> 1: Everything is fine, return directly to the guest without going to user space
>>>
>>> That is assuming we propagate the handle_exit convention down to the
>>> leaf calls, and I object to that. The 3 possible values only apply to
>>> handle_exit, and we should keep that convention as local as possible,
>>> because this is the odd case.
>>
>> I don't agree - it requires you to carefully follow a potentially deep
>> call trace to make sense of what it does, and worse, it's directly
>> misleading in the case of KVM/ARM. So either change it everywhere and
>> have a consistent calling convention or adhere to what we do elsewhere
>> and use the bool.
>
> Sorry, but I do not buy this.
>
> In this particular case, the meaning of the value returned has nothing
> to do with the handle_exit convention. We never return to user space,
> let alone signaling an error.
>

But that is by no means obvious.

> Trying to force all the code in this convention makes it actually harder
> to review, because this is the exception in the kernel. This is why I
> suggest keeping the handle_exit return convention at this exact point,
> and not impose it on anything else.
>

Ok, then come up with a nicer convention, but using -EINVAL to mean I
did not handle this one, maybe someone else will handle it, and it's
not an error is definitely not easy to read.  What then if another
function called from the same caller could actually return an error,
would you have a switch case on the return value checking for EINVAL
vs. EFAULT?

I repeat: what's the problem with a bool for this particular case,
which would make it look like all the other sub-calls of handle exit
functions - could we be consistent here?

-Christoffer
