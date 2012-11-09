From: ccross@google.com (Colin Cross)
Date: Fri, 9 Nov 2012 10:17:01 -0800
Subject: [PATCH] ARM: backtrace: avoid crash on large invalid fp value
In-Reply-To: <20121109105648.GA2048@linaro.org>
References: <1349851572-9967-1-git-send-email-toddpoynor@google.com>
 <20121010111517.GC2131@linaro.org>
 <CAMbhsRTNULfBjL=x3qFgjqsfR25EJt+2A4hY=qTXcDq8gyCxmA@mail.gmail.com>
 <20121105105421.GB2005@linaro.org>
 <CAMbhsRR+BVFP7rfyc_3+F0rNQVWFUh6Oca=Bg_TpcQszwF-6Bg@mail.gmail.com>
 <20121109105648.GA2048@linaro.org>
Message-ID: <CAMbhsRQM5FyGum1s-YE+e4XrnqHn+acH89fjJsoMLGueKjhepQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2012 at 2:56 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Thu, Nov 08, 2012 at 06:05:52PM -0800, Colin Cross wrote:
>> On Mon, Nov 5, 2012 at 2:54 AM, Dave Martin <dave.martin@linaro.org> wrote:
>> > On Fri, Nov 02, 2012 at 04:47:38PM -0700, Colin Cross wrote:
>> >> On Wed, Oct 10, 2012 at 4:15 AM, Dave Martin <dave.martin@linaro.org> wrote:
>> >> > On Tue, Oct 09, 2012 at 11:46:12PM -0700, Todd Poynor wrote:
>> >> >> Invalid frame pointer (signed) -4 <= fp <= -1 defeats check for too high
>> >> >> on overflow.
>> >> >>
>> >> >> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> >> >> ---
>> >> >>  arch/arm/kernel/stacktrace.c |    2 +-
>> >> >>  1 files changed, 1 insertions(+), 1 deletions(-)
>> >> >>
>> >> >> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
>> >> >> index 00f79e5..6315162 100644
>> >> >> --- a/arch/arm/kernel/stacktrace.c
>> >> >> +++ b/arch/arm/kernel/stacktrace.c
>> >> >> @@ -31,7 +31,7 @@ int notrace unwind_frame(struct stackframe *frame)
>> >> >>       high = ALIGN(low, THREAD_SIZE);
>> >> >>
>> >> >>       /* check current frame pointer is within bounds */
>> >> >> -     if (fp < (low + 12) || fp + 4 >= high)
>> >> >> +     if (fp < (low + 12) || fp >= high - 4)
>> >> >>               return -EINVAL;
>> >> >>
>> >> >>       /* restore the registers from the stack frame */
>> >> >
>> >> > sp and fp can still be complete garbage in the case of a corrupted frame,
>> >> > so low + 12 can still overflow and cause us to read beyond the stack base.
>> >> >
>> >> > A more robust patch might be as follows.  This also checks for misaligned
>> >> > fp and sp values, since those indicate corruption and there can be no
>> >> > sensible way to interpret the resulting frame in that case.
>> >> >
>> >> > Also, according to the definition of current_thread_info(),
>> >> > IS_ALIGNED(sp, THREAD_SIZE) indicates a full stack extending from sp
>> >> > to sp + THREAD_SIZE, and not an empty stack extending from sp -
>> >> > THREAD_SIZE to sp.  We cannot backtrace this situation anyway, since
>> >> > that would imply that the frame record extends beyond the stack...
>> >> > but this patch tidies it up in the interest of clarity.
>> >> >
>> >> > Cheers
>> >> > ---Dave
>> >> >
>> >> > (untested)
>> >> >
>> >> > diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
>> >> > index 00f79e5..fec82be 100644
>> >> > --- a/arch/arm/kernel/stacktrace.c
>> >> > +++ b/arch/arm/kernel/stacktrace.c
>> >> > @@ -28,10 +28,20 @@ int notrace unwind_frame(struct stackframe *frame)
>> >> >
>> >> >         /* only go to a higher address on the stack */
>> >> >         low = frame->sp;
>> >> > -       high = ALIGN(low, THREAD_SIZE);
>> >> > +       if (!IS_ALIGNED(fp, 4))
>> >> > +               return -EINVAL;
>> >> > +
>> >> > +       /*
>> >> > +        * low + 1 here ensures that high > sp, consistent with the
>> >> > +        * definition of current_thread_info().
>> >> > +        * We subtract 1 to compute the highest allowable byte address.
>> >> > +        * Otherwise, we might get high == 0 which would confuse our
>> >> > +        * comparisons.
>> >> > +        */
>> >> > +       high = ALIGN(low + 1, THREAD_SIZE) - 1;
>>
>> ARM eabi stacks are full-descending, meaning that if the sp is a
>> multiple of THREAD_SIZE, the stack is empty.  current_thread_info
>> takes a short-cut and assumes it can never be called on an empty
>> stack, but better not to propagate that anywhere else.
>
> The effect of the code is consistent with current_thread_info():
>
>         low = THREAD_SIZE * X --> high = THREAD_SIZE * (X + 1) - 1
>         low = THREAD_SIZE * (X + 1) - 1 --> high = THREAD_SIZE * (X + 1) - 1
>
> i.e., low = THREAD_SIZE * X is treated as a full stack.

