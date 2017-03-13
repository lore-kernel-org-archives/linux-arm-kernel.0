From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 13 Mar 2017 22:07:42 +0100
Subject: [PATCH] ARM: at91: pm: cpu_idle: switch DDR to power-down mode
In-Reply-To: <20170313171450.18681-1-nicolas.ferre@microchip.com>
References: <20170313171450.18681-1-nicolas.ferre@microchip.com>
Message-ID: <20170313210742.r7jdbuyp72ma76vl@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/2017 at 18:14:50 +0100, Nicolas Ferre wrote:
> On some DDR controllers, compatible with the sama5d3 one,
> the sequence to enter/exit/re-enter the self-refresh mode adds
> more constrains than what is currently written in the at91_idle
> driver. An actual access to the DDR chip is needed between exit
> and re-enter of this mode which is somehow difficult to implement.
> This sequence can completely hang the SoC. It is particularly
> experienced on parts which embed a L2 cache if the code run
> between IDLE calls fits in it...
> 
> Moreover, as the intention is to enter and exit pretty rapidly
> from IDLE, the power-down mode is a good candidate.
> 
> So now we use power-down instead of self-refresh. As we can
> simplify the funciton for sama5d3 compatible DDR controllers,
              typo ^

> we instanciate a new sama5d3_ddr_standby() function.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  arch/arm/mach-at91/pm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 3d89b7905bd9..63e7df8ec815 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -289,6 +289,23 @@ static void at91_ddr_standby(void)
>  		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
>  }
>  
> +static void sama5d3_ddr_standby(void)
> +{
> +	u32 lpr0;
> +	u32 saved_lpr0;
> +
> +	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> +	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
> +	lpr0 |= AT91_DDRSDRC_LPCB_POWER_DOWN;
> +
> +	/* self-refresh mode now */

So this is not self refresh anymore


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
