From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 26 Jan 2015 15:57:25 +0300
Subject: [PATCH v2 04/12] pm: at91: move the copying the sram function
 to the sram initializationi phase
In-Reply-To: <1422265201-23110-1-git-send-email-wenyou.yang@atmel.com>
References: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
 <1422265201-23110-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <54C639B5.7050106@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/26/2015 12:40 PM, Wenyou Yang wrote:

> To decrease the suspend time, move the copying the sram function
> to the sram initialization phase, instead of every time go to suspend.

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/mach-at91/pm.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 5dd4e41..409185e 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -161,10 +161,6 @@ static int at91_pm_enter(suspend_state_t state)
>   			 * turning off the main oscillator; reverse on wakeup.
>   			 */
>   			if (slow_clock) {
> -#ifdef CONFIG_AT91_SLOW_CLOCK
> -				/* copy slow_clock handler to SRAM, and call it */
> -				memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
> -#endif
>   				slow_clock(at91_pmc_base, at91_ramc_base[0],
>   					   at91_ramc_base[1],
>   					   at91_pm_data.memctrl);
> @@ -272,6 +268,9 @@ static void __init at91_pm_sram_init(void)
>   	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
>   	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
>
> +	/* Copy slow_clock handler to SRAM, and call it */

    You're not calling it here.

> +	memcpy(slow_clock, at91_slow_clock, at91_slow_clock_sz);
> +
>   put_node:
>   	of_node_put(node);
>   }

WBR, Sergei
