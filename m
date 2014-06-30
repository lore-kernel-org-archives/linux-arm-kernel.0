From: ritesh.list@gmail.com (Ritesh Harjani)
Date: Mon, 30 Jun 2014 15:49:26 +0530
Subject: [PATCHv3 2/3] arm: dma-mapping: Refactor attach/detach,
 alloc/free func
In-Reply-To: <20140627111601.GJ26276@arm.com>
References: <1402044161-32980-1-git-send-email-ritesh.harjani@gmail.com>
 <1402044161-32980-2-git-send-email-ritesh.harjani@gmail.com>
 <1402044161-32980-3-git-send-email-ritesh.harjani@gmail.com>
 <20140627111601.GJ26276@arm.com>
Message-ID: <CALk7dXpuVtFO4bsNCNEc+TTaqupUYtwsjJbFqB-PWBf2Bkyezg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thanks for taking time to review the code. Due to some activity going
at my place, I might take some time
to reply with patches addressing the problem you have noted down.

But please find my answers inline.


On Fri, Jun 27, 2014 at 4:46 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jun 06, 2014 at 09:42:40AM +0100, ritesh.harjani at gmail.com wrote:
>> From: Ritesh Harjani <ritesh.harjani@gmail.com>
>>
>> Refactor following function calls to lib/iommu-helper.c
>>
>> 1.
>> arm_iommu_attach/detach device function calls.
>> arm_iommu_init/release_mapping function calls.
>>
>> 2. iommu_alloc/free_buffer can be moved out from
>> arm/dma-mapping.c to lib/iommu_helper.c
>
> Moves like this are always difficult to review, so I'm just going to look at
> the additions (i.e. the new helpers).
Ok, thanks!

>
>> diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
>> index 961d8ef..09bcea3 100644
>> --- a/include/linux/iommu-helper.h
>> +++ b/include/linux/iommu-helper.h
>> @@ -2,6 +2,7 @@
>>  #define _LINUX_IOMMU_HELPER_H
>>
>>  #include <linux/kernel.h>
>> +#include <linux/dma-attrs.h>
>>
>>  #ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
>>  struct dma_iommu_mapping {
>> @@ -19,6 +20,23 @@ struct dma_iommu_mapping {
>>         struct kref             kref;
>>  };
>>
>> +extern struct page **iommu_helper_alloc_buffer(struct device *dev, size_t size,
>> +                                         gfp_t gfp, struct dma_attrs *attrs,
>> +                       void (*arch_clear_buffer_cb)(struct page*, size_t));
>> +
>> +extern int iommu_helper_free_buffer(struct device *dev, struct page **pages,
>> +                              size_t size, struct dma_attrs *attrs);
>> +
>> +extern void iommu_helper_detach_device(struct device *dev);
>> +
>> +extern void iommu_helper_release_mapping(struct dma_iommu_mapping *mapping);
>> +
>> +extern int iommu_helper_attach_device(struct device *dev,
>> +                           struct dma_iommu_mapping *mapping);
>> +
>> +extern struct dma_iommu_mapping *
>> +iommu_helper_init_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
>> +
>>  #define to_dma_iommu_mapping(dev) ((dev)->mapping)
>>  #endif
>>
>> diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
>> index c27e269..3664709 100644
>> --- a/lib/iommu-helper.c
>> +++ b/lib/iommu-helper.c
>> @@ -6,6 +6,17 @@
>>  #include <linux/bitmap.h>
>>  #include <linux/bug.h>
>>
>> +#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
>
> Why isn't this dependency simply part of the Makefile rules?

There are already current users of iommu-helper.c which calls for
iommu_area_alloc APIs.
Putting this config as part of Makefile without other users(except
ARM/ARM64) using this, I felt not very relevant at this point of time.
Moreover, we will have to see all the current users of iommu-helper
and add the config option with them as well, which again I felt not to
do at this point of time.

>
>> +#include <linux/iommu.h>
>> +#include <linux/device.h>
>> +#include <linux/iommu-helper.h>
>> +#include <linux/slab.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/errno.h>
>> +#include <linux/dma-contiguous.h>
>> +#include <linux/mm.h>
>> +#endif
>> +
>>  int iommu_is_span_boundary(unsigned int index, unsigned int nr,
>>                            unsigned long shift,
>>                            unsigned long boundary_size)
>> @@ -39,3 +50,227 @@ again:
>>         return -1;
>>  }
>>  EXPORT_SYMBOL(iommu_area_alloc);
>> +
>> +#ifdef CONFIG_DMA_USE_IOMMU_HELPER_MAPPING
>> +
>> +struct page **iommu_helper_alloc_buffer(struct device *dev, size_t size,
>> +                                         gfp_t gfp, struct dma_attrs *attrs,
>> +                       void (*arch_clear_buffer_cb)(struct page*, size_t))
>> +{
>> +       struct page **pages;
>> +       int count = size >> PAGE_SHIFT;
>> +       int array_size = count * sizeof(struct page *);
>> +       int i = 0;
>> +
>> +       if (array_size <= PAGE_SIZE)
>> +               pages = kzalloc(array_size, gfp);
>> +       else
>> +               pages = vzalloc(array_size);
>> +       if (!pages)
>> +               return NULL;
>> +
>> +       if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
>> +               unsigned long order = get_order(size);
>> +               struct page *page;
>> +
>> +               page = dma_alloc_from_contiguous(dev, count, order);
>> +               if (!page)
>> +                       goto error;
>> +
>> +               if (arch_clear_buffer_cb)
>> +                       arch_clear_buffer_cb(page, size);
>
> Actually, clearing a buffer is always a memset of zero -- the arch-specific
> part is about cache maintenance. The fly in the ointment here is flushing
> highmem pages when you have an outer (physically addressed cache), since we
> want to do the outer-cache maintenance outside of the kmap_atomic region as
> a large block, but the inner-cache maintenance by VA with the highmem
> mapping.
>
> Given that this is only called on the alloc path, is this actually a
> fastpath for anybody? If not, we could move the outer-cache flushing into
> the loop and simply have a arch_flush_buffer_cb instead, which would flush
> l1 and l2 in turn.
>
> That way, architectures that don't have highmem and don't require cache
> maintenance needn't supply a callback at all. Failure to supply a callback
> with your current code means that the buffer is full of junk.

Sure, you are correct here. Let me again take a look at this and get
back to you.

>
>> +/**
>> + * iommu_helper_init_mapping
>> + * @bus: pointer to the bus holding the client device (for IOMMU calls)
>> + * @base: start address of the valid IO address space
>> + * @size: maximum size of the valid IO address space
>> + *
>> + * Creates a mapping structure which holds information about used/unused
>> + * IO address ranges, which is required to perform memory allocation and
>> + * mapping with IOMMU aware functions.
>> + *
>> + */
>> +
>> +struct dma_iommu_mapping *
>> +iommu_helper_init_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
>
> I spoke to Arnd on IRC the other day about this, and ultimately this
> function can plug into of_dma_configure to place each iommu_group into a
> separate iommu_mapping automatically.
>
> Can you put a dummy version of it in the header file, so it returns an error
> when !CONFIG_DMA_USE_IOMMU_HELPER_MAPPING?

OK sure.

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



Thanks
Ritesh
