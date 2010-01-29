From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Jan 2010 07:50:06 +0100
Subject: [RFC PATCH 05/12] arm: mm: retry on QSD icache parity errors
In-Reply-To: <1264719577-5436-6-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-6-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129065006.GC1529@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Parity errors in the icache on QSD can be worked around either by
> retrying the access, or invalidating the icache. The whole icache
> must be invalidated since the data abort is imprecise (the faulting
> address is not known).
> 
> Signed-off-by: Steve Muckle <smuckle@quicinc.com>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>


> @@ -442,6 +443,39 @@ do_bad(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	return 1;
>  }
>  
> +static int
> +do_imprecise_ext(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> +{
> +#ifdef CONFIG_ARCH_MSM_SCORPION
> +	unsigned int regval;
> +	static unsigned char flush_toggle;
> +
> +	asm("mrc p15, 0, %0, c5, c1, 0\n" /* read adfsr for fault status */
> +	    : "=r" (regval));
> +	if (regval == 0x2) {
> +		/* Fault was caused by icache parity error. Alternate
> +		 * simply retrying the access and flushing the icache. */
> +		flush_toggle ^= 1;
> +		if (flush_toggle)
> +			asm("mcr p15, 0, %0, c7, c5, 0\n"
> +			    :
> +			    : "r" (regval)); /* input value is ignored */
> +		/* Clear fault in EFSR. */
> +		asm("mcr p15, 7, %0, c15, c0, 1\n"
> +		    :
> +		    : "r" (regval));
> +		/* Clear fault in ADFSR. */
> +		regval = 0;
> +		asm("mcr p15, 0, %0, c5, c1, 0\n"
> +		    :
> +		    : "r" (regval));
> +		return 0;
> +	}
> +#endif

Tell the user or at least keep the count, so cache going bad can be
recognized?

Also you probably need asm volatile, and probably do not need those
\n-s.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
