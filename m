From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 13:24:06 +0000
Subject: [PATCH v4 12/19] ARM: LPAE: Add context switching support
In-Reply-To: <20110212104400.GF15616@n2100.arm.linux.org.uk>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-13-git-send-email-catalin.marinas@arm.com>
	<20110212104400.GF15616@n2100.arm.linux.org.uk>
Message-ID: <1297689846.31111.43.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-02-12 at 10:44 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 24, 2011 at 05:55:54PM +0000, Catalin Marinas wrote:
> > +#ifdef CONFIG_ARM_LPAE
> > +#define cpu_set_asid(asid) {                                         \
> > +     unsigned long ttbl, ttbh;                                       \
> > +     asm("   mrrc    p15, 0, %0, %1, c2              @ read TTBR0\n" \
> > +         "   mov     %1, %1, lsl #(48 - 32)          @ set ASID\n"   \
> > +         "   mcrr    p15, 0, %0, %1, c2              @ set TTBR0\n"  \
> > +         : "=r" (ttbl), "=r" (ttbh)                                  \
> > +         : "r" (asid & ~ASID_MASK));                                 \
> 
> This is wrong:
> 1. It does nothing with %2 (the new asid)
> 2. it shifts the high address bits of TTBR0 left 16 places each time its
>    called.

It was worse actually, not even compiled in because it had output
arguments but it wasn't volatile. Some early clobber is also needed.
What about this:

#define cpu_set_asid(asid) {						\
	unsigned long ttbl, ttbh;					\
	asm volatile(							\
	"	mrrc	p15, 0, %0, %1, c2		@ read TTBR0\n"	\
	"	mov	%1, %2, lsl #(48 - 32)		@ set ASID\n"	\
	"	mcrr	p15, 0, %0, %1, c2		@ set TTBR0\n"	\
	: "=&r" (ttbl), "=&r" (ttbh)					\
	: "r" (asid & ~ASID_MASK));					\
}

-- 
Catalin
