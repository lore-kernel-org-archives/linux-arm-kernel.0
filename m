From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 04 Oct 2017 16:42:11 +0100
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <1bdaff65-c784-4698-5c04-bfb1c943e6c0@arm.com>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
 <1504083688-48334-4-git-send-email-julien.thierry@arm.com>
 <CAMJs5B9u_s_wOoR7tyOV7t67aWmmgA6KavEWhDuDN98+z5rACg@mail.gmail.com>
 <3c249a68-45e3-a3a5-7d05-4cfc2d97713b@arm.com>
 <CAMJs5B8hYTJBxKa8Wu3Bw7EjaG4UZ56QQyVYx1E_4kJzkPhN+Q@mail.gmail.com>
 <ab00b377-c42d-d920-237f-9b30c9de5044@arm.com>
 <CAMJs5B-i4h63Hx68b6z-DxDphXieoNGJcLTfi2zLuq0CnU_S3g@mail.gmail.com>
 <3d7d2b36-da2f-04dc-611e-d7aab7666c29@arm.com>
 <CAMJs5B8F9VffM3pDQxbk-qfUmvvqdvbVOt8WZgFX2Q4Ud3eJrA@mail.gmail.com>
 <9bc5abc2-ab03-3137-82bd-e8afa62624eb@arm.com>
 <CAMJs5B9iVYGE2mODE1raHzGQ+Mz7V_kT+bJiWm0zUHfmLN1-DQ@mail.gmail.com>
 <861b4e4f-0fbe-cbc6-39ad-4660065449de@arm.com> <877ewcz3bv.fsf@linaro.org>
 <4d9fc0a2-bcf9-ca26-8646-037c2dcc6545@arm.com> <873770yz1o.fsf@linaro.org>
 <5a4f0493-6d3d-85de-fc45-030d4b03b5a8@arm.com> <871smkywgn.fsf@linaro.org>
 <db80e858-0127-af96-e09b-865893f927cb@arm.com> <87k20bxm13.fsf@linaro.org>
 <1bdaff65-c784-4698-5c04-bfb1c943e6c0@arm.com>
Message-ID: <87efqiyl64.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Julien Thierry <julien.thierry@arm.com> writes:

> On 04/10/17 11:08, Alex Benn?e wrote:
>>
>> [Added Paolo, including QEMU userspace patch]
>>
>> Julien Thierry <julien.thierry@arm.com> writes:
>>
>>> On 03/10/17 18:26, Alex Benn?e wrote:
>>>>
>>>> Julien Thierry <julien.thierry@arm.com> writes:
>>>>
>>>>> On 03/10/17 17:30, Alex Benn?e wrote:
>>>>>>
>>>>>> Julien Thierry <julien.thierry@arm.com> writes:
>>>>>>
>>>>>>> On 03/10/17 15:57, Alex Benn?e wrote:
>>>>>>>>
>>>>>>>> Julien Thierry <julien.thierry@arm.com> writes:
>>>>>>>>
>>>>>>>>> On 31/08/17 15:01, Christoffer Dall wrote:
>>>>>> <snip>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Does that sound like what you had in mind? Or does it seem better than
>>>>>>>>>>>>> the
>>>>>>>>>>>>> current patch?
>>>>>>>>>>>>>
>>>>>>>>>>>> I was thinking to change the skip_instruction function to return an
>>>>>>>>>>>> int, and then call kvm_handle_debug_ss() from skip_instruction, which
>>>>>>>>>>>> would update the kvm_run structure and exit here and then.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Setting up the debug exception from within kvm_skip_instruction seem to
>>>>>>>>>>> change a bit too much its semantic from arm to arm64. I would find this
>>>>>>>>>>> easily confusing.
>>>>>>>>>>>
>>>>>>>>>>>> However, I'm now thinking that this doesn't really work either,
>>>>>>>>>>>> because we could have to emulate a trapped MMIO instruction in user
>>>>>>>>>>>> space, and then it's not clear how to exit with a debug exception at
>>>>>>>>>>>> the same time.
>>>>>>>>
>>>>>>>> A debug exception at guest exit point is (IIRC) just having the
>>>>>>>> appropriate status in the run->exit_reason (KVM_EXIT_DEBUG). If you need
>>>>>>>> to exit for MMIO emulation (i.e. the instruction has not run yet) you
>>>>>>>> shouldn't do that. Exit, emulate and return. We could handle the ioctl
>>>>>>>> to clear SS in userspace but I guess that gets just as messy.
>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> So perhaps we should stick with your original approach.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I had not realized that was possible. This makes things more complicated for
>>>>>>>>>>> avoiding a back and forth with the guest for trapped exceptions. Out of
>>>>>>>>>>> luck, having the debug flag does look like single stepping would work as
>>>>>>>>>>> expected for userland MMIOs.
>>>>>>
>>>>>> <snip>
>>>
>>> There is also the case of GIC CPU inteface accesses being trapped
>>> (which shouldn't be the default behaviour). If the vgic access fails,
>>> we will skip the instruction (in __kvm_vcpu_run in
>>> arch/arm64/kvm/hyp/switch.c) and if we were single stepping we will
>>> single step 2 instructions. But this seems to be a corner case of a
>>> corner case (GIC CPUIF trapped + access failing + single stepping), so
>>> I don't know if we want to take that into account right now?
>>
>> Yeah looking at the hyp code I did wonder if it warranted the complexity
>> of adding handling there.
>>
>>> I'm still a bit concerned about the change of semantics for
>>> KVM_EXIT_MMIO with regards to userland (cf. my previous mail). But if
>>> this is deemed to be a reasonable change, the patch seems fine to me.
>>
>> Have we changed the semantics? A normal un-handled by the kernel IO/MMIO
>> exit needs to be processed before the single step takes effect. I can't
>> speak for other userspace but I think for QEMU it is as simple as the
>> patch bellow. That said it wasn't quite clear where the PC gets updated
>> in this path - I think the kernel updates the PC before the
>> KVM_EXIT_MMIO in the same path as the internal handling.
>>
>
> Well I'm not sure. The part I am concerned about is:
>> NOTE: For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR and
>>       KVM_EXIT_EPR the corresponding
>> operations are complete (and guest state is consistent) only after userspace
>> has re-entered the kernel with KVM_RUN.  The kernel side will first finish
>> incomplete operations and then check for pending signals.  Userspace
>> can re-enter the guest with an unmasked signal pending to complete
>> pending operations.
>
> From Documentation/virtual/kvm/api.txt.
>
> The way I interpret this is that userland should not consider the MMIO
> complete before running the vcpu again. If that the case it shouldn't
> trigger the single step since the instruction is not completely
> finished.
>
> Maybe I don't interpret this correctly or it is not relevant here.
> Although I'd like to understand why.

No it certainly needs clarifying. The comment was originally added in:

  679613442f84702c06a80f2320cb8a50089200bc

Looking more closely though it has a point. The IO/MMIO exits work
purely from the address and data entries in the run structure. When we
return to KVM_RUN we do:

	if (run->exit_reason == KVM_EXIT_MMIO) {
		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
		if (ret)
			return ret;
	}

So you are correct the instruction emulation is not complete. Once that
fixup is done however I think we are good to return. So perhaps we can
avoid involving QEMU entirely in this by generating a debug exit
here.

QEMU ->
        kvm_run ->
                    switch ->
                              guest
                           <-
                    trap
                 <-
        exit mmio
     <-
QEMU
     -> kvm_run
        handle_mmio_return
        exit debug
     <-
QEMU

I don't think this affects the handle_exit() case as we only force the
exit for successfully emulated instructions inside kvm.

Looking at x86 for reference it does seem happy with triggering exits on
single stepped emulation, see kvm_vcpu_do_singlestep(). However it also
has a number of comments on IO emulation:

  /* FIXME: return into emulator if single-stepping.  */

So ARM is@least not behind the curve on this support ;-)

