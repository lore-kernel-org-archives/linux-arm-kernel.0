From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jan 2017 16:44:18 +0000
Subject: [PATCH] arm64: assembler: make adr_l work in modules under KASLR
In-Reply-To: <CAKv+Gu-FMCdkxpFCheCoRrCYFUdZPpViH4-G613sXyQVEH3chA@mail.gmail.com>
References: <1484146493-18460-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170111151822.GC26344@leverpostej>
 <CAKv+Gu9DxMzSTVRPdeSaJQNqe5RGjS_qzVzBU1SpGs5EZvCE1Q@mail.gmail.com>
 <20170111153447.GD26344@leverpostej>
 <CAKv+Gu-FMCdkxpFCheCoRrCYFUdZPpViH4-G613sXyQVEH3chA@mail.gmail.com>
Message-ID: <20170111164418.GC28883@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 04:08:30PM +0000, Ard Biesheuvel wrote:
> On 11 January 2017 at 15:34, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jan 11, 2017 at 03:25:09PM +0000, Ard Biesheuvel wrote:
> >> On 11 January 2017 at 15:18, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Jan 11, 2017 at 02:54:53PM +0000, Ard Biesheuvel wrote:

> >> But in general, if the macro is available to modules, I would like to
> >> make sure that it does not result in code that builds fine but may
> >> fail in some cases only at runtime, especially given the fact that
> >> there is also a Cortex-A53 erratum regarding adrp instructions, for
> >> which reason we build modules with -mcmodel=large (which amounts to
> >> the same thing as the patch above)
> >>
> >> > It seems somewhat surprising to me to have adr_l expand to something
> >> > that doesn't use adr/adrp, but that's not necessarily a problem.
> >>
> >> I did realise that, but I don't think it is a problem tbh.
> >
> > In this case it should be fine, certainly.
> >
> > There are cases like the early boot code and hyp code where it's
> > critical that we use adr. It's also possible that we might build
> > (modular) drivers which want some idmapped code, where we want adr, so
> > it seems unfortunate that this depends on howthe code is built.
> 
> How would /that/ work? Modules are vmalloc'ed, and not covered by the
> ID map to begin with, so it is impossible to execute those adr
> instructions in a way that would make them return anything other than
> the virtual address of the symbol they refer to.

That's a fair point.

> > So, maybe it's better to have a mov_sym helper for this case, to be
> > explicit about what we want? That can use either adr* or mov*, or the
> > latter consistently.
> 
> Well, the point is that adr_l should not be used for modules so adding
> something that may be used is fine, but that still leaves the risk
> that someone may end up using it in a module.

Sure.

Given you have a concrete use case, and all I have are some vague
concerns for code that doesn't exist at present, I have no real
objection to the patch as it stands. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
