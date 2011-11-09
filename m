From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2011 14:27:29 -0800
Subject: [PATCH 2/5] ARM: restart: omap: use new restart hook XXX WIP XXX
In-Reply-To: <E1RN6we-0001aR-Qs@rmk-PC.arm.linux.org.uk>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <E1RN6we-0001aR-Qs@rmk-PC.arm.linux.org.uk>
Message-ID: <20111109222728.GO31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 09:32]:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-omap1/board-voiceblue.c     |    5 ++---
>  arch/arm/mach-omap1/include/mach/system.h |    6 ++++++
>  arch/arm/mach-omap1/reset.c               |    4 +---
>  arch/arm/mach-omap2/include/mach/system.h |    6 ++++++
>  arch/arm/mach-omap2/prcm.c                |    4 +---
>  arch/arm/plat-omap/include/plat/system.h  |    2 --
>  6 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
> index 2a6545b..b0111b6 100644
> --- a/arch/arm/mach-omap1/board-voiceblue.c
> +++ b/arch/arm/mach-omap1/board-voiceblue.c
> @@ -220,7 +220,7 @@ void voiceblue_wdt_ping(void)
>  	gpio_set_value(0, wdt_gpio_state);
>  }
>  
> -static void voiceblue_reset(char mode, const char *cmd)
> +static void voiceblue_restart(char mode, const char *cmd)
>  {
>  	/*
>  	 * Workaround for 5912/1611b bug mentioned in sprz209d.pdf p. 28
> @@ -284,8 +284,6 @@ static void __init voiceblue_init(void)
>  	 * (it is connected through invertor) */
>  	omap_writeb(0x00, OMAP_LPG1_LCR);
>  	omap_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
> -
> -	arch_reset = voiceblue_reset;
>  }
>  
>  MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
> @@ -297,4 +295,5 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
>  	.init_irq	= omap1_init_irq,
>  	.init_machine	= voiceblue_init,
>  	.timer		= &omap1_timer,
> +	.restart	= voiceblue_restart,
>  MACHINE_END

I guess we want the rest of the board files to set .restart
to omap1_restart or omap_prcm_restart? Do you already have
some script doing that or do you need some help there?

Regards,

Tony
