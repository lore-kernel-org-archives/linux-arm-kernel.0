From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Jul 2016 10:53:54 +0100
Subject: [PATCH v15 00/10] arm64: Add kernel probes (kprobes) support
In-Reply-To: <877fcn46pn.fsf@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <20160714162208.GA22235@e104818-lin.cambridge.arm.com>
 <6b43c28b-df68-112d-f8a3-6f952a50f54f@redhat.com>
 <20160715075001.GA13360@e104818-lin.cambridge.arm.com>
 <5788986C.3030008@arm.com> <877fcn46pn.fsf@linaro.org>
Message-ID: <5788B2B2.8010205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/16 09:59, Alex Benn?e wrote:
> 
> Marc Zyngier <marc.zyngier@arm.com> writes:
> 
>> On 15/07/16 08:50, Catalin Marinas wrote:
>>> On Thu, Jul 14, 2016 at 01:09:08PM -0400, William Cohen wrote:
>>>> On 07/14/2016 12:22 PM, Catalin Marinas wrote:
>>>>> On Fri, Jul 08, 2016 at 12:35:44PM -0400, David Long wrote:
>>>>>> David A. Long (3):
>>>>>>   arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
>>>>>>   arm64: Add more test functions to insn.c
>>>>>>   arm64: add conditional instruction simulation support
>>>>>>
>>>>>> Pratyush Anand (2):
>>>>>>   arm64: Blacklist non-kprobe-able symbol
>>>>>>   arm64: Treat all entry code as non-kprobe-able
>>>>>>
>>>>>> Sandeepa Prabhu (4):
>>>>>>   arm64: Kprobes with single stepping support
>>>>>>   arm64: kprobes instruction simulation support
>>>>>>   arm64: Add kernel return probes support (kretprobes)
>>>>>>   kprobes: Add arm64 case in kprobe example module
>>>>>>
>>>>>> William Cohen (1):
>>>>>>   arm64: Add trampoline code for kretprobes
>>>>>
>>>>> I applied these patches on top of the arm64 for-next/core branch an
>>>>> tried to run the resulting kernel in a guest (on a Juno platform using
>>>>> both kvmtool and qemu) with KPROBES_SANITY_TEST enabled. Unfortunately,
>>>>> the kernel fails to boot with lots of "Unexpected kernel single-step
>>>>> exception at EL1".
>>>>>
>>>>> Did you manage to run Kprobes in a guest before?
>>>>
>>>> I ran the systemtap testsuite several times on a physical machine
>>>> running a kernel with the kprobe v15 patches without problem.
>>>> Shouldn't the guest machine behave in the same manner as a host
>>>> machine for single stepping and exception handling?  If the guest
>>>> machine is failing, wouldn't that suggest there is a problem with the
>>>> KVM handling of single stepping for guests?
>>>
>>> It didn't fail for me on the host either. What's strange is that on some
>>> occasions even the guest managed to get to a prompt. I'll do more tests
>>> today on different CPU configurations, just to rule out potential
>>> hardware issues. If not hardware related, it's possible that the
>>> interaction with KVM doesn't work as expected, maybe the
>>> saving/restoring of the guest debug state loses information.
>>
>> Could well be the latter. I'll try to have a look, but Alex Benn?e (on
>> cc) is our man when it comes to the KVM debug infrastructure.
>>
>> Alex, any chance you could try this and shed some light on it?
> 
> Sure I'll have a look. There are problems with running gdb inside a
> guest while trying to debug from outside associated with single-stepping
> but none of this should get in the way if your not debugging the guest.
> 
> Let me get my system spun up and see if I can reproduce.
> 
> Shall I just apply this series on top of the current master?

I managed to reproduce it by taskset-ing 2 vcpus on the same physical
CPU, and trying a few dozen times on Juno-r1. It is not easy to trigger,
but when it happens it is quite bad.

Warning, pure speculation ahead: I suspect that we preempt a vcpu with
single-step enabled, somehow fail to clear the SS state, schedule
another vcpu that inherits that state and takes this unexpected SS
exception.

/me goes and have a look...

	M.
-- 
Jazz is not dead. It just smells funny...
