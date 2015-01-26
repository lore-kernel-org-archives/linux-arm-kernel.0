From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 26 Jan 2015 16:05:14 +0300
Subject: [PATCH 2/7] pm: at91: pm_suspend: add the WFI support for ARMv7
In-Reply-To: <1422266761-24487-1-git-send-email-wenyou.yang@atmel.com>
References: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
 <1422266761-24487-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <54C63B8A.9000702@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/26/2015 1:06 PM, Wenyou Yang wrote:

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>   arch/arm/mach-at91/pm_suspend.S |   54 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 53 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index 122a3f1..e796722 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -53,6 +53,58 @@ mode	.req	r6
>   	beq	1b
>   	.endm
>
> +/*
> + * Put the processor to enter the WFI state
> + */
> +	.macro _do_wfi
> +
> +#if defined(CONFIG_CPU_V7)
> +	/*
> +	 * Execute an ISB instruction to flush the pipeline to ensure
> +	 * that all of operations have beem completed.

    Been.

> +	 */
> +	isb
> +
> +	/*
> +	 * Execute an ISB instruction to ensure that all of the

    ISB again, while you're executing DSB/DMB?

> +	 * CP15 register changes have been committed.
> +	 */
> +	dsb
> +	dmb
> +
> +	/* Disable the processor's clock */
> +	mov	tmp1, #AT91_PMC_PCK

    What's 'tmp1'? Is that a register name?

> +	str	tmp1, [pmc, #AT91_PMC_SCDR]
> +
> +	/* Execute a WFI instruction */

    Self-obvious comment, I'd say...

> +	wfi	@ Wait For Interrupt
> +
> +	/*
> +	 * CPU can specualatively prefetch the instructions

    Speculatively.

[...]

WBR, Sergei