>> I'd like to test these patches on some real life examples. I tried
>> tracing over the pl011_write code in a kernel boot but I ran into the
>> problem of el1_irq's occurring as I tried to step through the guest
>> kernel. Is this something you've come across? What MMIO accesses have
>> you been using in your testing?
>>
>
> I didn't know which MMIOs were handled by userland so I have only
> tested traps and MMIOs handled by the kernel.

Any particular MMIOs I could also use to replicate in my tests?

> This sounds like an issue when you are debugging an interruptible
> context, an issue Pratyush has been looking at [1]. Are you taking a
> guest interrupt when you try to execute the instruction to be stepped?
> I don't know what's the status of this patch series. Can you test the
> userland MMIO in a non-interruptible context?
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/517234.html

Again looking at x86 it looks like the approach is to suspend IRQs if
you are single-stepping. I'll have a look at Pratyush's patches.

>
> Thanks,
>
>> QEMU Patch bellow:
>>
>>  From 2e8fcea695a9eca67fbeb331d3104d1d9e7e337a Mon Sep 17 00:00:00 2001
>> From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
>> Date: Wed, 4 Oct 2017 09:49:41 +0000
>> Subject: [PATCH] kvm: exit run loop after emulating IO when single stepping
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> If single-stepping is enabled we should exit the run-loop after
>> emulating the access. Otherwise single-stepping across emulated IO
>> accesses may skip an instruction.
>>
>> This only addresses user-space emulation. Stuff done in kernel-mode
>> should be handled there.
>>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> ---
>>   accel/kvm/kvm-all.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 90c88b517d..85bcb2b0d4 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -1940,7 +1940,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>                             run->io.direction,
>>                             run->io.size,
>>                             run->io.count);
>> -            ret = 0;
>> +            ret = cpu->singlestep_enabled ? EXCP_DEBUG : 0;
>>               break;
>>           case KVM_EXIT_MMIO:
>>               DPRINTF("handle_mmio\n");
>> @@ -1950,7 +1950,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>                                run->mmio.data,
>>                                run->mmio.len,
>>                                run->mmio.is_write);
>> -            ret = 0;
>> +            ret = cpu->singlestep_enabled ? EXCP_DEBUG : 0;
>>               break;
>>           case KVM_EXIT_IRQ_WINDOW_OPEN:
>>               DPRINTF("irq_window_open\n");
>> --
>> 2.14.1
>>


--
Alex Benn?e
