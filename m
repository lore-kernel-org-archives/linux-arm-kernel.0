From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Feb 2011 15:09:53 -0800
Subject: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
In-Reply-To: <4D62ECCC.3040208@ti.com>
References: <20110217173711.GF14574@legolas.emea.dhcp.ti.com>
	<4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com>
	<4D5E7DFF.7020609@ti.com>
	<20110218154135.GF11151@legolas.emea.dhcp.ti.com>
	<4D5EA36A.4000903@ti.com> <20110221182213.GD15225@atomide.com>
	<4D62DAF0.9050301@ti.com> <20110221220815.GG15225@atomide.com>
	<4D62ECCC.3040208@ti.com>
Message-ID: <20110221230953.GH15225@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [110221 14:51]:
> On 2/21/2011 11:08 PM, Tony Lindgren wrote:
> >
> >Thanks, I'll apply it to omap-for-linus. The omap4 hang seems to be
> >caused by the timer patch, the following fixes it. How do you want
> >to deal with fixing this issue?
> 
> I guess it is due to the early_init change?

Yes that seems to be the case.
 
> I have some concern bypassing hwmod to handle system timer. The
> idea, before the introduction of the early_init, was to use hwmod
> for early initialization as well including timers. It will become a
> little bit harder now :-(

If we get rid of the system timer dependency to hwmod we can
pretty much initialize everything later on and don't need to
use early_init stuff at all.
 
> I still didn't fully understand the rational behind that early_init
> for timer BTW.

I'm currently thinking that we should just have omap[234]_init_timer
functions that do not depend on hwmod at all.
 
> Meanwhile, the following will just prevent the fmwk to reset and
> idle the timer during hwmod_init.

That seems like a good to fix for now until the hwmod timer
changes are sorted out.

Tony

> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3989,6 +3989,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer1_slaves[] = {
>  static struct omap_hwmod omap44xx_timer1_hwmod = {
>  	.name		= "timer1",
>  	.class		= &omap44xx_timer_1ms_hwmod_class,
> +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
>  	.mpu_irqs	= omap44xx_timer1_irqs,
>  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
>  	.main_clk	= "timer1_fck",
> 
