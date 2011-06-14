From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jun 2011 22:22:43 +0200
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
References: <20110614190850.GA13526@linux-mips.org>
Message-ID: <201106142222.43553.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 June 2011 21:08:50 Ralf Baechle wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..2968751f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -21,6 +21,7 @@ config ARM
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
>  	select HAVE_IRQ_WORK
> +	select HAVE_PC_PARPORT
>  	select HAVE_PERF_EVENTS
>  	select PERF_USE_VMALLOC
>  	select HAVE_REGS_AND_STACK_ACCESS_API

On arm that should only be set on a couple of subarchitectures, but
we can fan that out after your patch goes in, just like you do for Mips

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2729c66..b8328df 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -128,6 +128,7 @@ config PPC
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select HAVE_SPARSE_IRQ
>  	select IRQ_PER_CPU
>  	select GENERIC_IRQ_SHOW

Similar to ARM and Mips.

> index e446bab..ceac9b5 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -15,6 +15,7 @@ config MICROBLAZE
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  

Highly unlikely, except through PCI.

> diff --git a/arch/score/Kconfig b/arch/score/Kconfig
> index 288add8..ba078d0 100644
> --- a/arch/score/Kconfig
> +++ b/arch/score/Kconfig
> @@ -1,9 +1,10 @@
>  menu "Machine selection"
>  
>  config SCORE
> -       def_bool y
> -       select HAVE_GENERIC_HARDIRQS
> -       select GENERIC_IRQ_SHOW
> +	def_bool y
> +	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
> +	select GENERIC_IRQ_SHOW
>  
>  choice
>  	prompt "System type"

Certainly not, no PIO support

> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 0249b8b..3e96eff 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -8,6 +8,7 @@ config TILE
>  	select USE_GENERIC_SMP_HELPERS
>  	select CC_OPTIMIZE_FOR_SIZE
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_PENDING_IRQ if SMP
>  	select GENERIC_IRQ_SHOW

Only through PCI

> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index e57dcce..3832e7e 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -8,6 +8,7 @@ config UNICORE32
>  	select HAVE_KERNEL_BZIP2
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
> +	select HAVE_PC_PARPORT
>  	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW

Probably not.

I think you can leave these four out right away, provided you add
the section below:

> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -35,8 +35,7 @@ if PARPORT
> 
>  config PARPORT_PC
>  
>         tristate "PC-style hardware"
> 
> -       depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
> -               (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> +       depends on HAVE_PC_PARPORT
> 
>         ---help---
>         
>           You should say Y here if you have a PC-style parallel port. All
>           IBM PC compatible computers and some Alphas have PC-style
> 
> @@ -48,6 +47,9 @@ config PARPORT_PC
> 
>           If unsure, say Y.
> 
> +config HAVE_PC_PARPORT
> +       bool
> +

As you write, anything that has PCI can theoretically take parallel ports,
so I would always list PCI here as a way to get it anyway. Probably also
ISA and PCMCIA. How about adding this?

config HAVE_PC_PARPORT
	bool
	default (PCI || ISA || PCMCIA)

	Arnd
