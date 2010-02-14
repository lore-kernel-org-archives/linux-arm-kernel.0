From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 21:23:27 +0530
Subject: [PATCH 08/10] ARM: ftrace: fix and update dynamic ftrace
In-Reply-To: <20100214110840.GA21357@pengutronix.de>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-9-git-send-email-rabin@rab.in>
	<20100214110840.GA21357@pengutronix.de>
Message-ID: <20100214155326.GA2842@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 14, 2010 at 12:08:40PM +0100, Uwe Kleine-K?nig wrote:
> > diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> > index 103f7ee..4a56a2e 100644
> > --- a/arch/arm/include/asm/ftrace.h
> > +++ b/arch/arm/include/asm/ftrace.h
> > @@ -2,12 +2,29 @@
> >  #define _ASM_ARM_FTRACE
> >  
> >  #ifdef CONFIG_FUNCTION_TRACER
> > -#define MCOUNT_ADDR		((long)(mcount))
> > +#define MCOUNT_ADDR		((unsigned long)(__gnu_mcount_nc))
> hhmm, does this work with both the old and the new mcount function?

Yes, MCOUNT_ADDR is not used by the generic ftrace code directly, but is
instead only passed to our arch specific functions.  We determine the
right mcount address to use there:

> +#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
[..]
> +static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
> +{
> +	if (!rec->arch.old_mcount)
> +		return addr;
> +
> +	if (addr == MCOUNT_ADDR)
> +		addr = OLD_MCOUNT_ADDR;
> +	else if (addr == FTRACE_ADDR)
> +		addr = OLD_FTRACE_ADDR;
> +
> +	return addr;
> +}

I changed MCOUNT_ADDR from mcount to __gnu_mcount_nc because we always
build __gnu_mcount_nc in, but don't build mcount when using Thumb-2.

Rabin
