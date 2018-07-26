From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jul 2018 14:20:06 +0100
Subject: [PATCH 6/6] ARM: spectre-v1: mitigate user accesses
In-Reply-To: <20180726124900.syqvsltidm4c2oud@lakrids.cambridge.arm.com>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctPA-0005vT-QX@rmk-PC.armlinux.org.uk>
 <20180726124900.syqvsltidm4c2oud@lakrids.cambridge.arm.com>
Message-ID: <20180726132006.GY17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:49:00PM +0100, Mark Rutland wrote:
> On Tue, Jul 10, 2018 at 03:14:12PM +0100, Russell King wrote:
> > Spectre variant 1 attacks are about this sequence of pseudo-code:
> > 
> > 	index = load(user-manipulated pointer);
> > 	access(base + index * stride);
> > 
> > In order for the cache side-channel to work, the access() must me made
> > to memory which userspace can detect whether cache lines have been
> > loaded.  On 32-bit ARM, this must be either user accessible memory, or
> > a kernel mapping of that same user accessible memory.
> > 
> > The problem occurs when the load() speculatively loads privileged data,
> > and the subsequent access() is made to user accessible memory.
> > 
> > Any load() which makes use of a user-maniplated pointer is a potential
> > problem if the data it has loaded is used in a subsequent access.  This
> > also applies for the access() if the data loaded by that access is used
> > by a subsequent access.
> > 
> > Harden the get_user() accessors against Spectre attaacks by forcing out
> > of bounds addresses to a NULL pointer.  This prevents get_user() being
> > used as the load() step above.  As a side effect, put_user() will also
> > be affected even though it isn't implicated.
> > 
> > Also harden copy_from_user() by redoing the bounds check within the
> > arm_copy_from_user() code, and NULLing the pointer if out of bounds.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  arch/arm/include/asm/assembler.h | 4 ++++
> >  arch/arm/lib/copy_from_user.S    | 7 +++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> > index ef1386b1af9b..f0515f60cff5 100644
> > --- a/arch/arm/include/asm/assembler.h
> > +++ b/arch/arm/include/asm/assembler.h
> > @@ -460,6 +460,10 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
> >  	adds	\tmp, \addr, #\size - 1
> >  	sbcccs	\tmp, \tmp, \limit
> >  	bcs	\bad
> > +#ifdef CONFIG_CPU_SPECTRE
> > +	movcs	\addr, #0
> > +	csdb
> > +#endif
> >  #endif
> >  	.endm
> >  
> > diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> > index 7a4b06049001..ebf292e9478f 100644
> > --- a/arch/arm/lib/copy_from_user.S
> > +++ b/arch/arm/lib/copy_from_user.S
> > @@ -90,6 +90,13 @@
> >  	.text
> >  
> >  ENTRY(arm_copy_from_user)
> > +	get_thread_info r3
> > +	ldr	r3, [r3, #TI_ADDR_LIMIT]
> > +	adds	ip, r1, r2	@ ip=addr+size
> > +	sub	r3, r3, #1	@ addr_limit - 1
> > +	cmpcc	ip, r3		@ if (addr+size > addr_limit - 1)
> > +	movcs	r1, #0		@ addr = NULL
> > +	csdb
> 
> Given spectre-v1.1, I believe we need to do the same for
> arm_copy_to_user().

Spectre v1.1 is not covered by this patch series and is a subject for
future work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
