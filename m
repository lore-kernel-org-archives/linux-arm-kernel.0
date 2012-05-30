From: kosaki.motohiro@gmail.com (KOSAKI Motohiro)
Date: Wed, 30 May 2012 03:22:53 -0400
Subject: [PATCHv2 4/4] ARM: dma-mapping: remove custom consistent dma
 region
In-Reply-To: <019401cd3e34$0c6af4d0$2540de70$%szyprowski@samsung.com>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
 <1337252085-22039-5-git-send-email-m.szyprowski@samsung.com>
 <4FC5659D.6040805@gmail.com>
 <019401cd3e34$0c6af4d0$2540de70$%szyprowski@samsung.com>
Message-ID: <4FC5CACD.6000105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(5/30/12 3:15 AM), Marek Szyprowski wrote:
> Hello,
>
> On Wednesday, May 30, 2012 2:11 AM KOSAKI Motohiro wrote:
>
>>>    static void *
>>>    __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
>>>    	const void *caller)
>>>    {
>>> -	struct arm_vmregion *c;
>>> -	size_t align;
>>> -	int bit;
>>> +	struct vm_struct *area;
>>> +	unsigned long addr;
>>>
>>> -	if (!consistent_pte) {
>>> -		printk(KERN_ERR "%s: not initialised\n", __func__);
>>> +	area = get_vm_area_caller(size, VM_DMA | VM_USERMAP, caller);
>>
>> In this patch, VM_DMA is only used here. So, is this no effect?
>
> I introduced it mainly to let user know which areas have been allocated by the dma-mapping api.

vma->flags are limited resource, it has only 32 (or 64) bits. Please don't use it for such unimportant
thing.


> I also plan to add a check suggested by Minchan Kim in __dma_free_remap() if the vmalloc area
> have been in fact allocated with VM_DMA set.
