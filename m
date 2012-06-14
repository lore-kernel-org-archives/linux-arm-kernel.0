From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 14 Jun 2012 18:47:38 +0200
Subject: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <20120611004555.20034.87035.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004555.20034.87035.stgit@dusk>
Message-ID: <4FDA15AA.6090704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 6/11/2012 2:45 AM, Paul Walmsley wrote:
> Kuvin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c

I guess you meant Kevin?

> ("ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod
> database") broke CORE idle on OMAP3.  This prevents device low power
> states.
>
> The root cause is that the 32K sync timer IP block does not support
> smart-idle mode[1], and so the hwmod code keeps the IP block in
> no-idle mode while it is active.  This in turn prevents the WKUP
> clockdomain from transitioning to idle.  There is a hardcoded sleep
> dependency that prevents the CORE_L3 and CORE_CM clockdomains from
> transitioning to idle when the WKUP clockdomain is active[2], so the
> chip cannot enter any device low power states.
>
> It turns out that there is no need to take the 32k sync timer out of
> idle.
> The IP block itself pbobably does not have any native idle

typo

> handling at all, due to its simplicity.

I don't think this description is really accurate, due to the usual 
confusing definition of IDLE for the PRCM standpoint :-)
The counter_32k will follow PRCM requirement toward SIdleReq/SIdleAck.
It has to be "idle" for PRCM standpoint to allow the transition of the 
L4_WKUP to inactive (SIdleAck=IDLE). And it will be functional as soon 
as the L4_WKUP domain is active.

The fact that the smartidle mode is missing does not change anything in 
the way the PRCM handle the protocol. It is just an issue at IP level.

In that case force-idle = smart-idle, just because this module does not 
have anything to do to delay the SIdleAck upon SIdleReq request. The IP 
is probably connecting the SIdleAck to the SIdleReq signal.
Please note that there are a bunch of IPs that are doing that even if 
they do support the smartidle mode.

> Furthermore, the PRCM will
> never request target idle for this IP block while the kernel is
> running, due to the sleep dependency that prevents the WKUP
> clockdomain from idling while the CORE_L3 clockdomain is active.  So
> we can safely leave the 32k sync timer in target-no-idle mode, even
> while we continue to access it.

Do you mean force-idle? Because accessing a module in no-idle is always 
possible.

> This workaround is implemented by defining a new hwmod flag,
> HWMOD_ALWAYS_FORCE_SIDLE, that places the IP block into target
> force-idle mode even when enabled.  The 32k sync timer hwmods are
> marked with this flag for OMAP3 and OMAP4 SoCs.  (On OMAP2xxx, no OCP
> header existed on the 32k sync timer.)

I still don't see the need for this flag. It looks to me that we are 
adding a redundant information and thus make things more complex than it 
should.

	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),

It the real root cause of the problem. There is no need to re-encode 
that using an extra flag. Especially at hwmod level where the issue is 
at sysconfig level.

I did not really get the reason why you changed your mind on that point.

As soon as there is no SIDLE_SMART mode, what choice do we have but 
using the SIDLE_FORCE?


BTW, I even think the HWMOD_SWSUP_SIDLE hwmod flag is useless now. It 
was needed before probably because the idlemodes were wrongly populated.

In fact the hwmod flags is really there to *flag* some real HW bug we 
cannot figure out otherwise, but in that case, the sysc.idlemodes 
already contains all the information we need to set the proper mode 
during enable/disable.

Duplicating the information is always a source of confusion and might 
lead to nasty bugs due to the increase of complexity.

> Another theoretically clean fix for this problem would be to implement
> PM runtime-based control for 32k sync timer accesses.  These PM
> runtime calls would need to located in a custom clocksource, since the
> 32k sync timer is currently used as an MMIO clocksource.  But in
> practice, there would be little benefit to doing so; and there would
> be some cost, due to the addition of unnecessary lines of code and the
> additional CPU overhead of the PM runtime and hwmod code - unnecessary
> in this case.

I don't think that part is really relevant anymore.

> Another possible fix would have been to modify the pm34xx.c code to
> force the IP block idle before entering WFI.  But this would not have
> been an acceptable approach: we are trying to remove this type of
> centralized IP block idle control from the PM code.

Neither that one I guess. As soon as we consider force-idle to be 
equivalent to smart-idle, nothing more is needed.

> This patch is effectively a workaround for a hardware problem.  A
> better hardware approach would have been to implement a smart-idle
> target idle mode for this IP block.  The smart-idle mode in this case
> would behave identically to the force-idle mode.  We consider the
> force-idle and no-idle target idle mode settings to be intended for
> debugging and automatic idle management bug workarounds only[4].
>
> This patch is a collaboration between Kevin Hilman <khilman@ti.com>
> and Paul Walmsley <paul@pwsan.com>.
>
> Thanks to Vaibhav Hiremath <hvaibhav@ti.com> for providing comments on
> an earlier version of this patch.  Thanks to Tero Kristo
> <t-kristo@ti.com> for identifying a bug in an earlier version of this
> patch.  Thanks to Beno?t Cousson <b-cousson@ti.com> for identifying a
> bug in an earlier version of this patch and for implementation comments.
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
> 4. Section 3.1.1.1.2 "Module-Level Clock Management" of the OMAP4430
>     TRM Rev. vAA (SWPU231AA).
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c             |   17 +++++++++++------
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    2 +-
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 +++++++++
>   4 files changed, 22 insertions(+), 8 deletions(-)
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
>   	if (sf & SYSC_HAS_SIDLEMODE) {
> -		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> -			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> +		if (oh->flags & HWMOD_ALWAYS_FORCE_SIDLE)
> +			idlemode = HWMOD_IDLEMODE_FORCE;
> +		else
> +			idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> +				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>   		_set_slave_idlemode(oh, idlemode, &v);
>   	}
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index b26d3c9..f8ac9e7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -2018,7 +2018,7 @@ static struct omap_hwmod omap3xxx_counter_32k_hwmod = {
>   	.name		= "counter_32k",
>   	.class		= &omap3xxx_counter_hwmod_class,
>   	.clkdm_name	= "wkup_clkdm",
> -	.flags		= HWMOD_SWSUP_SIDLE,
> +	.flags		= HWMOD_ALWAYS_FORCE_SIDLE | HWMOD_SWSUP_SIDLE,

I guess we might be able to get rid of both in theory.

Regards,
Benoit
