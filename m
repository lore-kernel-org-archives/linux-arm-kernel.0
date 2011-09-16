From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2011 10:21:14 -0700
Subject: [PATCH 01/19] ARM: sort the meminfo array earlier
In-Reply-To: <1316156850-31013-2-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-2-git-send-email-nico@fluxnic.net>
Message-ID: <4E73858A.9050106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/16/2011 12:07 AM, Nicolas Pitre wrote:
> @@ -875,6 +876,12 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
>  	return mdesc;
>  }
>  
> +static int __init meminfo_cmp(const void *_a, const void *_b)
> +{
> +	const struct membank *a = _a, *b = _b;
> +	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
> +	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;

This looks like:

    return clamp(bank_pfn_start(a) - bank_pfn_start(b), -1, 1);


> +}
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> @@ -903,6 +910,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	parse_early_param();
>  
> +	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
>  	sanity_check_meminfo();
>  	arm_memblock_init(&meminfo, mdesc);
>  
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 91bca355cd..7080f10cc2 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -318,19 +317,10 @@ static void arm_memory_present(void)
>  }
>  #endif
>  
> -static int __init meminfo_cmp(const void *_a, const void *_b)
> -{
> -	const struct membank *a = _a, *b = _b;
> -	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
> -	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
> -}
> -
>  void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
>  {
>  	int i;
>  
> -	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
> -

Why not call sanity_check_meminfo() here?

>  	memblock_init();
>  	for (i = 0; i < mi->nr_banks; i++)
>  		memblock_add(mi->bank[i].start, mi->bank[i].size);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
