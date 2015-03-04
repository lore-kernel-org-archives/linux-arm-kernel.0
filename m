From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 04 Mar 2015 15:12:02 +0100
Subject: [PATCH 3/8] ARM: make xscale iwmmxt code multiplatform aware
In-Reply-To: <1425043775-3106827-4-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 27 Feb 2015 14:29:30 +0100")
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
 <1425043775-3106827-4-git-send-email-arnd@arndb.de>
Message-ID: <87pp8ozwb1.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> In a multiplatform configuration, we may end up building a kernel
> for both Marvell PJ1 and an ARMv4 CPU implementation. In that
> case, the xscale-cp0 code is built with gcc -march=armv4{,t},
> which results in a build error from the coprocessor instructions.
>
> Since we know this code will only have to run on an actual xscale
> processor, we can simply build the entire file for ARMv5TE.
>
> Related to this, we need to handle the iWMMXT initialization sequence
> differently during boot, to ensure we don't try to touch xscale
> specific registers on other CPUs from the xscale_cp0_init initcall.
> cpu_is_xscale() used to be hardcoded to '1' in any configuration
> that enables any XScale-compatible core, but this breaks once
> we can have a combined kernel with MMP1 and something else.
>
> In this patch, I introduce two new macros, cpu_is_xscale()
> and cpu_is_mohawk, so we can test for all three of them in
> the iwmmxt initialization. The two existing users of
> cpu_is_xscale() are modified accordingly, but slightly
> change behavior for kernels that enable CPU_MOHAWK in combination
> with CPU_XSCALE or CPU_XSC3. Previously, these would leave
> clear PMD_BIT4 in the page tables, now they leave it untouched,
> just like we always do for kernels that enable only CPU_MOHAWK.
> Since the previous behavior was inconsistent, I assume it was
> unintentional.
Hi Arnd,

I'm not sure I understand this patch fully, so take with caution my comment.
If I'm not mistaken, the former behavior was for pxa3xx:
 - cpu_is_xscale() -> false
 - cpu_is_xsc3() -> true
 => this implied PMD_BIT4 was set

With your patch :
 - cpu_is_xscale() -> true
 - cpu_is_xsc3() -> true
 => this implied PMD_BIT4 is not set

I like the new meaning for cpu_is_*(), but is the change of PMD_BIT4 the goal of
this patch (the piece in [1]) ?

Cheers.

--
Robert

[1]
> -	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
> +	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ &&
> +	    !cpu_is_xscale() && !cpu_is_xsc3())
>  		prot |= PMD_BIT4;
>  
>  	pgd += pgd_index(addr);

-- 
Robert
