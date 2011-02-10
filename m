From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Feb 2011 11:59:09 -0000
Subject: [PATCH v2] ARM: ptrace: remove single-step emulation code
In-Reply-To: <alpine.LFD.2.00.1102091427200.14920@xanadu.home>
References: <1297248175-11952-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1102091427200.14920@xanadu.home>
Message-ID: <002c01cbc919$ed44b720$c7ce2560$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > PTRACE_SINGLESTEP is a ptrace request designed to offer single-stepping
> > support to userspace when the underlying architecture has hardware
> > support for this operation.
> >
> > On ARM, we set arch_has_single_step() to 1 and attempt to emulate hardware
> > single-stepping by disassembling the current instruction to determine the
> > next pc and placing a software breakpoint on that location.
> >
> > Unfortunately this has the following problems:
> >
> > 1.) Only a subset of ARMv7 instructions are supported
> > 2.) Thumb-2 is unsupported
> > 3.) The code is not SMP safe
> >
> > We could try to fix this code, but it turns out that because of the above
> > issues it is rarely used in practice.  GDB, for example, uses PTRACE_POKETEXT
> > and PTRACE_PEEKTEXT to manage breakpoints itself and does not require any
> > kernel assistance.
> >
> > This patch removes the single-step emulation code from ptrace meaning that
> > the PTRACE_SINGLESTEP request will return -EIO on ARM. Portable code must
> > check the return value from a ptrace call and handle the failure gracefully.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks Nicolas. I'll leave this over the weekend to see if it
attracts further comment before putting it into the patch system.

Cheers,

Will
