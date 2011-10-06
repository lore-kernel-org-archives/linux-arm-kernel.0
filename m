From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 23:29:12 +0100
Subject: [PATCH v2] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
	control detection
In-Reply-To: <alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
	<CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
	<alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
Message-ID: <20111006222912.GA27281@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 01:47:22PM -0600, Paul Walmsley wrote:
> +	if ((omap_rev() == OMAP3430_REV_ES3_1 ||
> +	     omap_rev() == OMAP3430_REV_ES3_1_2) ||
> +	    cpu_is_omap3630())
> +		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;

	(a || b) || c === a || b || c

IOW, no need for the additional parens.

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7255d9b..a6156bd 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -99,31 +99,28 @@ static void omap3_enable_io_chain(void)
>  {
>  	int timeout = 0;
>  
> -	if (omap_rev() >= OMAP3430_REV_ES3_1) {
> -		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> -				     PM_WKEN);
> -		/* Do a readback to assure write has been done */
> -		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> -
> -		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> -			 OMAP3430_ST_IO_CHAIN_MASK)) {
> -			timeout++;
> -			if (timeout > 1000) {
> -				printk(KERN_ERR "Wake up daisy chain "
> -				       "activation failed.\n");
> -				return;
> -			}
> -			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> -					     WKUP_MOD, PM_WKEN);
> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +				   PM_WKEN);
> +	/* Do a readback to assure write has been done */
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> +
> +	while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> +		 OMAP3430_ST_IO_CHAIN_MASK)) {
> +		timeout++;
> +		if (timeout > 1000) {
> +			printk(KERN_ERR "Wake up daisy chain "
> +			       "activation failed.\n");
> +			return;
>  		}
> +		omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> +					   WKUP_MOD, PM_WKEN);
>  	}

This should've been caught before.  Two things:

1. Do you know how long it takes this to time out?
2. Don't wrap error printks, it prevents them being grepped for.
