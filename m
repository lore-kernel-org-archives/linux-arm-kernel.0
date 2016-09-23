From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 23 Sep 2016 11:15:21 +0200
Subject: [PATCH v5] KVM: arm/arm64: Route vtimer events to user space
In-Reply-To: <7afbc08e-0ba2-d6fd-c1ed-e5822e05c00b@suse.de>
References: <1474548769-195643-1-git-send-email-agraf@suse.de>
 <20160922212831.GD9101@cbox> <d90f04d4-b29f-f08e-df39-ec307af44225@suse.de>
 <63a1e3a2-f551-017f-b6be-593b53a0b407@redhat.com>
 <7afbc08e-0ba2-d6fd-c1ed-e5822e05c00b@suse.de>
Message-ID: <e4c08096-03bd-3ec3-998d-41643992ab1a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/09/2016 11:10, Alexander Graf wrote:
>>>> Maybe I'm misunderstanding and user_timer_pending is just a cached
>>>> verison of what you said last, but as I said above, I think you can just
>>>> compare timer->irq.level with the last value the kvm_run struct, and if
>>>> something changed, you have to exit.
>>>
>>> So how would user space know whether the line went up or down? Or didn't
>>> change at all (if we coalesce with an MMIO exit)?
>>
>> It would save the status of the line somewhere in its own variable,
>> without introducing a relatively delicate API between kernel and user.
>>
>> I agree that you cannot update kernel_timer_pending only in
>> flush_hwstate; otherwise you miss on case (2) when there is a vmexit.
>> That has to stay in kvm_timer_sync_hwstate (or it could become a new
>> function called at the very end of kvm_arch_vcpu_ioctl_run).
> 
> The beauty of having it in the timer update function is that it gets
> called from flush_hwstate() as well. That way we catch the update also
> in cases where we need it before we enter the vcpu.

Yeah, the timer update function is ideal because it is called from both
flush_hwstate and sync_hwstate.

>> However, I'm not sure why user_timer_pending is necessary.  If it is
>> just the value you assigned to regs->kernel_timer_pending at the time of
>> the previous vmexit, can kvm_timer_flush_hwstate just do
>>
>>    if (timer->prev_kernel_timer_pending != regs->kernel_timer_pending) {
>>        timer->prev_kernel_timer_pending = regs->kernel_timer_pending;
>>        return 1;
>>    }
>>
>> ?  Or even
>>
>>    if (timer->prev_irq_level != timer->irq.level) {
>>        timer->prev_irq_level = regs->irq.level;
>>        return 1;
>>    }
>>
>> so that regs->kernel_timer_pending remains exclusively
>> kvm_timer_sync_hwstate's business?
> 
> We could do that too, yes. But it puts more burden on user space - it
> would have to ensure that it *always* checks for the pending timer
> status. With this approach, user space may opt to only check for timer
> state changes on -EINTR and things would still work.

That would be overloading EINTR a bit though.  But that's a digression,
I don't think it matters much.

On the other hand, what happens if you run new QEMU with old userspace?
With user_timer_pending you'd get an infinite stream of vmexits the
first time the timer fires, wouldn't you?  Whereas if you keep it in the
kernel, userspace would simply not get the interrupt (because it doesn't
know about kernel_timer_pending) and think it got a spurious vmexit.
The kernel's IRQ would stay masked and everything would just (not) work
like before your patch?

Thanks,

Paolo
