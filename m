From: stuartl@vrt.com.au (Stuart Longland)
Date: Tue, 14 Oct 2014 19:24:45 +1000
Subject: Where is DRAM initialisation done? [Resolved]
In-Reply-To: <543C620C.3050302@vrt.com.au>
References: <CAOMZO5DfsimNGHS5KB133GHQuyD2hQx6ChNcVqm_ZraLY9VhMw@mail.gmail.com>
 <543C620C.3050302@vrt.com.au>
Message-ID: <543CEBDD.4090903@vrt.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/14 09:36, Stuart Longland wrote:
> I think I see a light at the end of the tunnel and hopefully not light
> from an oncoming train. :-)

Just a heads up? I managed to get things going.

As it turns out, I could get things to run stable by clocking the RAM at
375MHz instead of the U-Boot standard of 411MHz.  I didn't find a clean
way to do it, so I tweaked mxs_mem_init_clock in
arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c with another #if:

> -#if defined(CONFIG_MX23)
> +#if defined(CONFIG_MXS_CLKCTRL_BASE)
> + const unsigned char divider = CONFIG_MXS_CLKCTRL_BASE;
> +#elif defined(CONFIG_MX23)
> /* Fractional divider for ref_emi is 33 ; 480 * 18 / 33 = 266MHz */
> const unsigned char divider = 33;
> #elif defined(CONFIG_MX28)
> /* Fractional divider for ref_emi is 21 ; 480 * 18 / 21 = 411MHz */
> const unsigned char divider = 21;
> #endif

then I could set the clock divider directly in include/configs/ts7400.h.
 The imx-bootlets code I had set that divider to 22, yielding a 392MHz
clock.  Setting it to 23 got things stable.

It may be possible to get things working properly at the normal speed
but this is beyond my skill level, so I'll leave it there.
-- 
Stuart Longland
Systems Engineer
     _ ___
\  /|_) |                           T: +61 7 3535 9619
 \/ | \ |     38b Douglas Street    F: +61 7 3535 9699
   SYSTEMS    Milton QLD 4064       http://www.vrt.com.au
