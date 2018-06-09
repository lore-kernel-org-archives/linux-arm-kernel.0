From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat, 9 Jun 2018 10:42:27 +0300
Subject: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
In-Reply-To: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com>
 <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
Message-ID: <20180609074227.GA6810@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2018 at 06:32:07PM +0100, Catalin Marinas wrote:
> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 76c0b54443b1..ee079244dc3c 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >  	bool
> >  
> > +config ARCH_32BIT_OFF_T
> > +	bool
> > +	depends on !64BIT
> > +	help
> > +	  All new 32-bit architectures should have 64-bit off_t type on
> > +	  userspace side which corresponds to the loff_t kernel type. This
> > +	  is the requirement for modern ABIs. Some existing architectures
> > +	  already have 32-bit off_t. This option is enabled for all such
> > +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> > +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> > +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> > +	  unicore32, x86_32 and xtensa. This is the complete list. Any
> > +	  new 32-bit architecture should declare 64-bit off_t type on user
> > +	  side and so should not enable this option.
> 
> Do you know if this is the case for riscv and nds32, merged in the
> meantime? If not, I suggest you drop this patch altogether and just
> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> "all new 32-bit architectures should have 64-bit off_t".

I wrote this patch at request of Arnd Bergmann. This is actually his
words that all new 32-bit architectures should have 64-bit off_t. So
I was surprized when riscv was merged with 32-bit off_t (and I didn't
follow nds32).

If this rule is still in force, we'd better add new exceptions to this
patch. Otherwise, we can drop it.

Arnd, could you please comment it?

Yury
