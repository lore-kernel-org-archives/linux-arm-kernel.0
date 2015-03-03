From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 03 Mar 2015 16:30:54 +0000
Subject: [PATCH 1/6] target-arm: kvm: save/restore mp state
In-Reply-To: <CAFEAcA8SaBuH6izzuD6CmknSU9mbQPo0YNO=knTgRCPZ2EvXcQ@mail.gmail.com>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-2-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA9oWeYGYcGtf8So6VrYLMXjWr4FiZ2tS+jBnDtv87jAKw@mail.gmail.com>
 <8761ai73j1.fsf@linaro.org> <54F595C0.5060004@redhat.com>
 <CAFEAcA8SaBuH6izzuD6CmknSU9mbQPo0YNO=knTgRCPZ2EvXcQ@mail.gmail.com>
Message-ID: <87zj7u59hd.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 3 March 2015 at 20:06, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>
>> On 03/03/2015 11:56, Alex Benn?e wrote:
>>> > > This adds the saving and restore of the current Multi-Processing state
>>> > > of the machine. While the KVM_GET/SET_MP_STATE API exposes a number of
>>> > > potential states for x86 we only use two for ARM. Either the process is
>>> > > running or not.
>>> >
>>> > By this you mean "is the CPU in the PSCI powered down state or not",
>>> > right?
>>>
>>> From the vcpu's perspective it is either running or not. However it is
>>> the same mechanism that is used when PSCI_0_2_FN_CPU_OFF is passed the
>>> VM, internally setting vcpu->arch.paused.
>
> Well, it has to be (ABI defined to be) identical with being PSCI
> powered down/up, because that's how userspace is going to be
> treating it. If we might tell userspace we're in the "not running"
> state for other cases than PSCI-powered-down then we probably need
> to consider separating those out into separate states.
>
>> I suggest that you define a new MP_STATE constant for this.  HALTED in
>> x86 and s390 is the state an ARM processor enters when you execute wfi.
>
> Architecturally the CPU doesn't have to enter any state at all
> if you execute a WFI -- it might be implemented as "go to low
> power state and wait for an interrupt" or "go low power but
> maybe be unnecessarily woken up" or "nop, do nothing"...
>
>>  Right now this is not migrated on ARM if I remember correctly, but
>> perhaps you'll want to add it in the future.
>
> ...which is why we don't need to migrate this: it just means
> that migration during WFI causes an unnecessary-wakeup, which
> is architecturally fine.

What happens when you boot a SMP system but only ever power up one of the
CPUs? You can't just randomly start the second CPU if it's in the
powered off state, who knows what it would do?

-- 
Alex Benn?e
