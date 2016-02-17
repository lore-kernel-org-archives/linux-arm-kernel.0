From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Feb 2016 14:39:51 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <56C31D1D.50708@virtuozzo.com>
References: <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com>
Message-ID: <20160217143950.GC32647@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 03:59:09PM +0300, Andrey Ryabinin wrote:
> Actually, the first report is a bit more useful. It shows that shadow memory was corrupted:
> 
>   ffffffc93665bc00: f1 f1 f1 f1 00 f4 f4 f4 f2 f2 f2 f2 00 00 f1 f1
> > ffffffc93665bc80: f1 f1 00 00 00 00 f3 f3 00 f4 f4 f4 f3 f3 f3 f3
>                       ^
> F1 - left redzone, it indicates start of stack frame
> F3 - right redzone, it should be the end of stack frame.
> 
> But here we have the second set of F1s without F3s which should close the first set of F1s.
> Also those two F3s in the middle cannot be right.
> 
> So shadow is corrupted.
> Some hypotheses:

> 2) Shadow memory wasn't cleared. GCC poison memory on function entrance and unpoisons it before return.
>      If we use some tricky way to exit from function this could cause false-positives like that.
>      E.g. some hand-written assembly return code.

I think this is what's happenening, at least for the idle case.

A second attempt at bisecting led me to commit e679660dbb8347f2 ("ARM:
8481/2: drivers: psci: replace psci firmware calls"). Reverting that
makes v4.5-rc1 boot without KASAN splats.

That patch turned __invoke_psci_fn_{smc,hvc} into (ASAN-instrumented) C
functions. Prior to that commit, __invoke_psci_fn_{smc,hvc} were
pure assembly functions which used no stack.

When we go down for idle, in __cpu_suspend_enter we stash some context
to the stack (in assembly). The CPU may return from a cold state via
cpu_resume, where we restore context from the stack.

However, after storing the context we call psci_suspend_finisher, which
calls psci_cpu_suspend, which calls invoke_psci_fn_*. As
psci_cpu_suspend and invoke_psci_fn_* are instrumented, they poison
memory on function entrance, but we never perform the unpoisoning.

That was always the case for psci_suspend_finisher, so there was a
latent issue that we were somehow avoiding. Perhaps we got luck with
stack layout and never hit the poison.

I'm not sure how we fix that, as invoke_psci_fn_* may or may not return
for arbitrary reasons (e.g. a CPU_SUSPEND_CALL may or may not return
depending on whether an interrupt comes in at the right time).

Perhaps the simplest option is to not instrument invoke_psci_fn_* and
psci_suspend_finisher. Do we have a per-function annotation to avoid
KASAN instrumentation, like notrace? I need to investigate, but we may
also need notrace for similar reasons.

Andrey, on a tangential note, what do we do around hotplug? I assume
that we must unpooison the shadow region for the stack of a dead CPU,
but I wasn't able to figure out where we do that. Hopefuly we're not
just getting lucky?

Thanks,
Mark.
