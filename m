From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 14 Sep 2010 17:08:29 +0900
Subject: [PATCH 2/7] [RFC] ARM: shmobile: remove unneeded hack to
	calculate zreladdr
In-Reply-To: <1283507818-1573-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100914080829.GI7336@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 11:56:53AM +0200, Uwe Kleine-K??nig wrote:
> -config MEMORY_START
> -	hex "Physical memory start address"
> -	default "0x50000000" if MACH_G3EVM
> -	default "0x40000000" if MACH_G4EVM
> -	default "0x40000000" if MACH_AP4EVB
> -	default "0x00000000"
> -	---help---
> -	  Tweak this only when porting to a new machine which does not
> -	  already have a defconfig. Changing it from the known correct
> -	  value on any of the known systems will only lead to disaster.
> -

[snip]

> -#define PHYS_OFFSET	UL(CONFIG_MEMORY_START)
> +#define SH7367_PHYS_OFFSET UL(0x50000000)
> +#define SH7372_PHYS_OFFSET UL(0x40000000)
> +#define SH7377_PHYS_OFFSET UL(0x40000000)
> +
> +#if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
> +# if defined(CONFIG_ARCH_SH7367)
> +#  define PHYS_OFFSET	SH7367_PHYS_OFFSET
> +# elif defined(CONFIG_ARCH_SH7372)
> +#  define PHYS_OFFSET	SH7372_PHYS_OFFSET
> +# elif defined(CONFIG_ARCH_SH7377)
> +#  define PHYS_OFFSET	SH7377_PHYS_OFFSET
> +# endif
> +#endif /* if !defined(CONFIG_RUNTIME_PHYS_OFFSET) */
> +

You've taken a board-specific property and made it CPU-specific. There is
nothing about these CPUs that mandates memory starting here, it just
happens that for the moment we have 1 board per CPU, but that's not an
assumption we can really bank on.
