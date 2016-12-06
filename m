From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 6 Dec 2016 17:03:24 +0000
Subject: [RFC PATCH] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <CAKv+Gu8dAumcEV8Wk+8rXO3VnN0e9rAHac=3-FMhra=tZgeVxg@mail.gmail.com>
References: <1481038740-11633-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161206164317.GX1574@e103592.cambridge.arm.com>
 <CAKv+Gu8dAumcEV8Wk+8rXO3VnN0e9rAHac=3-FMhra=tZgeVxg@mail.gmail.com>
Message-ID: <20161206170324.GY1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 04:48:54PM +0000, Ard Biesheuvel wrote:
> On 6 December 2016 at 16:43, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Tue, Dec 06, 2016 at 03:39:00PM +0000, Ard Biesheuvel wrote:
> >> Currently, we allow kernel mode NEON in softirq or hardirq context by
> >> stacking and unstacking a slice of the NEON register file for each call
> >> to kernel_neon_begin() and kernel_neon_end(), respectively.
> >>
> >> Given that
> >> a) a CPU typically spends most of its time in userland, during which time
> >>    no kernel mode NEON in process context is in progress,
> >> b) a CPU spends most of its time in the kernel doing other things than
> >>    kernel mode NEON when it gets interrupted to perform kernel mode NEON
> >>    in softirq context
> >>
> >> the stacking and subsequent unstacking is only necessary if we are
> >> interrupting a thread while it is performing kernel mode NEON in process
> >> context, which means that in all other cases, we can simply preserve the
> >> userland FPSIMD state once, and only restore it upon return to userland,
> >> even if we are being invoked from softirq or hardirq context.
> >>
> >> So instead of checking whether we are running in interrupt context, keep
> >> track of the level of nested kernel mode NEON calls in progress, and only
> >> perform the eager stack/unstack of the level exceeds 1.

[...]

> >> +     this_cpu_write(kernel_neon_nesting_level, level + 1);
> >
> > Should we BUG_ON overflow/underflow of the nesting level?  That Should
> > Not Happen (tm), but we'll make a mess if it does.
> >
> 
> True.
> 
> > For the underflow case, perhaps DEBUG_PREEMPT is adequate for detecting
> > this via preempt count underflow.
> >
> 
> I think it makes sense for the increment to check for overflow and the
> decrement to check for underflow, regardless of whether DEBUG_PREEMPT
> (or just PREEMPT) is enabled or not.

Fair enough

Cheers
---Dave

[...]
