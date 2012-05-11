From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 11 May 2012 10:48:21 +0200
Subject: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
In-Reply-To: <20120510172918.13418.64781.stgit@dusk>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172918.13418.64781.stgit@dusk>
Message-ID: <4FACD255.3080702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 5/10/2012 7:29 PM, Paul Walmsley wrote:
> During kernel init, the AM3505/AM3517 UART4 cannot complete its softreset:
>
> omap_hwmod: uart4: softreset failed (waited 10000 usec)
>
> This also results in another warning later in the boot process:
>
> omap_hwmod: uart4: enabled state can only be entered from initialized, idle, or disabled state
>
>> From empirical observation, the AM35xx UART4 IP block requires either
> uart1_fck or uart2_fck to be enabled while UART4 resets.  Otherwise
> the reset will never complete.  So this patch adds uart1_fck as an
> optional clock for UART4 and adds the appropriate hwmod flag to cause
> uart1_fck to be enabled during the reset process.  (The choice of
> uart1_fck over uart2_fck was arbitrary.)
>
> Unfortunately this observation raises many questions.  Is it necessary
> for uart1_fck or uart2_fck to be controlled with uart4_fck for the
> UART4 to work correctly?  What exactly do the AM35xx UART4 clock
> tree and the related PRCM idle management FSMs look like?  If anyone
> has the ability to answer these questions through empirical functional
> testing, or hardware information from the AM35xx designers, it would
> be greatly appreciated.

I do not have any clue about that chip, but is this clock really what it 
is supposed to be? I mean, isn't the uart1_fck the parent of all the 
UART fck or something like that. Don't we just have an issue becasue the 
clock names are not accurate?

Regards,
Benoit

>
> Cc: Beno?t Cousson<b-cousson@ti.com>
> Cc: Kyle Manna<kyle.manna@fuel7.com>
> Cc: Mark A. Greer<mgreer@animalcreek.com>
> Cc: Ranjith Lohithakshan<ranjithl@ti.com>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/clock3xxx_data.c       |    8 ++++++--
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   17 +++++++++++++++++
>   2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index 11644bf..12c64db 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3201,8 +3201,12 @@ static struct clk vpfe_fck = {
>   };
>
>   /*
> - * The UART1/2 functional clock acts as the functional
> - * clock for UART4. No separate fclk control available.
> + * The UART1/2 functional clock acts as the functional clock for
> + * UART4. No separate fclk control available.  XXX Well now we have a
> + * uart4_fck that is apparently used as the UART4 functional clock,
> + * but it also seems that uart1_fck or uart2_fck are still needed, at
> + * least for UART4 softresets to complete.  This really needs
> + * clarification.
>    */
>   static struct clk uart4_ick_am35xx = {
>   	.name		= "uart4_ick",
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index c939131..c6653a80 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -535,6 +535,20 @@ static struct omap_hwmod_dma_info am35xx_uart4_sdma_reqs[] = {
>   	{ .dma_req = -1 }
>   };
>
> +/*
> + * XXX AM35xx UART4 cannot complete its softreset without uart1_fck or
> + * uart2_fck being enabled.  So we add uart1_fck as an optional clock,
> + * below, and set the HWMOD_CONTROL_OPT_CLKS_IN_RESET.  This really
> + * should not be needed.  The functional clock structure of the AM35xx
> + * UART4 is extremely unclear and opaque; it is unclear what the role
> + * of uart1/2_fck is for the UART4.  Any clarification from either
> + * empirical testing or the AM3505/3517 hardware designers would be
> + * most welcome.
> + */
> +static struct omap_hwmod_opt_clk am35xx_uart4_opt_clks[] = {
> +	{ .role = "softreset_uart1_fck", .clk = "uart1_fck" },
> +};
> +
>   static struct omap_hwmod am35xx_uart4_hwmod = {
>   	.name		= "uart4",
>   	.mpu_irqs	= am35xx_uart4_mpu_irqs,
> @@ -549,6 +563,9 @@ static struct omap_hwmod am35xx_uart4_hwmod = {
>   			.idlest_idle_bit = AM35XX_ST_UART4_SHIFT,
>   		},
>   	},
> +	.opt_clks	= am35xx_uart4_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(am35xx_uart4_opt_clks),
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.class		=&omap2_uart_class,
>   };
>
>
>
