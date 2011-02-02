From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Feb 2011 17:10:07 -0800
Subject: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
	boot failure)
In-Reply-To: <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
	<20110106180030.GA8249@n2100.arm.linux.org.uk>
	<20110106182023.GV7771@atomide.com>
	<20110106203238.GH1198@n2100.arm.linux.org.uk>
	<20110106204053.GA7771@atomide.com>
	<20110107161230.GR1198@n2100.arm.linux.org.uk>
	<20110110185209.GC4957@atomide.com>
	<20110111231611.GX4957@atomide.com>
	<3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
Message-ID: <20110202011006.GP3358@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Anand Gadiyar <gadiyar@ti.com> [110201 04:54]:
> 
> I believe this fix is fixing your reboot issue, but it's breaking
> EHCI support on the SDP.
> 
> The MODE4 above should really be MODE3 - all GPIOs are on MODE3.
> By changing
> 
> The patch snippet below fixes EHCI on the SDP, but I believe that
> making this change will reintroduce the "board reboots" issue
> you originally reported. Could you check and tell me if this
> is the case?

Hmm sorry looks like I made a typo there. That should be fixed.
 
> Just curious - is your board a Blaze, or an SDP?

It's a ES1.0 blaze, with the patch below it reboots early
during the boot. I also have to disable omap_l2_cache_init
on this board to get it to boot.
 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> b/arch/arm/mach-omap2/board-4430sdp.c
> index 07d1b20..ab9fb4d 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -554,7 +554,7 @@ static void __init omap_sfh7741prox_init(void)
> 
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
> -	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT),
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #else

Maybe there should be a check for ES1.0 for the USB also?

Tony
