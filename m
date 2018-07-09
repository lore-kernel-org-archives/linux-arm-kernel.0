From: Dave.Martin@arm.com (Dave P Martin)
Date: Mon, 9 Jul 2018 14:03:59 +0100
Subject: [PATCH] arm64: neon: Do not access kernel_neon_busy with
 preemption enabled
In-Reply-To: <CAAMpZHV7wxofLa1AWEKcuGSa5bwzcfCRy=+zyB2-tw5m5NueVQ@mail.gmail.com>
References: <1530936171-16169-1-git-send-email-yandong77520@gmail.com>
 <20180709102724.GA9486@e103592.cambridge.arm.com>
 <CAAMpZHV7wxofLa1AWEKcuGSa5bwzcfCRy=+zyB2-tw5m5NueVQ@mail.gmail.com>
Message-ID: <20180709130358.GD22740@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 01:08:03PM +0100, Yandong Zhao wrote:
> Hi Dave,
>
> The scenario for this bug is:
> The A process is sched out when the CPU0 executes the function raw_cpu_read(kernel_neon_busy) and just gets the address of kernel_neon_busy without reading.
> The B process starts running kernel_neon_begin() on CPU0, and the variable kernel_neon_busy on CPU0 becomes true. At this time, the A process is executed on CPU1 and the kernel_neon_busy value is CPU0 (true), so BUG_ON()!!!
>
> crash64> kernel_neon_busy
> PER-CPU DATA TYPE:
>   bool kernel_neon_busy;
> PER-CPU ADDRESSES:
>   [0]: ffffffc07fee30a0
>   [1]: ffffffc07fef90a0
>   [2]: ffffffc07ff0f0a0
>   [3]: ffffffc07ff250a0
>
>          CPU0                                                                CPU1
>            |                                                                          |
> A task have get addr ffffffc07fee30a0                                |
>     then sched out                                                            |
>            |                                                                          |
>     B task kernel_neon_begin() [ffffffc07fee30a0]=1             |
>            |                                                                          |
>            |                                         A task sched in and read [ffffffc07fee30a0]==1,so BUG_ON.
>            |                                                                          |
>     B task kernel_neon_end() [ffffffc07fee30a0]=0               |

Ah, OK.  Because raw_cpu_read() read is preemptible, we can read a value
for kernel_neon_busy that effectively belongs to another task.

That was a dumb mistake on my part -- thanks for investingating it.

> 2018-07-09 18:27 GMT+08:00 Dave Martin <Dave.Martin at arm.com<mailto:Dave.Martin@arm.com>>:
> On Sat, Jul 07, 2018 at 12:02:51PM +0800, Yandong.Zhao wrote:
> > From: Yandong Zhao <yandong77520 at gmail.com<mailto:yandong77520@gmail.com>>
> >
> > Dear, Dave
> > Thank you very much for reading my email. I have a question and
> > I hope toget your reply.
> > It is a bug to not close the preemption when executing
> > raw_cpu_read(kernel_neon_busy) in the function may_use_simd()!
> > We encountered a ?sysdump? problem on Kernel 4.14 code because
> > the program entered BUG_ON() in the function kernel_neon_begin().
> > Our analysis concludes that the process is migrating while executing
> > raw_cpu_read(kernel_neon_busy).
>
> Can you include a backtrace, please?
>
> Also, do you have any significant patches applies on top of v4.14?  Is
> your configuration different from defconfig?
>
> >
> > Signed-off-by: Yandong Zhao <yandong77520 at gmail.com<mailto:yandong77520@gmail.com>>
> > ---
> >  arch/arm64/include/asm/simd.h | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> > index fa8b3fe..0d91084 100644
> > --- a/arch/arm64/include/asm/simd.h
> > +++ b/arch/arm64/include/asm/simd.h
> > @@ -29,20 +29,13 @@
> >  static __must_check inline bool may_use_simd(void)
> >  {
> >       /*
> > -      * The raw_cpu_read() is racy if called with preemption enabled.
> > -      * This is not a bug: kernel_neon_busy is only set when
> > -      * preemption is disabled, so we cannot migrate to another CPU
> > -      * while it is set, nor can we migrate to a CPU where it is set.
> > -      * So, if we find it clear on some CPU then we're guaranteed to
> > -      * find it clear on any CPU we could migrate to.
> > -      *
> > -      * If we are in between kernel_neon_begin()...kernel_neon_end(),
> > -      * the flag will be set, but preemption is also disabled, so we
> > -      * can't migrate to another CPU and spuriously see it become
> > -      * false.

Please keep the above comment: it remains important to explain why
the return value from may_use_simd() remains valid even if the
task migrates to another cpu.

The first sentence should be reworded to clarify the nature of
the race, something like:

"The this_cpu_read() call is racy if called with preemption enabled,
since the task my subsequently migrate to another CPU.  This is not
a bug: [...]"

> > +      * Operations for contexts where we do not want to do any checks for
> > +      * preemptions.  Unless strictly necessary, always use this_cpu_*()
> > +      * instead. Because of the kernel_neon_busy here we have to make sure
> > +      * that it is the current cpu.

Your comment should be moved to the commit message, since it
just explains what was fixed.

> >        */
> >       return !in_irq() && !irqs_disabled() && !in_nmi() &&
> > -             !raw_cpu_read(kernel_neon_busy);
> > +             !this_cpu_read(kernel_neon_busy);

This adds overhead, but I don't see a way around it.


Can you post an updated version with an amended commit message and
a suitable Fixes: tag?

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
