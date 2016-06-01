From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 07:36:42 +0200
Subject: [RFC v2] dma-mapping: Use unsigned long for dma_attrs
In-Reply-To: <20160531170420.GB25366@infradead.org>
References: <1464609246-6948-1-git-send-email-k.kozlowski@samsung.com>
 <1464609246-6948-2-git-send-email-k.kozlowski@samsung.com>
 <20160531170420.GB25366@infradead.org>
Message-ID: <574E746A.2030806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2016 07:04 PM, Christoph Hellwig wrote:
> On Mon, May 30, 2016 at 01:54:06PM +0200, Krzysztof Kozlowski wrote:
>> The dma-mapping core and the implementations do not change the
>> DMA attributes passed by pointer.  Thus the pointer can point to const
>> data.  However the attributes do not have to be a bitfield. Instead
>> unsigned long will do fine:
>>
>> 1. This is just simpler.  Both in terms of reading the code and setting
>>    attributes.  Instead of initializing local attributes on the stack and
>>    passing pointer to it to dma_set_attr(), just set the bits.
>>
>> 2. It brings safeness and checking for const correctness because the
>>    attributes are passed by value.
>>
>> Please have in mind that this is RFC, not finished yet.  Only ARM and
>> ARM64 are fixed (and not everywhere).
>> However other API users also have to be converted which is quite
>> intrusive.  I would rather avoid it until the overall approach is
>> accepted.
> 
> This looks great!  Please continue doing the full conversion.
> 
>> +/**
>> + * List of possible attributes associated with a DMA mapping. The semantics
>> + * of each attribute should be defined in Documentation/DMA-attributes.txt.
>> + */
>> +#define DMA_ATTR_WRITE_BARRIER		BIT(1)
>> +#define DMA_ATTR_WEAK_ORDERING		BIT(2)
>> +#define DMA_ATTR_WRITE_COMBINE		BIT(3)
>> +#define DMA_ATTR_NON_CONSISTENT		BIT(4)
>> +#define DMA_ATTR_NO_KERNEL_MAPPING	BIT(5)
>> +#define DMA_ATTR_SKIP_CPU_SYNC		BIT(6)
>> +#define DMA_ATTR_FORCE_CONTIGUOUS	BIT(7)
>> +#define DMA_ATTR_ALLOC_SINGLE_PAGES	BIT(8)
> 
> No really for this patch, but I would much prefer to document them next
> to the code in the long run.  Also I really think these BIT() macros
> are a distraction compared to the (1 << N) notation.

Not much difference to me but maybe plain number:
...	0x01u
...	0x02u
?

> 
>> +/**
>> + * dma_get_attr - check for a specific attribute
>> + * @attr: attribute to look for
>> + * @attrs: attributes to check within
>> + */
>> +static inline bool dma_get_attr(unsigned long attr, unsigned long attrs)
>> +{
>> +	return !!(attr & attrs);
>> +}
> 
> I'd just kill this helper, much easier to simply open code it in the
> caller.

Keeping it for now helps reducing the number of changes in the patch.
The patch will be quite big as it has to replace all the uses atomically.

I can get rid of the helper in consecutive patch.

Best regards,
Krzysztof
