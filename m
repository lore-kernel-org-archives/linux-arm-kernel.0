From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 05 Jul 2012 21:35:51 +0900
Subject: [PATCH v2 1/2] ARM: arch timer: implement read_current_timer and
 get_cycles
In-Reply-To: <1340991231-17682-2-git-send-email-will.deacon@arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-2-git-send-email-will.deacon@arm.com>
Message-ID: <4FF58A27.7030309@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 6/30/2012 2:33 AM, Will Deacon wrote:
>  arch/arm/include/asm/arch_timer.h |    3 +++
>  arch/arm/include/asm/timex.h      |   10 ++++++----
>  arch/arm/kernel/arch_timer.c      |    8 ++++++++
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
[...]
> diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
> index 3be8de3..ce11944 100644
> --- a/arch/arm/include/asm/timex.h
> +++ b/arch/arm/include/asm/timex.h
> @@ -12,13 +12,15 @@
>  #ifndef _ASMARM_TIMEX_H
>  #define _ASMARM_TIMEX_H
>  
> +#include <asm/arch_timer.h>
>  #include <mach/timex.h>
>  
>  typedef unsigned long cycles_t;
>  
> -static inline cycles_t get_cycles (void)
> -{
> -	return 0;
> -}
> +#ifdef ARCH_HAS_READ_CURRENT_TIMER
> +#define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
> +#else
> +#define get_cycles()	(0)
> +#endif
>  
>  #endif

Except <asm/arch_timer.h> inclusion, this change is not arch_timer-
dependent, but general parts for ARM, connecting read_current_timer()
and get_cycles().  Should be folded into patch 2/2.


  Shinya
