From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jan 2015 11:28:00 +0000
Subject: [PATCH v4 05/13] pm: at91: move the copying the sram function to
 the sram initializationi phase
In-Reply-To: <1422409396-24394-1-git-send-email-wenyou.yang@atmel.com>
References: <1422409172-24178-1-git-send-email-wenyou.yang@atmel.com>
 <1422409396-24394-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150129112800.GV26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 09:43:16AM +0800, Wenyou Yang wrote:
> -#ifdef CONFIG_AT91_SLOW_CLOCK
> -				/* copy slow_clock handler to SRAM, and call it */
> -				memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
> -#endif
>  				slow_clock(at91_pmc_base, at91_ramc_base[0],
>  					   at91_ramc_base[1],
>  					   at91_pm_data.memctrl);
> @@ -272,6 +268,9 @@ static void __init at91_pm_sram_init(void)
>  	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
>  	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
>  
> +	/* Copy the slow_clock handler to SRAM */
> +	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
> +

Why is this code not using the fncpy() support for copying functions.
Why is it not checking the return code from __arm_ioremap_exec() or
gen_pool_virt_to_phys() for failure?

This looks like quite a massive review failure when this code was
originally merged.  It needs fixing.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
