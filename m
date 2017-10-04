From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 04 Oct 2017 19:23:01 +0100
Subject: [PATCH 3/3] arm64: kvm: Fix single step for guest skipped
 instructions
In-Reply-To: <edd5e138-bda0-7cdf-83b2-8698cfb4304f@arm.com>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
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
 <1bdaff65-c784-4698-5c04-bfb1c943e6c0@arm.com> <87efqiyl64.fsf@linaro.org>
 <edd5e138-bda0-7cdf-83b2-8698cfb4304f@arm.com>
Message-ID: <87d162ydq2.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Julien Thierry <julien.thierry@arm.com> writes:

> On 04/10/17 16:42, Alex Benn?e wrote:
>>
<snip>
>>
>> Looking more closely though it has a point. The IO/MMIO exits work
>> purely from the address and data entries in the run structure. When we
>> return to KVM_RUN we do:
>>
>> 	if (run->exit_reason == KVM_EXIT_MMIO) {
>> 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
>> 		if (ret)
>> 			return ret;
>> 	}
>>
>> So you are correct the instruction emulation is not complete. Once that
>> fixup is done however I think we are good to return. So perhaps we can
>> avoid involving QEMU entirely in this by generating a debug exit
>> here.
>>
>> QEMU ->
>>          kvm_run ->
>>                      switch ->
>>                                guest
>>                             <-
>>                      trap
>>                   <-
>>          exit mmio
>>       <-
>> QEMU
>>       -> kvm_run
>>          handle_mmio_return
>>          exit debug
>>       <-
>> QEMU
>>
>
> Thanks for the explanation. This approach sounds good to me. Also, it
> means QEMU doesn't need to get patched, is that correct?

Correct.

>
>> I don't think this affects the handle_exit() case as we only force the
>> exit for successfully emulated instructions inside kvm.
>>
>
> Yes, in handle_exit MMIO handled by the kernel will exit with
> KVM_EXIT_DEBUG and MMIO handled by the userland will exit with
> KVM_EXIT_MMIO. So from your patch we just need to add the exit debug
> after handle_mmio_return.

One minor wrinkle in kvm_handle_mmio_return() I can't use
vcpu->debug_flags as the v7 code doesn't have it in kvm_vcpu_arch.

>
>> Looking at x86 for reference it does seem happy with triggering exits on
>> single stepped emulation, see kvm_vcpu_do_singlestep(). However it also
>> has a number of comments on IO emulation:
>>
>>    /* FIXME: return into emulator if single-stepping.  */
>>
>> So ARM is at least not behind the curve on this support ;-)
>>
>>>> I'd like to test these patches on some real life examples. I tried
>>>> tracing over the pl011_write code in a kernel boot but I ran into the
>>>> problem of el1_irq's occurring as I tried to step through the guest
>>>> kernel. Is this something you've come across? What MMIO accesses have
>>>> you been using in your testing?
>>>>
>>>
>>> I didn't know which MMIOs were handled by userland so I have only
>>> tested traps and MMIOs handled by the kernel.
>>
>> Any particular MMIOs I could also use to replicate in my tests?
>>
>
> For MMIOs handled by the kernel, I was testing with the GIC. You could
> try to break on gic_cpu_config in the guest, where it will write to
> distributor registers. The function should be called during
> initialization, before IRQs are enabled, so you shouldn't be bothered
> by the earlier trouble.

Thanks - this will be useful.

>>> This sounds like an issue when you are debugging an interruptible
>>> context, an issue Pratyush has been looking at [1]. Are you taking a
>>> guest interrupt when you try to execute the instruction to be stepped?
>>> I don't know what's the status of this patch series. Can you test the
>>> userland MMIO in a non-interruptible context?
>>>
>>> [1]
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/517234.html
>>
>> Again looking at x86 it looks like the approach is to suspend IRQs if
>> you are single-stepping. I'll have a look at Pratyush's patches.
>>
>
> I think that was the idea with Pratyush's patches as well.
>
> So, I'm happy to replace my patch with yours in this series (unless
> you want to post it separated since it doesn't depend on my patches).


Nope I'm happy for you to carry it to merge. I'll see if I can send you
a v2 once I've addressed the mmio completion.

>
> Thank you for looking at this and providing your input.

No problem, sorry it took so long.

--
Alex Benn?e
