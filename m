From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 29 May 2012 14:45:46 +0200
Subject: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com>
References: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com>
Message-ID: <4FC4C4FA.1070403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 5/25/2012 11:56 PM, Paul Walmsley wrote:
> 
> Kevin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
> ("ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod
> database") broke CORE idle on OMAP3.  This blocks device low power
> states.
> 
> The root cause is that the 32K sync timer IP block does not support
> smart-idle mode[1], and so the hwmod code keeps the IP block in
> no-idle mode while it is active.  This in turn prevents the WKUP
> clockdomain from transitioning to idle.  There is a hardcoded sleep
> dependency that prevents the CORE_L3 and CORE_CM clockdomains from
> transitioning to idle when the WKUP clockdomain is active[2], so the
> chip cannot enter any device low power states.

On OMAP4, that hard coded dependency does not exist anymore from WKUP to CORE.
That being said, if the WKUP cannot go to INACTIVE, the chip cannot go to OFF anyway :-(

> It turns out that there is no need to take the 32k sync timer out of
> idle.  The IP block itself probably does not have any native idle
> handling at all, due to its simplicity.  

The OMAP4 PRCM spec indeed list a couple of modules (counter_32k, timer12 and wdt1) that are always under HW auto modulemode. The modulemode is read only in this case.
The modules are thus following the clock domain transitions.

> Furthermore, the PRCM will
> never request target idle for this IP block while the kernel is
> running, due to the sleep dependency that prevents the WKUP
> clockdomain from idling while the CORE_L3 clockdomain is active.  So
> we can safely leave the 32k sync timer in target-no-idle mode, even
> while we continue to access it.
> 
> This workaround is implemented by defining a new hwmod flag,
> HWMOD_ALWAYS_FORCE_SIDLE, that places the IP block into target
> force-idle mode even when enabled.  The 32k sync timer hwmods are
> marked with this flag for OMAP3 and OMAP4 SoCs.  (On OMAP2xxx, no OCP
> header existed on the 32k sync timer.)


> Another theoretically clean fix for this problem would be to implement
> PM runtime-based control for 32k sync timer accesses.  These PM
> runtime calls would need to located in a custom clocksource, since the
> 32k sync timer is currently used as an MMIO clocksource.  But in
> practice, there would be little benefit to doing so; and there would
> be some cost, due to the addition of unnecessary lines of code and the
> additional CPU overhead of the PM runtime and hwmod code - unnecessary
> in this case.
> 
> Another possible fix would have been to modify the pm34xx.c code to
> force the IP block idle before entering WFI.  But this would not have
> been an acceptable approach: we are trying to remove this type of
> centralized IP block idle control from the PM code.
> 
> This patch is effectively a workaround for a hardware oversight.  A
> better hardware approach would have been to implement a smart-idle
> target idle mode for this IP block.  The smart-idle mode in this case
> would behave identically to the force-idle mode. 

I'm not sure to follow you here :-)

force-idle is almost equivalent to smart-idle, so it is the right workaround when smart-idle is not implemented.

In force-idle idleack = idlereq. Whereas in smart-idle idleack = idlereq if internal /OCP activity is completed.

So in fact, I'm wondering if a new flag is needed. We can potentially apply that if 
idlemodes == (SIDLE_FORCE | SIDLE_NO).

We need to check which IP will have that to ensure that does not add any side-effects.

On OMAP4, since timer12 and wdt1 are secured IPs not usable on GP, counter_32k seems to be the only one that does support only these two modes.

BTW, please note that the current idlemodes flags are wrong for the counter 32k. I've just figured out that fixing the STANDBY flags for some OMAP5 IPs.
I'll add that fix in my WIP OMAP4 hwmod data cleanup for 3.6.

Something like that:

--- a/outputs/omap4430/2.0/omap_hwmod_44xx_data.c
+++ b/outputs/omap4430/2.0/omap_hwmod_44xx_data.c
@@ -412,8 +412,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_counter_sysc = {
        .rev_offs       = 0x0000,
        .sysc_offs      = 0x0004,
        .sysc_flags     = SYSC_HAS_SIDLEMODE,
-       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-                          SIDLE_SMART_WKUP),
+       .idlemodes      = (SIDLE_FORCE | SIDLE_NO),
        .sysc_fields    = &omap_hwmod_sysc_type1,
 };

> We consider the
> force-idle and no-idle target idle mode settings to be intended for
> debugging and automatic idle management bug workarounds only.
> 
> This patch is a collaboration between Kevin Hilman<khilman@ti.com>
> and Paul Walmsley<paul@pwsan.com>.
> 
> References:
> 
> 1. Table 16-96 "REG_32KSYNCNT_SYSCONFIG" of the OMAP34xx TRM Rev. ZU
>     (SWPU223U), available from:
>     http://www.ti.com/pdfs/wtbu/OMAP34x_ES3.1.x_PUBLIC_TRM_vzU.zip
> 
> 2. Table 4-72 "Sleep Dependencies" of the OMAP34xx TRM Rev. ZU
>     (SWPU223U)
> 
> 3. ibid.
> 
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Vaibhav Hiremath<hvaibhav@ti.com>
> Cc: Beno?t Cousson<b-cousson@ti.com>
> Tested-by: Kevin Hilman<khilman@ti.com>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c             |   17 +++++++++++------
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 +
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    1 +
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 +++++++++
>   4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index bf86f7e..096474c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1124,10 +1124,12 @@ static struct omap_hwmod_addr_space * __init _find_mpu_rt_addr_space(struct omap
>    * _enable_sysc - try to bring a module out of idle via OCP_SYSCONFIG
>    * @oh: struct omap_hwmod *
>    *
> - * If module is marked as SWSUP_SIDLE, force the module out of slave
> - * idle; otherwise, configure it for smart-idle.  If module is marked
> - * as SWSUP_MSUSPEND, force the module out of master standby;
> - * otherwise, configure it for smart-standby.  No return value.
> + * Ensure that the OCP_SYSCONFIG register for the IP block represented
> + * by @oh is set to indicate to the PRCM that the IP block is active.
> + * Usually this means placing the module into smart-idle mode and
> + * smart-standby, but if there is a bug in the automatic idle handling
> + * for the IP block, it may need to be placed into the force-idle or
> + * no-idle variants of these modes.  No return value.
>    */
>   static void _enable_sysc(struct omap_hwmod *oh)
>   {
> @@ -1141,8 +1143,11 @@ static void _enable_sysc(struct omap_hwmod *oh)
>   	sf = oh->class->sysc->sysc_flags;
> 
>   	if (sf&  SYSC_HAS_SIDLEMODE) {
> -		idlemode = (oh->flags&  HWMOD_SWSUP_SIDLE) ?
> -			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> +		if (oh->flags&  HWMOD_ALWAYS_FORCE_SIDLE)
> +			idlemode = HWMOD_IDLEMODE_FORCE;
> +		else
> +			idlemode = (oh->flags&  HWMOD_SWSUP_SIDLE) ?
> +				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>   		_set_slave_idlemode(oh, idlemode,&v);
>   	}
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index fd48797..fddf63e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -2029,6 +2029,7 @@ static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
>   			.idlest_idle_bit = OMAP3430_ST_32KSYNC_SHIFT,
>   		},
>   	},
> +	.flags		= HWMOD_ALWAYS_FORCE_SIDLE,
>   };
> 
>   /*
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 950454a..900b4f0 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -416,6 +416,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
>   			.context_offs = OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
>   		},
>   	},
> +	.flags		= HWMOD_ALWAYS_FORCE_SIDLE,

I'm confused by the location and the value, both linus/master and lo/master branches does already have a flag for the counter_32k:

/* counter_32k */
static struct omap_hwmod omap44xx_counter_32k_hwmod = {
        .name           = "counter_32k",
        .class          = &omap44xx_counter_hwmod_class,
        .clkdm_name     = "l4_wkup_clkdm",
        .flags          = HWMOD_SWSUP_SIDLE,
        .main_clk       = "sys_32k_ck",
        .prcm = {
                .omap4 = {
                        .clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
                        .context_offs = OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
                },
        },
};

So the patch should be slightly different, I guess ?

 	.class          = &omap44xx_counter_hwmod_class,
 	.clkdm_name     = "l4_wkup_clkdm",
-	.flags          = HWMOD_SWSUP_SIDLE,
+	.flags		= HWMOD_ALWAYS_FORCE_SIDLE,
 	.main_clk       = "sys_32k_ck",
 	.prcm = {


This is the same issue for OMAP3 data.

What base branch are you using?

Regards,
Benoit
