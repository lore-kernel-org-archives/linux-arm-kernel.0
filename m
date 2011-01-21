From: lbassel@codeaurora.org (Larry Bassel)
Date: Fri, 21 Jan 2011 15:02:01 -0800
Subject: [PATCH] ARM: mm: enforce pageblock alignment when freeing
	memmap entries at init
In-Reply-To: <1295567231-2384-1-git-send-email-dima@android.com>
References: <1295567231-2384-1-git-send-email-dima@android.com>
Message-ID: <20110121230201.GA13669@labbmf-linux.quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 Jan 11 15:47, Dima Zavin wrote:
> On some machines, the nodes do not always start on pageblock
> boundaries. In these cases it is possible for free_unused_memmap
> to free mappings for pages inside a pageblock with otherwise
> valid pages. This presents problems for page migration since it
> operates on whole pageblocks at a time.
> 
> Round down bank_start to pageblock boundary so that whole
> pageblocks always have valid mappings.
> 
> Signed-off-by: Dima Zavin <dima@android.com>
> ---
>  arch/arm/mm/init.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 5164069..98de5d8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -418,7 +418,11 @@ static void __init free_unused_memmap(struct meminfo *mi)
>  	for_each_bank(i, mi) {
>  		struct membank *bank = &mi->bank[i];
>  
> -		bank_start = bank_pfn_start(bank);
> +		/* Round bank_start down to the start of a pageblock so that
> +		 * all pages in a pageblock always have a mapping.
> +		 */
> +		bank_start = round_down(bank_pfn_start(bank),
> +					MAX_ORDER_NR_PAGES);
>  
>  		/*
>  		 * If we had a previous bank, and there is a space
> -- 
> 1.7.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I tested this (booted, ran various commands for about 10 minutes)
on a MSM8x50 with the standard memory map and on a MSM8x50 given
a synthetic memory map which would be affected by this patch.

Tested-by: Larry Bassel <lbassel@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
