From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Jun 2015 13:55:37 +0200
Subject: [PATCH v2] arm/arm64: KVM: Properly account for guest CPU time
In-Reply-To: <20150602092759.GA7783@cbox>
References: <1432838950-28774-1-git-send-email-christoffer.dall@linaro.org>
 <5568E987.5010702@samsung.com> <20150531065923.GB763@cbox>
 <556C7EC6.3010105@samsung.com> <20150602092759.GA7783@cbox>
Message-ID: <20150602115537.GA12347@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[replying to myself]

On Tue, Jun 02, 2015 at 11:27:59AM +0200, Christoffer Dall wrote:

[..]

> > > 
> > > If this patch is incorrect, then how does it work on x86, where
> > > handle_external_intr() is called (with a barrier in between) before
> > > kvm_guest_exit(), and where handle_external_intr() is simply
> > > local_irq_enable() on SVM and something more complicated on VMX ?
> > > 
> > > Finally, how exactly is preemption latency added here?   Won't IRQ
> > > processing run with higher priority than any task on your system, so the
> > > order of (1) process pending IRQs (2) call schedule if needed is still
> > > preserved here, but we call kvm_guest_exit() between (1) and (2) instead
> > > of before (1).
> > 
> > I may be missing something, but on return from interrupt with preempt
> > disabled we can't take the need resched path. And need to return
> > to KVM no?
> 
> preempt_enable() will call __preempt_schedule() and cause preemption
> there, so you're talking about adding these lines of latency:
> 
> 	kvm_guest_exit();
> 	trace_kvm_exit(kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
> 
> And these were called with interrupts disabled before, so I don't see
> the issue??
> 
> However, your question is making me think whether we have a race in the
> current code on fully preemptible kernels, if we get preempted before
> calling kvm_timer_sync_hwstate() and kvm_vgic_sync_hwstate(), then we
> could potentially schedule another vcpu on this core and loose/corrupt
> state, can we not?  We probably need to check for this in
> kvm_vcpu_load/kvm_vcpu_put.  I need to think more about if this is a
> real issue or if I'm seeing ghosts.
> 
I've thought about it and I don't think there's a race because those
functions don't access the hardware directly, but only manipulate
per-vcpu data structures.

-Christoffer
