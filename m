From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Dec 2009 10:16:54 +0000
Subject: [PATCH] ARM: Add atomic64 routines for ARMv6k and above.
In-Reply-To: <20091215082424.GB20571@pengutronix.de>
References: <20091215082424.GB20571@pengutronix.de>
Message-ID: <1260872214.1569.11.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

On Tue, 2009-12-15 at 08:24 +0000, Uwe Kleine-K?nig wrote:
> On Fri, Dec 11, 2009 at 06:13:57PM +0000, Will Deacon wrote:
> > In preparation for perf-events support, ARM needs to support atomic64_t
> > operations. v6k and above support the ldrexd and strexd instructions to do
> > just that.
> >
> > This patch adds atomic64 support to the ARM architecture. v6k and above
> > make use of new instructions whilst older cores fall back on the generic
> > solution using spinlocks. If and when v7-M cores are supported by Linux, they
> > will need to fall back on the spinlock implementation too.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Jamie Iles <jamie.iles@picochip.com>
> > ---
> >  arch/arm/Kconfig              |    1 +
> >  arch/arm/include/asm/atomic.h |  228 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 229 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1c4119c..5fdc032 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -18,6 +18,7 @@ config ARM
> >       select HAVE_KRETPROBES if (HAVE_KPROBES)
> >       select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
> >       select HAVE_GENERIC_DMA_COHERENT
> > +     select GENERIC_ATOMIC64 if (!CPU_32v6K)
> 
> If a kernel supports say a v5 and a v6 then IIRC CPU_32v6K is enabled,
> but GENERIC_ATOMIC64 is needed, too.

CPU_32v6K is enabled by (v6 && SMP) || v7.

I doubt we would ever be able to compile a v5 kernel while having
CPU_32v6K enabled. A lot o macros are conditionally defined at
preprocessing time based on the architecture version (e.g.
asm/system.h). Even if you get v5 and v6 in the same kernel to compile
fine, you would miss some macros like dmb() or isb() which are needed on
v6 so the kernel may not have the expected behaviour.

While you could fix this with some performance penalties, I'm not sure
it's worth the effort.

-- 
Catalin
