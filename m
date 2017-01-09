From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 9 Jan 2017 13:54:27 +0000
Subject: [RFC v2 PATCH 1/3] ARM: NOMMU: introduce dma operations for noMMU
In-Reply-To: <CA+M3ks6kQGc_fSVcne-tv3D5-yX=3-5QpfDVnKgfyDmOvJ_Pcg@mail.gmail.com>
References: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
 <1481636704-18948-2-git-send-email-vladimir.murzin@arm.com>
 <CA+M3ks7Kzskb-VBQQdC2cNC52kro+6g2M6n5Rw4_vz-T4xn_eg@mail.gmail.com>
 <9c957673-64ba-67ca-46a0-2bde26c95d9c@arm.com>
 <CA+M3ks6kQGc_fSVcne-tv3D5-yX=3-5QpfDVnKgfyDmOvJ_Pcg@mail.gmail.com>
Message-ID: <2cb75068-27ca-0625-921c-9cc7668b9b36@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 13:58, Benjamin Gaignard wrote:
> 2017-01-04 11:33 GMT+01:00 Vladimir Murzin <vladimir.murzin@arm.com>:
>> Hello Benjamin,
>>
>> On 02/01/17 15:26, Benjamin Gaignard wrote:
>>> Hello Vladimir,
>>>
>>> I have tested your patch on my setup (stm32f4: no MMU, no MPU) where
>>> I'm writing display driver.
>>> This driver use dma_alloc_wc() and dma_mmap_wc() for frame buffer
>>> allocation and mmapping.
>>>
>>> In dma-mapping-nommu.c you haven't implement dma_map_ops.mmap so
>>> obviously my driver
>>> doesn't work with your code.
>>> In current implementation it is buggy too but I submit a patch to fix
>>> that problem:
>>> http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8633/1
>>>
>>> Could it be possible for you to include mmap support in dma-mapping-nommu.c ?
>>>
>>
>> IIRC, stm32f4 is Cortex-M4, so no cache support and it means that it uses
>> dma_noop_ops. I offloaded mmap to common implementation, but completely forgot
>> it has the same restriction as arm counterpart. Regardless, thanks for
>> noticing that!
>>
>> It seems that I need to check that mapping is done from DMA coherent area (I'm
>> moving to dma-coherent and here we have dma_mmap_from_coherent for that) and
>> something like bellow for dma_noop_ops:
>>
>> diff --git a/lib/dma-noop.c b/lib/dma-noop.c
>> index 3d766e7..d838b88 100644
>> --- a/lib/dma-noop.c
>> +++ b/lib/dma-noop.c
>> @@ -64,6 +64,25 @@ static int dma_noop_supported(struct device *dev, u64 mask)
>>         return 1;
>>  }
>>
>> +static int dma_noop_mmap(struct device *dev, struct vm_area_struct *vma,
>> +                        void *cpu_addr, dma_addr_t dma_addr, size_t size)
>> +{
>> +       unsigned long user_count = vma_pages(vma);
>> +       unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +       unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>> +       unsigned long off = vma->vm_pgoff;
>> +       int ret = -ENXIO;
>> +
>> +       if (off < count && user_count <= (count - off)) {
>> +               ret = remap_pfn_range(vma, vma->vm_start,
>> +                                     pfn + off,
>> +                                     user_count << PAGE_SHIFT,
>> +                                     vma->vm_page_prot);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  struct dma_map_ops dma_noop_ops = {
>>         .alloc                  = dma_noop_alloc,
>>         .free                   = dma_noop_free,
>> @@ -71,6 +90,7 @@ struct dma_map_ops dma_noop_ops = {
>>         .map_sg                 = dma_noop_map_sg,
>>         .mapping_error          = dma_noop_mapping_error,
>>         .dma_supported          = dma_noop_supported,
>> +       .mmap                   = dma_noop_mmap,
>>  };
>>
>>  EXPORT_SYMBOL(dma_noop_ops);
>>
>> I'd be glad to hear if it works for you.
> 
> With your patch mmap() does return an address unfortunately
> framebuffer isn't displayed
> anymore, I have a black screen instead of the usual pattern.
> 
> Without your patches my allocations dma_alloc_wc requests go to
> dma-mapping so I guess
> the problem is coming from dma noop implementation.
> I have try to use dma-mapping-nommu ops but the status is the same.

Thanks for giving it a go! I messed up function prototype above, it should be: 

static int dma_noop_mmap(struct device *dev, struct vm_area_struct *vma,
                        void *cpu_addr, dma_addr_t dma_addr, size_t size,
                        unsigned long attrs)

I've just sent v3 and I tested mmap() there with amba-clcd driver + some hacks
to make mmap call work with framebuffer.

Cheers
Vladimir

> 
>>
>> Cheers
>> Vladimir
>>
>>> Regards,
>>> Benjamin
> 
> 
> 
