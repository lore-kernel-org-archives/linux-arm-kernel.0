From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 10:21:06 +0100
Subject: [PATCH v6 14/21] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1452209679-19445-15-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-15-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <8354919.jOyEk0znB5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 02:34:32 Yury Norov wrote:

> @@ -688,6 +692,12 @@ ni_sys:
>  	b	ret_fast_syscall
>  ENDPROC(el0_svc)
>  
> +#ifdef CONFIG_ARM64_ILP32
> +el0_ilp32_svc:
> +	adrp	stbl, sys_call_ilp32_table // load syscall table pointer
> +	b el0_svc_naked
> +#endif

Don't we still need some code that clears the top halves of the 32-bit
arguments? That thread has taken so many turns now that I'm confused
about what we actually need, but I thought we had concluded that your
current approach has at some some problems.

> +#include <asm/syscall.h>
> +
> +#undef __SYSCALL
> +#undef __SC_COMP
> +#undef __SC_3264
> +#undef __SC_COMP_3264

The four #undef are not needed, right?

	Arnd
