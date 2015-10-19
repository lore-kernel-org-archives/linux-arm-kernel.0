From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Oct 2015 13:43:13 +0100
Subject: [PATCH 2/2] arm64: Use gfpflags_allow_blocking()
In-Reply-To: <20151016135900.bc1e10115a866a301dbb0cd8@linux-foundation.org>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
 <adf855c7692b1512ab7216579468ad1eef2f25a8.1445008695.git.robin.murphy@arm.com>
 <20151016135900.bc1e10115a866a301dbb0cd8@linux-foundation.org>
Message-ID: <5624E561.6010107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 16/10/15 21:59, Andrew Morton wrote:
> On Fri, 16 Oct 2015 16:33:42 +0100 Robin Murphy <robin.murphy@arm.com> wrote:
>
>> __GFP_WAIT is going away to live its life under a new identity; convert
>> __iommu_alloc_attrs() to the new helper function instead.
>>
>> ...
>>
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -566,7 +566,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>>   	 */
>>   	gfp |= __GFP_ZERO;
>>
>> -	if (gfp & __GFP_WAIT) {
>> +	if (gfpflags_allow_blocking(gfp)) {
>>   		struct page **pages;
>>   		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
>
> Seems unnecessarily elaborate.  What's wrong with
>
> --- a/arch/arm64/mm/dma-mapping.c~mm-page_alloc-rename-__gfp_wait-to-__gfp_reclaim-arm-fix
> +++ a/arch/arm64/mm/dma-mapping.c
> @@ -562,7 +562,7 @@ static void *__iommu_alloc_attrs(struct
>   	 */
>   	gfp |= __GFP_ZERO;
>
> -	if (gfp & __GFP_WAIT) {
> +	if (gfp & __GFP_RECLAIM) {
>   		struct page **pages;
>   		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
>
>
> ?

Well, in that case the charge of "unnecessarily elaborate" should have 
been directed at the original patch, and the 53 other locations where 
(flags & __GFP_WAIT) was changed as per the commit message:

   "Callers that are checking if they are non-blocking should use the
    helper gfpflags_allow_blocking() where possible."

More importantly, it's also now apparently inconsistent with all the 
other dma_alloc_coherent() implementations, which thanks to the helper 
function are testing against __GFP_DIRECT_RECLAIM instead. As I have no 
clear understanding of what the difference between the two flags is, and 
how they relate to whether it's safe to call map_vm_area() or not (which 
is what principally matters here), I'm very uncomfortable with a change 
introducing that inconsistency.

If instead of my two patches you'd prefer to carry a fix through -mm and 
coordinate with Joerg and Linus to ensure everything gets merged in the 
right order, that's fine by me, but either way the change needs to 
guarantee the same behaviour as all the other instances in arch/arm and 
arch/arm64 which return a remapped buffer (and I have to say personally 
I much prefer having the rather inscrutable flag logic hidden behind a 
clearly-named helper function).

Thanks,
Robin.
