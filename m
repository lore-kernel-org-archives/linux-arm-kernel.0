From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 1 Aug 2017 13:47:02 +0100
Subject: [PATCH 1/2] arm64: syscallno is secretly an int, make it official
In-Reply-To: <20170801113647.GF8702@arm.com>
References: <1500381724-19003-1-git-send-email-Dave.Martin@arm.com>
 <1500381724-19003-2-git-send-email-Dave.Martin@arm.com>
 <20170801113647.GF8702@arm.com>
Message-ID: <20170801124700.GF6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 12:36:47PM +0100, Will Deacon wrote:
> On Tue, Jul 18, 2017 at 01:41:43PM +0100, Dave Martin wrote:
> > The upper 32 bits of the syscallno field in struct pt_regs are handled
> > inconsistently, being sometimes zero extended and sometimes
> > sign-extended.  The reason for this appears to be that they are not
> > intentionally significant at all.
> > 
> > Currently, the only place I can find where those bits are
> > significant is in calling trace_sys_enter(), which may be
> > unintentional: for example, if a compat tracer attempts to cancel a
> > syscall by passing -1 to (COMPAT_)PTRACE_SET_SYSCALL at the
> > syscall-enter-stop, it will be traced as syscall 4294967295
> > rather than -1 as might be expected (and as occurs for a native
> > tracer doing the same thing).  Elsewhere, reads of syscallno cast
> > it to an int or truncate it.
> > 
> > There's also a conspicuous amount of code and casting to bodge
> > around the fact that although semantically an int, syscallno is
> > stored as a u64.
> > 
> > Let's not pretend any more.
> > 
> > In order to preserve the stp x instruction that stores the syscall
> > number in entry.S, this patch special-cases the layout of struct
> > pt_regs for big endian so that the newly 32-bit syscallno field
> > maps onto the low bits of the stored value.  This is not beautiful,
> > but benchmarking of the getpid syscall on Juno suggests indicates a
> > minor slowdown if the stp is split into an stp x and stp w.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>

[...]

> > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > index 11403fd..21c87dc 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -116,7 +116,14 @@ struct pt_regs {
> >  		};
> >  	};
> >  	u64 orig_x0;
> > -	u64 syscallno;
> > +#ifdef __AARCH64EB__
> > +	u32 unused2;
> > +	s32 syscallno;
> > +#else
> > +	s32 syscallno;
> > +	u32 unused2;
> > +#endif
> > +
> >  	u64 orig_addr_limit;
> >  	u64 unused;	// maintain 16 byte alignment
> 
> This isn't a UAPI struct, so we could juggle these about a bit to put all
> the unused padding at the end.

In the __AARCH64EB__ case syscallno still needs to be padded up to an
odd 32-bit boundary, so we need padding before it in that case; also
we'd still need the #ifdef either way, and the struct is already
intentionally a multiple of 16 bytes to align it on the stack.  So I'm
not sure what we'd save here (?)

I could put orig_addr_limit before (padded) syscallno, but I'm not
sure that's better.

Cheers
---Dave
