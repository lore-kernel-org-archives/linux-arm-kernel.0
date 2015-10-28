From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Oct 2015 12:47:26 +0000
Subject: [PATCH v1] Ftrace: arm/arm64: Define a new arm/arm64 trace clock
 source based on CNTPCT/CNTPCT_EL0 register.
In-Reply-To: <1445854558-16253-1-git-send-email-amittomer25@gmail.com>
References: <1445854558-16253-1-git-send-email-amittomer25@gmail.com>
Message-ID: <20151028124726.GD25451@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 03:45:58PM +0530, Amit wrote:
> From: Amit Singh Tomar <amittomer25@gmail.com>
> 
> Define new arm/arm64 specific trace clock using CNTPCT/CNTPCT_EL0 register,
> similar to x86-tsc. It can be used to correlate trace events across
> hosts and guest that can be useful for debugging purpose.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since RFC:
> 	* Replaced define with static inline
> 	* Revert few changes done in ftrace.txt
> 	* Made it common between ARM and ARM64.
> ---
>  Documentation/trace/ftrace.txt       | 12 ++++++++++++
>  arch/arm/include/asm/Kbuild          |  1 -
>  arch/arm/include/asm/trace_clock.h   | 21 +++++++++++++++++++++
>  arch/arm/kernel/Makefile             |  2 ++
>  arch/arm/kernel/trace_clock.c        | 33 +++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/Kbuild        |  1 -
>  arch/arm64/include/asm/trace_clock.h | 21 +++++++++++++++++++++
>  arch/arm64/kernel/Makefile           |  2 ++
>  8 files changed, 91 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/include/asm/trace_clock.h
>  create mode 100644 arch/arm/kernel/trace_clock.c
>  create mode 100644 arch/arm64/include/asm/trace_clock.h
> 
> diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
> index ef621d3..13f3737 100644
> --- a/Documentation/trace/ftrace.txt
> +++ b/Documentation/trace/ftrace.txt
> @@ -351,6 +351,18 @@ of ftrace. Here is a list of some of the key files:
>  		  to correlate events across hypervisor/guest if
>  		  tb_offset is known.
>  
> +	 arm-pct: This uses ARM Physical Count register value.This
> +	 	  is different from default "local" clock which
> +		  usese Virtual Count register.This is consistent
> +		  across processors and can be used to correlate
> +		  events across host/guest.
> +
> +	 arm64-pct: This uses ARM64 Physical Timer Count register
> +                   value. This is different from default "local"
> +                   clock which usese Virtual Timer Count register.
> +                   This is consistent across processors and can be
> +                   used to correlate events across host/guest.

The above is wrong. Both the physical and virtual counters have the same
guarantees w.r.t. consistency across CPUs for the same VM image. Neither
is more local than the other.

In the host you will have access to CNTVOFF, so you can use that to
correlate the virtual counter.

Additionally, it's not safe to read the physical counter register unless
you know that access has not been denied by the hypervisor; so any Linux
image not booted at hyp cannot use this. If the hypervisor emulates the
access, it will also be horrifically slow.

I don't think this makes sense.

> diff --git a/arch/arm/kernel/trace_clock.c b/arch/arm/kernel/trace_clock.c
> new file mode 100644
> index 0000000..3bf040d
> --- /dev/null
> +++ b/arch/arm/kernel/trace_clock.c
> @@ -0,0 +1,33 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * Copyright (C) 2015 Amit Singh Tomar, amittomer25 at gmail.com
> + *
> + * Thanks to Steven Rostedt and Andre Przywara!
> +*/
> +
> +#include <asm/trace_clock.h>
> +#include <asm/barrier.h>
> +#include <asm/arch_timer.h>
> +
> +static inline u64 get_cntpct(void)
> +{
> +	u64 cycles;
> +
> +	isb();
> +	asm volatile("mrs %0, cntpct_el0" : "=r" (cycles));
> +
> +	return cycles;
> +}

This is arch/arm. This cannot build for 32-bit.

Regardless, this doesn't belong here.

Thanks,
Mark.
