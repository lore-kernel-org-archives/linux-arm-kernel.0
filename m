From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Sun, 14 Sep 2014 22:58:58 +0530
Subject: [PATCH 1/5] uio: Add new UIO_MEM_PHYS_CACHE type for mem regions
In-Reply-To: <20140909192910.GA7885@kroah.com>
References: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
 <1410256619-3213-2-git-send-email-ankit.jindal@linaro.org>
 <20140909192910.GA7885@kroah.com>
Message-ID: <CAPTm99XaXYhJYHypFt2pQwBHAQ9_wAxZp_NjdiuGtWs6TY0bBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 September 2014 00:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Sep 09, 2014 at 03:26:55PM +0530, Ankit Jindal wrote:
>> Currently, three types of mem regions are supported: UIO_MEM_PHYS,
>> UIO_MEM_LOGICAL and UIO_MEM_VIRTUAL. Among these UIO_MEM_PHYS helps
>> UIO driver export physcial memory to user space as non-cacheable
>> user memory. Typcially memory-mapped registers of a device are exported
>> to user space as UIO_MEM_PHYS type mem region. The UIO_MEM_PHYS type
>> is not useful if dma-capable devices are capable of maintaining coherency
>> with CPU caches becasue we can allow cacheable access to memory shared
>> between such devices and user space.
>>
>> This patch adds new type UIO_MEM_PHYS_CACHE for mem regions to enable
>> cacheable access to physical memory from user space.
>>
>> Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
>> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
>> ---
>>  drivers/uio/uio.c          |   22 +++++++++++++---------
>>  include/linux/uio_driver.h |    7 ++++---
>>  2 files changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
>> index a673e5b..ff5b6c0 100644
>> --- a/drivers/uio/uio.c
>> +++ b/drivers/uio/uio.c
>> @@ -644,7 +644,7 @@ static const struct vm_operations_struct uio_physical_vm_ops = {
>>  #endif
>>  };
>>
>> -static int uio_mmap_physical(struct vm_area_struct *vma)
>> +static int uio_mmap_physical(struct vm_area_struct *vma, bool cacheable)
>>  {
>>       struct uio_device *idev = vma->vm_private_data;
>>       int mi = uio_find_mem_index(vma);
>> @@ -659,7 +659,9 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
>>               return -EINVAL;
>>
>>       vma->vm_ops = &uio_physical_vm_ops;
>> -     vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +
>> +     if (!cacheable)
>> +             vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>
>>       /*
>>        * We cannot use the vm_iomap_memory() helper here,
>> @@ -706,13 +708,15 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>>       }
>>
>>       switch (idev->info->mem[mi].memtype) {
>> -             case UIO_MEM_PHYS:
>> -                     return uio_mmap_physical(vma);
>> -             case UIO_MEM_LOGICAL:
>> -             case UIO_MEM_VIRTUAL:
>> -                     return uio_mmap_logical(vma);
>> -             default:
>> -                     return -EINVAL;
>> +     case UIO_MEM_PHYS:
>> +             return uio_mmap_physical(vma, false);
>> +     case UIO_MEM_LOGICAL:
>> +     case UIO_MEM_VIRTUAL:
>> +             return uio_mmap_logical(vma);
>> +     case UIO_MEM_PHYS_CACHE:
>> +             return uio_mmap_physical(vma, true);
>> +     default:
>> +             return -EINVAL;
>
> Please don't do code style cleanups in the same patch you are adding new
> functionality.  I can't take this because of this, sorry.

Sure, I will separate out the patch for code style cleanups.

>
> greg k-h

Thanks,
Ankit
