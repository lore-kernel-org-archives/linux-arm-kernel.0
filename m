From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Mar 2010 16:01:01 +0100
Subject: [PATCH] make the default alignment trap behavior configurable
	for user space
In-Reply-To: <alpine.LFD.2.00.0812110915230.14328@xanadu.home>
References: <alpine.LFD.2.00.0812092312130.14328@xanadu.home>
	<200812111015.28688.siarhei.siamashka@nokia.com>
	<alpine.LFD.2.00.0812110915230.14328@xanadu.home>
Message-ID: <20100305150101.GC23225@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> 
> Here's the revised patch:
> 
> From: Nicolas Pitre <nico@cam.org>
> Date: Tue, 9 Dec 2008 23:06:00 -0500
> Subject: [PATCH] [ARM] make the default alignment trap behavior configurable for user space
> 
> For more than a decade, gcc's reliance on the ARM unaligned access
> behavior to optimize code on old ARM CPU versions has been deprecated.
> Still, the default align trap behavior with user space unaligned accesses
> is to let them go through to remain compatible with old binaries from
> before that era.
> 
> However, in the EABI case, there is simply no valid reason for those
> silent unaligned accesses.  They just cannot possibly provide expected
> results anymore since EABI was defined way after the gcc unaligned access
> optimization has been deprecated, and when they occur then silent
> corruptions and/or subtle bugs do result.
> 
> Let's have the default behavior configurable for user space, and default
> that default to fixing up unaligned accesses for EABI systems.
> 
> Signed-off-by: Nicolas Pitre <nico@marvell.com>
I like that patch.  (And I'd choose SIGBUS.)

Is it still considered?
 
Best regards
Uwe

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9722f8b..e8df97f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -934,6 +934,55 @@ config ALIGNMENT_TRAP
>  	  correct operation of some network protocols. With an IP-only
>  	  configuration it is safe to say N, otherwise say Y.
>  
> +choice
> +	prompt "Default behavior for user space unaligned memory access"
> +	depends on ALIGNMENT_TRAP && (CPU_32v3 || CPU_32v4 || CPU_32v4T || CPU_32v5)
> +	default ALIGNMENT_TRAP_USER_FIXUP if AEABI
> +	help
> +	  ARM processors prior ARMv6 cannot fetch/store information which
> +	  isnot naturally aligned on the bus, i.e., a 4 byte fetch must
> +	  start at an address divisible by 4. This option determines what
> +	  is the default behavior when such unaligned accesses are performed
> +	  by user space programs.  This behavior can be changed at run time
> +	  through /proc/cpu/alignment -- see Documentation/arm/mem_alignment
> +	  for the details on that interface.
> +
> +config ALIGNMENT_TRAP_USER_IGNORE
> +	bool "keep hardware defined behavior"
> +	help
> +	  Unaligned memory accesses are architecturally defined to rotate
> +	  right the word-aligned data transferred by a non word-aligned
> +	  address, by 1, 2 or 3 bytes depending on the value of the two
> +	  least significant address bits.
> +
> +	  This is usually not what you want, except if you have to be
> +	  compatible with ancient user space binaries compiled for ARMv3
> +	  with a gcc from around 1994 which used this property to optimize
> +	  some sub-word accesses.
> +
> +config ALIGNMENT_TRAP_USER_SIGBUS
> +	bool "kill with a SIGBUS signal"
> +	help
> +	  User space fetch/store instructions using a misaligned memory
> +	  address will send a SIGBUS signal to the corresponding process
> +	  by default with this choice.  Normally, that process will be
> +	  terminated, and a core dump generated if resource limits allow it.
> +	  Running such a program from gdb, or providing gdb with the
> +	  generated core dump, should identify the exact location in the code
> +	  responsible for the unaligned access so the code could be fixed.
> +
> +config ALIGNMENT_TRAP_USER_FIXUP
> +	bool "fixup by software emulation"
> +	help
> +	  User space fetch/store instructions using a misaligned memory
> +	  address will be emulated in software by default with this choice.
> +	  This provides the highest level of compatibility for programs
> +	  written with no considerations for memory alignment restrictions,
> +	  but with a severe performance impact if a significant number
> +	  of such memory accesses are performed.
> +
> +endchoice
> +
>  endmenu
>  
>  menu "Boot options"
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 2d5884c..c0c366e 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -800,6 +800,12 @@ static int __init alignment_init(void)
>  	res->write_proc = proc_alignment_write;
>  #endif
>  
> +#if defined(CONFIG_ALIGNMENT_TRAP_USER_FIXUP)
> +	ai_usermode = UM_FIXUP;
> +#elif defined(CONFIG_ALIGNMENT_TRAP_USER_SIGBUS)
> +	ai_usermode = UM_SIGNAL;
> +#endif
> +
>  	/*
>  	 * ARMv6 and later CPUs can perform unaligned accesses for
>  	 * most single load and store instructions up to word size.
> @@ -816,6 +822,10 @@ static int __init alignment_init(void)
>  		ai_usermode = UM_FIXUP;
>  	}
>  
> +#ifdef CONFIG_DEBUG_USER 
> +	ai_usermode |= UM_WARN;
> +#endif
> +
>  	hook_fault_code(1, do_alignment, SIGILL, "alignment exception");
>  	hook_fault_code(3, do_alignment, SIGILL, "alignment exception");
>  
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
