From: mbohan@codeaurora.org (Michael Bohan)
Date: Tue, 04 Oct 2011 12:51:03 -0700
Subject: [PATCH] ARM: mm: Align bank start to MAX_ORDER_NR_PAGES
In-Reply-To: <1317198748-17705-1-git-send-email-johan.palsson@stericsson.com>
References: <1317198748-17705-1-git-send-email-johan.palsson@stericsson.com>
Message-ID: <4E8B63A7.3030607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/28/2011 1:32 AM, Johan Palsson wrote:
> The VM subsystem assumes that there are valid memmap entries from
> the bank start aligned to MAX_ORDER_NR_PAGES.
>
> Cc: stable at kernel.org
> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
> Cc: Michael Bohan<mbohan@codeaurora.org>
> Cc: Nicolas Pitre<nico@fluxnic.net>
> Signed-off-by: Johan Palsson<johan.palsson@stericsson.com>
> Signed-off-by: Rabin Vincent<rabin.vincent@stericsson.com>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
>   arch/arm/mm/init.c |    7 +++++++
>   1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index cc7e2d8..f8037ba 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -496,6 +496,13 @@ static void __init free_unused_memmap(struct meminfo *mi)
>   		 */
>   		bank_start = min(bank_start,
>   				 ALIGN(prev_bank_end, PAGES_PER_SECTION));
> +#else
> +		/*
> +		 * Align down here since the VM subsystem insists that the

Can we change this to say 'Round down here' instead of 'Align down 
here'? For consistency, we should probably change the comment and code 
for the prev_bank_end case below to say 'Round up' and use round_up 
instead of ALIGN().

> +		 * memmap entries are valid from the bank start aligned to
> +		 * MAX_ORDER_NR_PAGES.
> +		 */
> +		bank_start = round_down(bank_start, MAX_ORDER_NR_PAGES);
>   #endif

We ran into this bug on 2.6.38 and I had similar fix. Are you sure this 
doesn't apply SPARSEMEM configurations? At first glance, it seems like 
there could be an issue there as well.

Thanks,
Mike

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