current_thread_info() is assuming a sane stack, where the sp is
between [THREAD_SIZE * X + sizeof(struct thread_info), THREAD_SIZE *
(X + 1) - 8] (see THREAD_START_SP).  It should never see sp =
THREAD_SIZE * X, so we shouldn't be copying its behavior in that case.

sp = THREAD_SIZE * x being a full stack would mean that the stack has
passed all the way through the struct thread_info stored at the lower
addresses of the stack, corrupting the task struct, saved registers,
and likely the stack too.  On the other hand, sp = THREAD_SIZE * x
being an empty stack would mean somebody started a stack higher than
THREAD_START_SP.  Neither one really makes sense, maybe I should just
validate the sp above the thread_info and below THREAD_START_SP.

> The comment relates to the case where the stack is right at the top
> of the address space: if we define high as ALIGN(low + 1, THREAD_SIZE),
> then high overflow to zero in this case, giving unexpected results
> for comparisons "some_address >= high".
>
> Definig high as the address of the last byte of the stack (instead of
> the first byte after the stack) avoids this kind of problem, providing
> that "some_address >= high" is rewritten as "some_address > high" in
> our comparisons.

I agree with using - 1 (or - 4) to prevent high wrapping, but maybe
capping at THREAD_START_SP would simplify the code.

> I don't know whether any stack will be at the top of the address space
> in practice, but I prefer to avoid unnecessary assumptions where
> possible.
>
>
> Do you agree with the code as-is, or does something need to be changed/
> clarified?
>
>> >> >
>> >> >         /* check current frame pointer is within bounds */
>> >> > -       if (fp < (low + 12) || fp + 4 >= high)
>> >> > +       if (fp < 12 || fp - 12 < low || fp > high)
>> >> >                 return -EINVAL;
>> >> >
>> >> >         /* restore the registers from the stack frame */
>> >> > @@ -39,6 +49,10 @@ int notrace unwind_frame(struct stackframe *frame)
>> >> >         frame->sp = *(unsigned long *)(fp - 8);
>> >> >         frame->pc = *(unsigned long *)(fp - 4);
>> >> >
>> >> > +       /* Do not claim the frame is valid if if is obviously corrupt: */
>> >> > +       if (!IS_ALIGNED(frame->fp, 4))
>> >> > +               return -EINVAL;
>> >> > +
>> >> >         return 0;
>> >> >  }
>> >> >  #endif
>> >> >
>> >> >
>> >> > _______________________________________________
>> >> > linux-arm-kernel mailing list
>> >> > linux-arm-kernel at lists.infradead.org
>> >> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> >>
>> >> Dave or Todd, mind reposting this, or should I squash it into my
>> >> CONFIG_SMP stacktrace series?
>> >
>> > I'm happy for you to fold my patch into your series if you agree
>> > with it.  Ideally, please fix my typo in the final comment ("if IT is
>> > obviously corrupt").
>> >
>> > Do I assume correctly that you are already testing this stuff?
>>
>> I've been testing it by repeatedly dumping the stack of a running
>> thread (cat /dev/urandom > /dev/null) and making sure it doesn't
>> panic, and by dumping all the threads in a idle system and making sure
>> they all end at the normal user or kernel thread initial frames
>> (do_exit, kernel_thread_exit, or ret_fast_syscall).
>
> OK -- that's good to know.
>
> I'm still assuming that you're rolling this into your series.  Let me
> know if you want me to post a separate patch.

I'll squash it in to mine.
