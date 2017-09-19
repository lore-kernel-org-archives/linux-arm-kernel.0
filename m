From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 19 Sep 2017 11:07:05 +0100
Subject: [PATCH v2 3/4] iommu/iova: Extend rbtree node caching
In-Reply-To: <59C0E694.6080508@huawei.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
 <b5b7e5541e47cba1112ef5bfb036d8ad44df8893.1500636791.git.robin.murphy@arm.com>
 <23972edc-e59e-3a43-59a9-d776e64af4d7@codeaurora.org>
 <e5d4524e-bfe9-acf1-66c1-ea1d9d319855@arm.com> <59C0E694.6080508@huawei.com>
Message-ID: <d9945e6a-b605-a531-cefb-6ba13bd45f1f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/17 10:42, Leizhen (ThunderTown) wrote:
[...]
>>>>     static void
>>>>   __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova
>>>> *free)
>>>>   {
>>>>       struct iova *cached_iova;
>>>> -    struct rb_node *curr;
>>>> +    struct rb_node **curr = NULL;
>>>>   -    if (!iovad->cached32_node)
>>>> -        return;
>>>> -    curr = iovad->cached32_node;
>>>> -    cached_iova = rb_entry(curr, struct iova, node);
> 
> -----------------------------
>>>> +    if (free->pfn_hi < iovad->dma_32bit_pfn)
>>>> +        curr = &iovad->cached32_node;
>>>> +    if (!curr)
>>>> +        curr = &iovad->cached_node;
>>
>> +	if (!*curr)
>> +		return;
> Is it necessary for us to try the following adjustment?
> +	if (free->pfn_hi < iovad->dma_32bit_pfn)
> +		curr = &iovad->cached32_node;
> +	else
> +		curr = &iovad->cached_node;
> +
> +	if (!*curr) {
> +		*curr = rb_next(&free->node);
> +		return;
> +	}

Yeah, I spotted that this looked a bit wonky after I posted it. It's
already cleaned up in v3, which I'll be posting shortly after I write up
some cover letters.

Thanks,
Robin.
