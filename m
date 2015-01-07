From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 10:25:43 +0000
Subject: [PATCH] arm64: mm: support instruction SETEND
In-Reply-To: <54AD061A.6090602@arm.com>
References: <1420609930-1689-1-git-send-email-leo.yan@linaro.org>
 <54AD061A.6090602@arm.com>
Message-ID: <20150107102543.GD7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 10:10:34AM +0000, Suzuki K. Poulose wrote:
> On 07/01/15 05:52, Leo Yan wrote:
> > Currently kernel has set the bit SCTLR_EL1.SED, so the SETEND
> > instruction will be treated as UNALLOCATED; this error can be
> > reproduced when ARMv8 cpu runs with EL1/aarch64 and EL0/aarch32
> > mode, finally kernel will trap the exception if the userspace
> > libs use SETEND instruction.
> >
> > So this patch clears bit SCTLR_EL1.SED to support SETEND instruction.
> >
> The best way to do this, is via the instruction emulation framework 
> added by Punit, which handles the armv8 deprecated/obsoleted 
> instructions. This is now queued for 3.19.
> I have a patchset which adds the 'SETEND' emulation support to the 
> framework. This will enable better handling of the feature, including 
> finding out the users of the deprecated instruction (when we switch to 
> the emulation mode).
> 
> Btw, there is one open question that I am seeking answer for.
> 
> What should be the endianness of the signal handlers ? Should we leave 
> it to the application ? Or restore the 'default' endianness for the 
> signal handler ?

I think we should restore the default endianness, otherwise you're
essentially forcing signal handlers to do a setend as their first
instruction to get into a consistent state. That also matches the endianness
of the sigframe that we push onto the stack, right?

setjmp/longjmp could be fun, but I think that an application would need
to take care not to make endianness assumptions across those anyway.

Will
