From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 7 Dec 2017 16:15:02 +0000
Subject: [PATCH v3 11/20] arm64: assembler: add macros to conditionally
 yield the NEON under PREEMPT
In-Reply-To: <CAKv+Gu-Otcg4UxhJA44PbbYamBJd26Be+YsSUQUaB+qy9owzvQ@mail.gmail.com>
References: <20171206194346.24393-1-ard.biesheuvel@linaro.org>
 <20171206194346.24393-12-ard.biesheuvel@linaro.org>
 <20171207143934.GF22781@e103592.cambridge.arm.com>
 <CAKv+Gu8N6w3+VFpF3kq-qg9Gij=4VbtQqu+yfvfA67p2kWaRLg@mail.gmail.com>
 <CAKv+Gu-Otcg4UxhJA44PbbYamBJd26Be+YsSUQUaB+qy9owzvQ@mail.gmail.com>
Message-ID: <20171207161502.GI22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 03:47:43PM +0000, Ard Biesheuvel wrote:
> On 7 December 2017 at 14:50, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 7 December 2017 at 14:39, Dave Martin <Dave.Martin@arm.com> wrote:
> >> On Wed, Dec 06, 2017 at 07:43:37PM +0000, Ard Biesheuvel wrote:

[...]

> >>> +     .macro          if_will_cond_yield_neon
> >>> +#ifdef CONFIG_PREEMPT
> >>> +     get_thread_info x0
> >>> +     ldr             w1, [x0, #TSK_TI_PREEMPT]
> >>> +     ldr             x0, [x0, #TSK_TI_FLAGS]
> >>> +     cmp             w1, #1 // == PREEMPT_OFFSET
> >>
> >> Can we at least drop a BUILD_BUG_ON() somewhere to check this?
> >>
> >> Maybe in kernel_neon_begin() since this is intimately kernel-mode NEON
> >> related.
> >>
> >
> > Sure.
> >
> 
> I only just understood your asm-offsets remark earlier. I wasn't aware
> that it allows exposing random constants as well (although it is
> fairly obvious now that I do). So I will expose PREEMPT_OFFSET rather
> than open code it

[...]

OK, yes, this works for any C expression that is compiletime-constant
but requires evaluation that the assembler doesn't understand.

Cheers
---Dave
