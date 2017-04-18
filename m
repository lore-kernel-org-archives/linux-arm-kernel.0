From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 18 Apr 2017 11:12:25 -0700
Subject: arm64: Question about warnings due to unspecified ASM operand
 width
In-Reply-To: <20170418113849.GC27592@e104818-lin.cambridge.arm.com>
References: <20170418013156.GB105296@google.com>
 <20170418113849.GC27592@e104818-lin.cambridge.arm.com>
Message-ID: <20170418181225.GB128305@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

El Tue, Apr 18, 2017 at 12:38:49PM +0100 Catalin Marinas ha dit:

> On Mon, Apr 17, 2017 at 06:31:56PM -0700, Matthias Kaehlcke wrote:
> > During my work on improving support for kernel builds with clang I
> > came across a bunch of warnings on arm64 builds about the width of
> > operands in assembly not being specified:
> > 
> > arch/arm64/include/asm/arch_timer.h:92:46: error: value size does
> >       not match register size specified by the constraint and modifier [-Werror,-Wasm-operand-widths]
> >         asm volatile("mrs %0,   cntfrq_el0" : "=r" (val));
> 
> I think the first step would be to test it against a newer kernel. The
> above code disappeared in 4.9 in favour of dedicated read_sysreg()
> macros which shouldn't give this warning (u64 __val).

Sure, it was just one example from the 4.4 kernel my project currently
uses. There are others in more recent kernel versions.

> > I understand that this is usually not a problem and might even be
> > desired to give the compiler more flexiblity in the use of the
> > available registers.
> 
> I don't think arm64 would benefit from such ambiguity, so we should
> rather fix them. In practice there is no issue since the compiler cannot
> allocate two 32-bit variables in a 64-bit register.

Thanks for the clarification!

According to Ard there is the case of the msr/mrs instructions to
consider, but lets talk about this in the subthread of his reply.

Matthias
