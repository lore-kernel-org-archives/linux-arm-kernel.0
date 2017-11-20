From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Nov 2017 13:47:22 +0000
Subject: [RFC PATCH] arm64: ftrace: move ftrace-mod.o contents into
 linker script
In-Reply-To: <CAKv+Gu-+Z+O=cTar9-K=PJjEZfzoYdYNiVYAxXM1_WwESfw9sg@mail.gmail.com>
References: <20171120131538.10492-1-ard.biesheuvel@linaro.org>
 <20171120132902.GB2687@arm.com>
 <CAKv+Gu-+Z+O=cTar9-K=PJjEZfzoYdYNiVYAxXM1_WwESfw9sg@mail.gmail.com>
Message-ID: <20171120134722.GC2687@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 01:39:50PM +0000, Ard Biesheuvel wrote:
> On 20 November 2017 at 13:29, Will Deacon <will.deacon@arm.com> wrote:
> > Thanks for this. Somebody ran across this internally a while back, but
> > it slipped through the cracks. I remember thinking at the time that the
> > Kconfig dependencies here looked a little weird too and perhaps
> > ARM64_MODULE_PLTS should be selected by RANDOMIZE_MODULE_REGION_FULL
> > instead of RANDOMIZE_BASE.
> >
> 
> No. Even without RANDOMIZE_MODULE_REGION_FULL, the module region is
> shared with the vmalloc space if the kernel is randomized, and so
> other vmalloc allocations could eat into the module space as well.

Yes, you're right of course.

> > Anyhow, comments below.
> >
> > On Mon, Nov 20, 2017 at 01:15:38PM +0000, Ard Biesheuvel wrote:
> >> When building the arm64 kernel with bot CONFIG_ARM64_MODULE_PLTS and
> >> CONFIG_DYNAMIC_FTRACE enabled, the ftrace-mod.o object file is built
> >> with the kernel and contains a trampoline that is linked into each
> >> module, so that modules can be loaded far away from the kernel and
> >> still reach the ftrace entry point in the core kernel with an ordinary
> >> relative branch, as is emitted by the compiler instrumentation code
> >> dynamic ftrace relies on.
> >>
> >> In order to be able to build out of tree modules, this object file
> >> needs to be included into the linux-headers or linux-devel packages,
> >> which is undesirable, as it makes arm64 a special case (although a
> >> precedent does exist for 32-bit PPC).
> >
> > Agreed that we should avoid the object file, if possible.
> >
> >> Given that the trampoline only consists of two instructions, let's
> >> hack it into the module linker script instead.
> >
> > Why do we have to do this in the linker script? Couldn't we just generate
> > the .S file we currently use?
> >
> 
> Not sure I am following you there. You mean adding a .S source file to
> each module target? Not sure how that would work.

Sorry, I mean something like generating the .S file from the Makefile,
compiling it and then linking the module against it.

Will
