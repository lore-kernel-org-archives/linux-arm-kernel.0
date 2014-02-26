From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Feb 2014 15:06:32 +0100
Subject: [PATCH] scripts/link-vmlinux.sh: correct base address for some
 ARM special cases
In-Reply-To: <20140226135352.GY21483@n2100.arm.linux.org.uk>
References: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140226111507.GW21483@n2100.arm.linux.org.uk>
 <20140226134605.GF6865@pengutronix.de>
 <20140226135352.GY21483@n2100.arm.linux.org.uk>
Message-ID: <20140226140632.GG6865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 01:53:52PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 26, 2014 at 02:46:05PM +0100, Uwe Kleine-K?nig wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1595,6 +1595,7 @@ endchoice
> >  
> >  config PAGE_OFFSET
> >  	hex
> > +	default DRAM_BASE if !MMU
> >  	default 0x40000000 if VMSPLIT_1G
> >  	default 0x80000000 if VMSPLIT_2G
> >  	default 0xC0000000
> 
> I'd prefer this actually:
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 24d65aae0491..09289d7b7f68 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1593,6 +1593,7 @@ config BL_SWITCHER_DUMMY_IF
>  
>  choice
>  	prompt "Memory split"
> +	depends on MMU
>  	default VMSPLIT_3G
>  	help
>  	  Select the desired split between kernel and user memory.
This hunk is already in my working copy, too :-)

> @@ -1610,6 +1611,7 @@ endchoice
>  
>  config PAGE_OFFSET
>  	hex
> +	default PHYS_OFFSET if !MMU
>  	default 0x40000000 if VMSPLIT_1G
>  	default 0x80000000 if VMSPLIT_2G
>  	default 0xC0000000
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 8756e4bcdba0..5ccc4a627192 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -104,10 +104,6 @@
>  #define END_MEM     		(UL(CONFIG_DRAM_BASE) + CONFIG_DRAM_SIZE)
>  #endif
>  
> -#ifndef PAGE_OFFSET
> -#define PAGE_OFFSET		PLAT_PHYS_OFFSET
> -#endif
> -
>  /*
>   * The module can be at any place in ram in nommu mode.
>   */
> 
> It's more to the point.  The first hunk hides the "Memory split" option
> which is irrelevent on !MMU.  We already know that PAGE_OFFSET should
> be the same as PHYS_OFFSET for noMMU, so let's make that explicit.
> Note that it already is by way of the bit in the last hunk - which as
> a result of this change can now be removed... especially so as we have
> nothing defining PAGE_OFFSET in arch/arm/*/include...
Looks reasonable. Maybe we can also get rid of PLAT_PHYS_OFFSET then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
