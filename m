From: panand@redhat.com (Pratyush Anand)
Date: Fri, 19 Aug 2016 16:52:17 +0530
Subject: [PATCH v24 5/9] arm64: kdump: add kdump support
In-Reply-To: <20160819012651.GE20080@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
 <57AB586D.3080900@arm.com> <20160818071547.GC20080@linaro.org>
 <20160819012651.GE20080@linaro.org>
Message-ID: <20160819112217.GB22221@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/2016:10:26:52 AM, AKASHI Takahiro wrote:
> >From 740563e4a437f0d6ecf6e421c91433f9b8f19041 Mon Sep 17 00:00:00 2001
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Date: Fri, 19 Aug 2016 09:57:52 +0900
> Subject: [PATCH] arm64: mark reserved memblock regions explicitly
> 
> ---
>  arch/arm64/kernel/setup.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 38eda13..38589b5 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -205,10 +205,15 @@ static void __init request_standard_resources(void)
>  
>  	for_each_memblock(memory, region) {
>  		res = alloc_bootmem_low(sizeof(*res));
> -		res->name  = "System RAM";
> +		if (memblock_is_nomap(region)) {
> +			res->name  = "reserved";
> +			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +		} else {
> +			res->name  = "System RAM";
> +			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +		}
>  		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
>  		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
> -		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>  
>  		request_resource(&iomem_resource, res);


It will help kexec-tools to prevent copying  of any unnecessary data. I
think, then you also need to change phys_offset calculation in kexec-tools. That
should be start of either of first "reserved" or "System RAM" block.

~Pratyush
