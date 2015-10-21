From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 21 Oct 2015 09:44:04 -0400
Subject: [PATCH RFC] arm64/ftrace: Define a new arm64 trace clock source
 based on cntpct_el0 register.
In-Reply-To: <1445170639-13943-1-git-send-email-amittomer25@gmail.com>
References: <1445170639-13943-1-git-send-email-amittomer25@gmail.com>
Message-ID: <20151021094404.0e3114f9@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Oct 2015 17:47:19 +0530
Amit <amittomer25@gmail.com> wrote:

> From: Amit Singh Tomar <amittomer25@gmail.com>
> 
> Currenty, Default trace clock("local") for host and guest is out of sync. 
> This default clock is based on cntvct_el0 register value and both host/guest
> see different values of cntvct_el0.
> 
> Intention here is to get a clock whose timestamps are comparable between host/guest.
> It can be achieved by using clock based on cntpct_el0 register values(host/guest
> see same value of cntpct_el0 register all the time).
> 
> Define a new arm64 specific trace clock using the cntpct_el0 register,
> similar to x86-tsc. It can be used to correlate trace events across
> hosts and guest that can be useful for debuging purpose.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
>  Documentation/trace/ftrace.txt       |  8 +++++++-
>  arch/arm64/include/asm/Kbuild        |  1 -
>  arch/arm64/include/asm/trace_clock.h | 21 +++++++++++++++++++++
>  arch/arm64/kernel/Makefile           |  1 +
>  arch/arm64/kernel/trace_clock.c      | 23 +++++++++++++++++++++++
>  5 files changed, 52 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/trace_clock.h
>  create mode 100644 arch/arm64/kernel/trace_clock.c
> 
> diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
> index ef621d3..6420e32 100644
> --- a/Documentation/trace/ftrace.txt
> +++ b/Documentation/trace/ftrace.txt
> @@ -323,7 +323,7 @@ of ftrace. Here is a list of some of the key files:
>  	Usual clocks for tracing:
>  
>  	  # cat trace_clock
> -	  [local] global counter x86-tsc
> +	  [local] global counter x86-tsc arm64-pct

You don't need to update this line. You can't have both x86-tsc and
arm64-pct at the same time.

>  
>  	  local: Default clock, but may not be in sync across CPUs
>  
> @@ -351,6 +351,12 @@ of ftrace. Here is a list of some of the key files:
>  		  to correlate events across hypervisor/guest if
>  		  tb_offset is known.
>  
> +	arm64-pct: This uses ARM64 Physical Timer Count register
> +		   value. This is different from default "local"
> +		   clock which usese Virtual Timer Count register.
> +		   This is consistent across processors and can be
> +		   used to correlate events across host/guest.
> +
>  	To set a clock, simply echo the clock name into this file.
>  
>  	  echo global > trace_clock
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 70fd9ff..8608f9e 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -50,7 +50,6 @@ generic-y += switch_to.h
>  generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += topology.h
> -generic-y += trace_clock.h
>  generic-y += types.h
>  generic-y += unaligned.h
>  generic-y += user.h
> diff --git a/arch/arm64/include/asm/trace_clock.h b/arch/arm64/include/asm/trace_clock.h
> new file mode 100644
> index 0000000..aef4ccd
> --- /dev/null
> +++ b/arch/arm64/include/asm/trace_clock.h
> @@ -0,0 +1,21 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * Copyright (C) 2015 Amit Singh Tomar, amittomer25 at gmail.com
> +*/
> +
> +#ifndef _ASM_ARM_TRACE_CLOCK_H
> +#define _ASM_ARM_TRACE_CLOCK_H
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +extern u64 notrace trace_clock_arm64_pct(void);
> +
> +# define ARCH_TRACE_CLOCKS \
> +	{ trace_clock_arm64_pct,  "arm64-pct",  0},
> +
> +#endif  /* _ASM_ARM_TRACE_CLOCK_H */
> +
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 22dc9bc..d58f885 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -36,6 +36,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
>  arm64-obj-$(CONFIG_PCI)			+= pci.o
>  arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
>  arm64-obj-$(CONFIG_ACPI)		+= acpi.o
> +arm64-obj-$(CONFIG_TRACING)             += trace_clock.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/trace_clock.c b/arch/arm64/kernel/trace_clock.c
> new file mode 100644
> index 0000000..f038977
> --- /dev/null
> +++ b/arch/arm64/kernel/trace_clock.c
> @@ -0,0 +1,23 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * Copyright (C) 2015 Amit Singh Tomar, amittomer25 at gmail.com
> +*/
> +
> +#include <asm/trace_clock.h>
> +
> +#define read_cnt_pct(cnt_pct) do {				\
> +	__asm__ __volatile("isb; mrs %0, cntpct_el0; isb ;"	\
> +	: "=r" (cnt_pct));					\
> +} while (0)

Why is this a define and not a static inline?

-- Steve

> +
> +u64 notrace trace_clock_arm64_pct(void)
> +{
> +	u64 cnt_pct;
> +
> +	read_cnt_pct(cnt_pct);
> +	return  cnt_pct;
> +}
> +
