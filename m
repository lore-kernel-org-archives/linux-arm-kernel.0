From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Mon, 20 Jun 2016 09:48:29 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSByZW1vdmUgcGFnZV9tYXBwaW5nIGNoZWNrIGluIF9f?=
 =?gb2312?B?c3luY19pY2FjaGVfZGNhY2hl?=
In-Reply-To: <20160620092121.GA20071@e104818-lin.cambridge.arm.com>
References: <07890E72BF5A6C44976E3EB9981B18780245260A@SZXEMA509-MBX.china.huawei.com>
 <20160620092121.GA20071@e104818-lin.cambridge.arm.com>
Message-ID: <07890E72BF5A6C44976E3EB9981B1878024526CF@SZXEMA509-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin

Thanks for your suggestion.
	
-> Minor updates required here, replacing L2cache with PoU.
->
->We also need a cc stable so that the patch is cherry-picked for earlier kernel versions (even though it may fail to apply, at least we'll be asked by the stable maintainers to provide  back-port).
  I agree it and I change it now.

-> Will is handling the 4.7 kernel release but he's away at a conference this week, so I may push this upstream if he does that time.
->
-> Anyway, could you please post the patch with the above Reviewed/cc tags to linux-arm-kernel at lists.infradead.org?
  Ok, next patch will be posted to linux-arm-kernel at lists.infradead.org.

Best regards
Shaokun zhang

-----????-----
???: Catalin Marinas [mailto:catalin.marinas at arm.com] 
????: 2016?6?20? 17:21
???: Zhangshaokun
??: mark.rutland at arm.com; Will Deacon; Linuxarm; Zhanweitao
??: Re: [PATCH] remove page_mapping check in __sync_icache_dcache

On Mon, Jun 20, 2016 at 06:14:56AM +0000, Zhangshaokun wrote:
> In aarch64 sync icache and dcache, if anonymous pages hold 
> self-modified code and these pages are migrated, it also should be 
> flushed dcache and invalided icache. Therefore,page_mapping(page) 
> check should be removed, otherwise icache maybe fetch stale 
> instruction frome L2cache.

Minor updates required here, replacing L2cache with PoU.

We also need a cc stable so that the patch is cherry-picked for earlier kernel versions (even though it may fail to apply, at least we'll be asked by the stable maintainers to provide  back-port).

> Signed-off-by:zhangshaokun <zhangshaokun@hisilicon.com>
> ---
>  arch/arm64/mm/flush.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c index 
> dbd12ea..43a76b0 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -71,10 +71,6 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)  {
>  	struct page *page = pte_page(pte);
>  
> -	/* no flushing needed for anonymous pages */
> -	if (!page_mapping(page))
> -		return;
> -
>  	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>  		sync_icache_aliases(page_address(page),
>  				    PAGE_SIZE << compound_order(page));

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Will is handling the 4.7 kernel release but he's away at a conference this week, so I may push this upstream if he does that time.

Anyway, could you please post the patch with the above Reviewed/cc tags to linux-arm-kernel at lists.infradead.org?

Thanks.

--
Catalin
