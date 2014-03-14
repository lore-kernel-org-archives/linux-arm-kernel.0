From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Mar 2014 23:07:50 +0000
Subject: [PATCHv2 2/3] arm64: Support DMA_ATTR_WRITE_COMBINE
In-Reply-To: <CAL_JsqKziSNiuN8VjXSv9Lm1vjn9Tc+OLxuVs5mDr3pnaEA4Mw@mail.gmail.com>
References: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
 <1394826745-24191-2-git-send-email-lauraa@codeaurora.org>
 <CAL_JsqKziSNiuN8VjXSv9Lm1vjn9Tc+OLxuVs5mDr3pnaEA4Mw@mail.gmail.com>
Message-ID: <79FAFAEF-04F8-43EF-A0DD-8123E204D451@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 Mar 2014, at 20:24, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Mar 14, 2014 at 2:52 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> DMA_ATTR_WRITE_COMBINE is currently ignored. Set the pgprot
>> appropriately for non coherent opperations.
>> 
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>> arch/arm64/mm/dma-mapping.c | 15 +++++++++++++--
>> 1 file changed, 13 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 0cdd2f6..608c343 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -29,6 +29,17 @@
>> struct dma_map_ops *dma_ops;
>> EXPORT_SYMBOL(dma_ops);
>> 
>> +
>> +static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
>> +                                       bool coherent)
>> +{
>> +       if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
>> +               return pgprot_writecombine(prot)
> 
> Does this compile? Missing semicolon.
> 
>> +       else if (!coherent)
>> +               return pgprot_dmacoherent(prot);
>> +       return prot;
> 
> Isn't DMA_ATTR_WRITE_COMBINE supposed to be an optimization over plain
> non-cached?

Since writecombine and dmacoherent are the same, we probably shouldn?t
even bother with the check as it doesn?t have any effect.

> But coherent would be more optimal over just write
> combine, so we would want to continue to ignore DMA_ATTR_WRITE_COMBINE
> in the coherent case. Something like this:
> 
>      if (coherent)
>               return prot;
>      else if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
>               return pgprot_writecombine(prot);
>      return pgprot_dmacoherent(prot);

I?ve got request from graphics people in the past about using
writecombine even though the DMA is fully coherent. The reason is that
some (frame)buffers are more efficient to fill with non-cacheable
memory than cacheable + write allocate which affects the whole CPU
cache.

> But then this function is never used in the coherent case, so I'm
> confused by Catalin's comment. The original version seems sufficient
> to me.

I think we need mmap function for both coherent and non-coherent cases
since the default dma_mmap_coherent() just uses pgprot_noncached() which
gives us Strongly Ordered.

So my proposal:

	if (!coherent)
		return pgprot_dmacoherent(prot);
	else if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
		return pgprot_writecombine(prot);
	return prot;

I could even use dmacoherent instead of writecombine to avoid confusion.

Catalin
