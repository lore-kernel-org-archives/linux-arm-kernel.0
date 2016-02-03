From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Feb 2016 21:36:38 +0100
Subject: [PATCH] [RFC] ARM: modify pgd_t definition for
 TRANSPARENT_HUGEPAGE_PUD
In-Reply-To: <20160203163946.GA20360@ravnborg.org>
References: <1773775.QWf7OyDGPh@wuerfel> <20160203163946.GA20360@ravnborg.org>
Message-ID: <15001627.5KATBhJaXU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 February 2016 17:39:46 Sam Ravnborg wrote:
> On Wed, Feb 03, 2016 at 02:21:48PM +0100, Arnd Bergmann wrote:
> > arch/alpha/include/asm/page.h
> > arch/arc/include/asm/page.h
> > arch/arm/include/asm/pgtable-3level-types.h
> > arch/arm64/include/asm/pgtable-types.h
> > arch/ia64/include/asm/page.h
> > arch/parisc/include/asm/page.h
> > arch/powerpc/include/asm/page.h
> > arch/sparc/include/asm/page_32.h
> > arch/sparc/include/asm/page_64.h
> 
> For the sparc32 case we use the simpler variants.
> According to the comment this is due to limitation in
> the way we pass arguments in the sparc32 ABI.
> But I have not tried to compare a kernel for sparc32 with
> and without the use of structs.
> 
> For sparc64 we use the stricter types (structs).
> I did not check other architectures - but just wanted to
> tell that the right choice may be architecture dependent.
> 

I see. I was assuming that they all (wrongly) default to the simple
definitions.

It seems we have these categories:

* both defined, but using strict:
arch/alpha/include/asm/page.h:#define STRICT_MM_TYPECHECKS
arch/sparc/include/asm/page_64.h:#define STRICT_MM_TYPECHECKS
arch/ia64/include/asm/page.h:#  define STRICT_MM_TYPECHECKS
arch/parisc/include/asm/page.h:#define STRICT_MM_TYPECHECKS

* both defined, but using non-strict:
arch/arc/include/asm/page.h:#undef STRICT_MM_TYPECHECKS
arch/arm/include/asm/pgtable-2level-types.h:#undef STRICT_MM_TYPECHECKS
arch/arm/include/asm/pgtable-3level-types.h:#undef STRICT_MM_TYPECHECKS
arch/arm64/include/asm/pgtable-types.h:#undef STRICT_MM_TYPECHECKS
arch/sparc/include/asm/page_32.h:/* #define STRICT_MM_TYPECHECKS */
arch/unicore32/include/asm/page.h:#undef STRICT_MM_TYPECHECKS

* Kconfig option:
arch/powerpc/Kconfig.debug:config STRICT_MM_TYPECHECKS
			 	default n

* only strict defined:
everything else


	Arnd
