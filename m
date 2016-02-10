From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 12:10:30 +0000
Subject: [PATCH] arm64: use raw_smp_processor_id in stack backtrace dump
In-Reply-To: <56BB247F.6040202@arm.com>
References: <1455053182-31404-1-git-send-email-yang.shi@linaro.org>
 <20160210102939.GD1052@arm.com> <56BB247F.6040202@arm.com>
Message-ID: <20160210121030.GH1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 11:52:31AM +0000, James Morse wrote:
> On 10/02/16 10:29, Will Deacon wrote:
> > On Tue, Feb 09, 2016 at 01:26:22PM -0800, Yang Shi wrote:
> >> dump_backtrace may be called in kthread context, which is not bound to a single
> >> cpu, i.e. khungtaskd, then calling smp_processor_id may trigger the below bug
> >> report:
> > 
> > If we're preemptible here, it means that our irq_stack_ptr is potentially
> > bogus. Whilst this isn't an issue for kthreads, it does feel like we
> > could make this slightly more robust in the face of potential frame
> > corruption. Maybe just zero the IRQ stack pointer if we're in preemptible
> > context?
> 
> Switching between stacks is only valid if we are tracing ourselves while on the
> irq_stack, we should probably prevent it for other tasks too.
> 
> Something like (untested):
> ---------------------
> if (tsk == current && in_atomic())
> 	irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
> else
> 	irq_stack_ptr = 0;
> ---------------------
> 
> This would work when we trace ourselves while on the irq_stack, but break*
> tracing a running task on a remote cpu (khungtaskd doesn't do this).
> 
> The same fix would apply to unwind_frame(), we have 'tsk' in both functions.
> 
> Thoughts?

in_atomic is a misnomer:

  https://lwn.net/Articles/274695/

;)

So we might be better off zeroing the pointer if tsk != current ||
preemptible(). But yeah, I think we're in general agreement about this.

Will
