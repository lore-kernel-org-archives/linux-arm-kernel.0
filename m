From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Jul 2015 12:09:05 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG
 traps
In-Reply-To: <20150714102025.GD10670@e103592.cambridge.arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
 <20150713164315.GC22840@leverpostej>
 <20150713165151.GC10670@e103592.cambridge.arm.com>
 <20150713165638.GD22840@leverpostej>
 <20150714102025.GD10670@e103592.cambridge.arm.com>
Message-ID: <20150714110904.GB12675@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 11:20:27AM +0100, Dave P Martin wrote:
> On Mon, Jul 13, 2015 at 05:56:39PM +0100, Mark Rutland wrote:
> > On Mon, Jul 13, 2015 at 05:51:51PM +0100, Dave P Martin wrote:
> > > On Mon, Jul 13, 2015 at 05:43:15PM +0100, Mark Rutland wrote:
> 
> [...]
> 
> > > > Given the reliance on the labels in the caller, I think it might make
> > > 
> > > Not sure what you mean here, can you elaborate?
> > 
> > We're relying on label "0:" in the caller/user of the macro when we emit
> > ".long 2b - 0b".
> > 
> > I think it would be clearer if folded into the caller (even with the
> > inline ifdef this necessitates).
> > 
> > Though I could be missing something here that renders that impossible.
> 
> Before I respin the series, can you cast your eye over this
> alternative?
> 
> I'm testing it now, but in any case it should make the conditional
> structure of the code clearer as per your suggestion.

I think that style of macro is certainly more legible when applied to
single lines, but I got a little confused when reading this before I
noticed that each __BUGVERBOSE use covered a few lines.

Thanks,
Mark.

> 
> Cheers
> ---Dave
> 
> 
> [...]
> 
> #ifdef CONFIG_DEBUG_BUGVERBOSE
> #define __BUGVERBOSE(x...) x
> #else
> #define __BUGVERBOSE(x...)
> #endif
> 
> #define _BUG_FLAGS(flags, file, line) __BUG_FLAGS(flags, file, line)
> 
> #define __BUG_FLAGS(flags, file, line) asm volatile (			\
>  __BUGVERBOSE(	".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
> 	"2:	.string \"" file "\"\n\t"				\
> 		".popsection\n\t"				)	\
> 									\
> 		".pushsection __bug_table,\"a\"\n\t"			\
> 		".align 2\n\t"						\
> 	"0:	.long 1f - 0b\n\t"					\
>  __BUGVERBOSE(	".long 2b - 0b\n\t"					\
> 		".short " #line "\n\t"	)				\
> 		".short " #flags "\n\t"					\
> 		".popsection\n"						\
> 									\
> 	"1:	brk %[imm]"						\
> 		:: [imm] "i" (BUG_BRK_IMM)				\
> )
> 
> #define BUG() do {				\
> 	_BUG_FLAGS(0, __FILE__, __LINE__);	\
> 	unreachable();				\
> } while (0)
> 
> #define __WARN_TAINT(taint)					\
> 	_BUG_FLAGS(BUGFLAG_TAINT(taint), __FILE__, __LINE__)
> 
> [...]
