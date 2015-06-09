From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 09 Jun 2015 16:04:32 -0700
Subject: [PATCH v2] arm/arm64: KVM: Properly account for guest CPU time
In-Reply-To: <20150608113524.GA2001@cbox>
References: <1432838950-28774-1-git-send-email-christoffer.dall@linaro.org>
 <5568E987.5010702@samsung.com> <20150531065923.GB763@cbox>
 <556C7EC6.3010105@samsung.com> <20150602092759.GA7783@cbox>
 <557194E7.5020102@samsung.com> <20150608113524.GA2001@cbox>
Message-ID: <55777100.4090800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 04:35 AM, Christoffer Dall wrote:
> On Fri, Jun 05, 2015 at 05:24:07AM -0700, Mario Smarduch wrote:
>> On 06/02/2015 02:27 AM, Christoffer Dall wrote:
>>> On Mon, Jun 01, 2015 at 08:48:22AM -0700, Mario Smarduch wrote:
>>>> On 05/30/2015 11:59 PM, Christoffer Dall wrote:
>>>>> Hi Mario,
>>>>>
>>>>> On Fri, May 29, 2015 at 03:34:47PM -0700, Mario Smarduch wrote:
>>>>>> On 05/28/2015 11:49 AM, Christoffer Dall wrote:
>>>>>>> Until now we have been calling kvm_guest_exit after re-enabling
>>>>>>> interrupts when we come back from the guest, but this has the
>>>>>>> unfortunate effect that CPU time accounting done in the context of timer
>>>>>>> interrupts occurring while the guest is running doesn't properly notice
>>>>>>> that the time since the last tick was spent in the guest.
>>>>>>>
>>>>>>> Inspired by the comment in the x86 code, move the kvm_guest_exit() call
>>>>>>> below the local_irq_enable() call and change __kvm_guest_exit() to
>>>>>>> kvm_guest_exit(), because we are now calling this function with
>>>>>>> interrupts enabled.  We have to now explicitly disable preemption and
>>>>>>> not enable preemption before we've called kvm_guest_exit(), since
>>>>>>> otherwise we could be preempted and everything happening before we
>>>>>>> eventually get scheduled again would be accounted for as guest time.
>>>>>>>
>>>>>>> At the same time, move the trace_kvm_exit() call outside of the atomic
>>>>>>> section, since there is no reason for us to do that with interrupts
>>>>>>> disabled.
>>>>>>>
>>>>>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>>>>> ---
[ ... ]
>>>
>>> preempt_enable() will call __preempt_schedule() and cause preemption
>>> there, so you're talking about adding these lines of latency:t
>>>
>>> 	kvm_guest_exit();
>>> 	trace_kvm_exit(kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
>>
>> On return from IRQ this should execute - and el1_preempt won't
>> get called.
>>
>> #ifdef CONFIG_PREEMPT
>>         get_thread_info tsk
>>         ldr     w24, [tsk, #TI_PREEMPT]         // get preempt count
>>         cbnz    w24, 1f                         // preempt count != 0
>>         ldr     x0, [tsk, #TI_FLAGS]            // get flags
>>         tbz     x0, #TIF_NEED_RESCHED, 1f       // needs rescheduling?
>>         bl      el1_preempt
>> 1:
>> #endif
>>
> 
> I understand that, but then you call preempt_enable right after which
> calls __preempt_schedule() which has the same affect as that asm snippet
> you pasted here.
> 
>>
>>>
>>> And these were called with interrupts disabled before, so I don't see
>>> the issue??
>>>
>>> However, your question is making me think whether we have a race in the
>>> current code on fully preemptible kernels, if we get preempted before
>>> calling kvm_timer_sync_hwstate() and kvm_vgic_sync_hwstate(), then we
>>> could potentially schedule another vcpu on this core and loose/corrupt
>>> state, can we not?  We probably need to check for this in
>>> kvm_vcpu_load/kvm_vcpu_put.  I need to think more about if this is a
>>> real issue or if I'm seeing ghosts.
>>
>> Yes appears like it could be an issue in PREEMPT mode.
> 
> see separate mail, I don't believe this to be an issue anymore.
> 
>>>
>>>>>
[ ... ]
>>>>
>>> Would you run with NO_HZ_FULL in this case?  Because then we should just
>>> enable HAVE_VIRT_CPU_ACCOUNTING_GEN, and I think that would be a good
>>> start.
>> It may have a use case to run an isolated vCPU, but in general any mode
>> may be used (,NO_HZ, even low PERIODIC).
>>
> ok, but I still think it would be more correct to have this patch than
> not to.
No daubt, it exposes an important missing feature and fixes
'Guest time' which mostly should be accurate or close to it.

But there may be room for some future work in this
area (like NATIVE accounting with guest time support),

- Mario

> 
> -Christoffer
> 
