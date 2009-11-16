From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2009 14:08:30 +0000
Subject: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
In-Reply-To: <20091116133654.14128.175.stgit@localhost.localdomain>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
	<20091116133654.14128.175.stgit@localhost.localdomain>
Message-ID: <20091116140830.GA31522@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 06:36:55AM -0700, Paul Walmsley wrote:
> Fix loop bailout off-by-one bugs reported by Juha Lepp?nen
> <juha_motorsportcom@luukku.com>.

I'm not sure the new code is any easier to read than the old code.
And what with some checks post-loop being <= and others being >, it's
a recipe for cut'n'paste errors happening.

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 633b216..a4a9518 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -759,14 +759,12 @@ static int _reset(struct omap_hwmod *oh)
>  	_write_sysconfig(v, oh);
>  
>  	c = 0;
> -	while (c < MAX_MODULE_RESET_WAIT &&
> -	       !(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
> -		 SYSS_RESETDONE_MASK)) {
> +	while (!(omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
> +		 SYSS_RESETDONE_MASK) &&
> +	       (c++ < MAX_MODULE_RESET_WAIT))
>  		udelay(1);
> -		c++;
> -	}
>  
> -	if (c == MAX_MODULE_RESET_WAIT)
> +	if (c > MAX_MODULE_RESET_WAIT)
>  		WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
>  		     oh->name, MAX_MODULE_RESET_WAIT);
>  	else

How about:

	for (c = 0; c <= MAX_MODULE_RESET_WAIT; c++) {
		if (omap_hwmod_readl(oh, oh->sysconfig->syss_offs) &
		    SYSS_RESETDONE_MASK) {
			pr_debug("omap_hwmod: %s: reset in %d usec\n",
				oh->name, c);
			return 0;
		}
	}

	WARN(1, "omap_hwmod: %s: failed to reset in %d usec\n",
                     oh->name, c - 1);
	return -ETIMEDOUT;

?

Even better would be to turn this into a helper much like wait_event(),
which would stop silly mistakes happening.
