From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 20 Nov 2015 15:23:24 +0000
Subject: [PATCH v9 1/6] target-arm: kvm64 - introduce kvm_arm_init_debug()
In-Reply-To: <CAFEAcA8bdjYaDiCParJt8jVe+720+tzh4CuKD2YGfHeo2UJNcQ@mail.gmail.com>
References: <1447345251-22625-1-git-send-email-alex.bennee@linaro.org>
 <1447345251-22625-2-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA-u3ACj=99NkTRsEL=2KA6LETeAmEf+5Vo03gz0GMh5Zw@mail.gmail.com>
 <CAFEAcA8bdjYaDiCParJt8jVe+720+tzh4CuKD2YGfHeo2UJNcQ@mail.gmail.com>
Message-ID: <877flcitjn.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 November 2015 at 15:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 12 November 2015 at 16:20, Alex Benn?e <alex.bennee@linaro.org> wrote:
>>> As we haven't always had guest debug support we need to probe for it.
>>> Additionally we don't do this in the start-up capability code so we
>>> don't fall over on old kernels.
>>>
>>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>>> ---
>>>  target-arm/kvm64.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
>>> index ceebfeb..d087794 100644
>>> --- a/target-arm/kvm64.c
>>> +++ b/target-arm/kvm64.c
>>> @@ -25,6 +25,22 @@
>>>  #include "internals.h"
>>>  #include "hw/arm/arm.h"
>>>
>>> +static bool have_guest_debug;
>>> +
>>> +/**
>>> + * kvm_arm_init_debug()
>>> + * @cs: CPUState
>>> + *
>>> + * Check for guest debug capabilities.
>>> + *
>>> + */
>>> +static void kvm_arm_init_debug(CPUState *cs)
>>> +{
>>> +    have_guest_debug = kvm_check_extension(cs->kvm_state,
>>> +                                           KVM_CAP_SET_GUEST_DEBUG);
>>> +    return;
>>> +}
>>> +
>>>  static inline void set_feature(uint64_t *features, int feature)
>>>  {
>>>      *features |= 1ULL << feature;
>>> @@ -121,6 +137,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>      }
>>>      cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>>>
>>> +    kvm_arm_init_debug(cs);
>>> +
>>>      return kvm_arm_init_cpreg_list(cpu);
>>>  }
>>
>> I assume in practice the kernel guarantees that either all
>> CPUs have the SET_GUEST_DEBUG cap, or none do :-)
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> ...except I've just noticed that nothing else in this patchset
> ever reads the have_guest_debug bool we just set, so what is
> the purpose of this patch?

Oops, maybe to point out my stupidity ;-)

But yes the SET_GUEST_DEBUG cap is kernel wide.

>
> thanks
> -- PMM


-- 
Alex Benn?e
