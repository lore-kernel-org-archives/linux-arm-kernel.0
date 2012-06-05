From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Jun 2012 16:55:33 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <4FC4C4FA.1070403@ti.com>
References: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com>
 <4FC4C4FA.1070403@ti.com>
Message-ID: <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Beno?t

On Tue, 29 May 2012, Cousson, Benoit wrote:

> On 5/25/2012 11:56 PM, Paul Walmsley wrote:
>
> > This patch is effectively a workaround for a hardware oversight.  A
> > better hardware approach would have been to implement a smart-idle
> > target idle mode for this IP block.  The smart-idle mode in this case
> > would behave identically to the force-idle mode. 
> 
> I'm not sure to follow you here :-)

I should rewrite that paragraph.  It is not as clear as it could be.

> force-idle is almost equivalent to smart-idle, so it is the right 
> workaround when smart-idle is not implemented.
> 
> In force-idle idleack = idlereq. Whereas in smart-idle idleack = idlereq 
> if internal /OCP activity is completed.

It would be nice if the hardware people just implemented smart-idle on 
all IP blocks.  Section 3.1.1.1.2 "Module-Level Clock Management" of The 
OMAP4430 TRM Rev. vAA states:

"Smart-idle mode is the preferred mode of operation, while forced-idle and 
no-idle modes are intended for debugging purposes."

Then no flags or software workarounds would be needed, except for 
debugging.

> So in fact, I'm wondering if a new flag is needed. We can potentially apply that if 
> idlemodes == (SIDLE_FORCE | SIDLE_NO).
> 
> We need to check which IP will have that to ensure that does not add any side-effects.

I guess that means me :-)

> BTW, please note that the current idlemodes flags are wrong for the 
> counter 32k. I've just figured out that fixing the STANDBY flags for 
> some OMAP5 IPs. I'll add that fix in my WIP OMAP4 hwmod data cleanup for 
> 3.6.
> 
> Something like that:

Okay will queue up a fix for 3.5-rc.

> >   			.context_offs = OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
> >   		},
> >   	},
> > +	.flags		= HWMOD_ALWAYS_FORCE_SIDLE,
> 
> I'm confused by the location and the value, both linus/master and 
> lo/master branches does already have a flag for the counter_32k:
> 
> /* counter_32k */
> static struct omap_hwmod omap44xx_counter_32k_hwmod = {
>         .name           = "counter_32k",
>         .class          = &omap44xx_counter_hwmod_class,
>         .clkdm_name     = "l4_wkup_clkdm",
>         .flags          = HWMOD_SWSUP_SIDLE,
>         .main_clk       = "sys_32k_ck",
>         .prcm = {
>                 .omap4 = {
>                         .clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
>                         .context_offs = OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
>                 },
>         },
> };
> 
> So the patch should be slightly different, I guess ?
> 
>  	.class          = &omap44xx_counter_hwmod_class,
>  	.clkdm_name     = "l4_wkup_clkdm",
> -	.flags          = HWMOD_SWSUP_SIDLE,
> +	.flags		= HWMOD_ALWAYS_FORCE_SIDLE,
>  	.main_clk       = "sys_32k_ck",
>  	.prcm = {
> 
> 
> This is the same issue for OMAP3 data.
> 
> What base branch are you using?

The wrong one, evidently.  Will ensure this is fixed.


- Paul
