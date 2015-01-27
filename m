From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 27 Jan 2015 13:24:29 +0300
Subject: [PATCH v3 03/13] pm: at91: Workaround DDRSDRC self-refresh bug
 with LPDDR1 memories.
In-Reply-To: <1422338006-3371-1-git-send-email-wenyou.yang@atmel.com>
References: <1422337810-3257-1-git-send-email-wenyou.yang@atmel.com>
 <1422338006-3371-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <54C7675D.8000204@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/27/2015 8:53 AM, Wenyou Yang wrote:

> From: Peter Rosin <peda@axentia.se>

> The DDRSDR controller fails miserably to put LPDDR1 memories in
> self-refresh. Force the controller to think it has DDR2 memories
> during the self-refresh period, as the DDR2 self-refresh spec is
> equivalent to LPDDR1, and is correctly implemented in the
> controller.

> Assume that the second controller has the same fault, but that is
> untested.

> Signed-off-by: Peter Rosin <peda@axentia.se>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/mach-at91/pm_slowclock.S  |   43 +++++++++++++++++++++++++++++++-----
>   include/soc/at91/at91sam9_ddrsdr.h |    2 +-
>   2 files changed, 39 insertions(+), 6 deletions(-)

> diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
> index e2bfaf5..1155217 100644
> --- a/arch/arm/mach-at91/pm_slowclock.S
> +++ b/arch/arm/mach-at91/pm_slowclock.S
[...]
> @@ -108,14 +118,26 @@ ddr_sr_enable:
>
>   	/* figure out if we use the second ram controller */
>   	cmp	ramc1, #0
> -	ldrne	tmp2, [ramc1, #AT91_DDRSDRC_LPR]
> -	strne	tmp2, .saved_sam9_lpr1
> -	bicne	tmp2, #AT91_DDRSDRC_LPCB
> -	orrne	tmp2, #AT91_DDRSDRC_LPCB_SELF_REFRESH
> +	beq	ddr_no_2nd_ctrl
> +
> +	ldr	tmp2, [ramc1, #AT91_DDRSDRC_MDR]
> +	str	tmp2, .saved_sam9_mdr1
> +	bic	tmp2, tmp2, #~AT91_DDRSDRC_MD
> +	cmp	tmp2, #AT91_DDRSDRC_MD_LOW_POWER_DDR
> +	ldreq	tmp2, [ramc1, #AT91_DDRSDRC_MDR]
> +	biceq	tmp2, tmp2, #AT91_DDRSDRC_MD

    Didn't you forget ~? Either that, or ~ above is not needed, I think.

> +	orreq	tmp2, tmp2, #AT91_DDRSDRC_MD_DDR2
> +	streq	tmp2, [ramc1, #AT91_DDRSDRC_MDR]
> +
> +	ldr	tmp2, [ramc1, #AT91_DDRSDRC_LPR]
> +	str	tmp2, .saved_sam9_lpr1
> +	bic	tmp2, #AT91_DDRSDRC_LPCB

    Didn't you forget ~? And isn't it 3-operand instruction (as seen in the 
above code)?

> +	orr	tmp2, #AT91_DDRSDRC_LPCB_SELF_REFRESH

    Only 2 operands?

[...]

WBR, Sergei
