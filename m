From: zhongjiang@huawei.com (zhong jiang)
Date: Tue, 25 Apr 2017 16:13:12 +0800
Subject: [PATCH] arm64: fix the overlap between the kernel image and
 vmalloc address
In-Reply-To: <CAKv+Gu9RuJC9LgsEDSf91x4gV+VoRTLTjA9hGoPAu1ZkFDODmA@mail.gmail.com>
References: <1493025729-21505-1-git-send-email-zhongjiang@huawei.com>
 <20170424104456.GA4343@leverpostej> <58FDFD90.8050300@huawei.com>
 <20170424155125.GA5972@leverpostej>
 <ffd0a3c5-5d89-4bbd-9995-c545bccaa8f6@redhat.com>
 <CAKv+Gu9RuJC9LgsEDSf91x4gV+VoRTLTjA9hGoPAu1ZkFDODmA@mail.gmail.com>
Message-ID: <58FF0518.1000906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/4/25 1:56, Ard Biesheuvel wrote:
> On 24 April 2017 at 18:52, Laura Abbott <labbott@redhat.com> wrote:
>> On 04/24/2017 08:51 AM, Mark Rutland wrote:
>>> On Mon, Apr 24, 2017 at 09:28:48PM +0800, zhong jiang wrote:
>>>> On 2017/4/24 18:44, Mark Rutland wrote:
>>>>> So the issue is that we have the callchain below for a kernel image
>>>>> address:
>>>>>
>>>>> read_kcore()
>>>>> ->is_vmalloc_or_module_addr() // returns true
>>>>> ->vread()
>>>>> -->aligned_vread()
>>>>> --->vmalloc_to_page()
>>>>>
>>>>> In is_vmalloc{,or_module}_addr() we just check the addr against
>>>>> VMALLOC_START and VMALLOC_END, so they will return true for a kernel
>>>>> image address.
>>>>>
>>>>> Then, we call vmalloc_to_page(). While this only handles mappings made
>>>>> at page granularity, the kernel image mapping may have used sections. So
>>>>> this tries a bogus walk to the pte level.
>>>>> Should we special-case kernel image handling, e.g. with new
>>>>> is_kernel_image_addr() / kernel_image_to_page() helpers?
>>>>   yes ,  it seems to the best way to implents it  without performance back.
>>>> The following patch is the implment. Any thought?
>>>>
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>>
>>>>   diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index b84615b..851ac35 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -475,6 +475,15 @@ static inline bool is_vmalloc_addr(const void *x)
>>>>         return false;
>>>>  #endif
>>>>  }
>>>> +
>>>> +static inline bool is_kernel_image_addr(const void *x)
>>>> +{
>>>> +       unsigned long addr = (unsigned long)x;
>>>> +
>>>> +       return addr >= (unsigned long)_stext && addr < (unsigned long)_end;
>>>> +
>>>> +}
>>>> +
>>>>  #ifdef CONFIG_MMU
>>>>  extern int is_vmalloc_or_module_addr(const void *x);
>>>>  #else
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index 3ca82d4..9a9ef65 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -229,6 +229,42 @@ int is_vmalloc_or_module_addr(const void *x)
>>>>         return is_vmalloc_addr(x);
>>>>  }
>>>>
>>>> +static struct page *kernel_image_to_page(const void *kernel_addr, pgd_t *pgd)
>>>> +{
>>>> +       unsigned long addr = (unsigned long)kernel_addr;
>>>> +       struct page *page = NULL;
>>>> +       pud_t *pud;
>>>> +       pmd_t *pmd;
>>>> +       pte_t *pte;
>>>> +
>>>> +       if (pgd_none(*pgd))
>>>> +               goto out;
>>>> +
>>>> +       pud = pud_offset(pgd, addr);
>>>> +       if (pud_none(*pud))
>>>> +               goto out;
>>>> +
>>>> +       if (pud_sect(*pud))
>>>> +               return pud_page(*pud);
>>> The *_sect() helpers are arch-specific, so we cannot use them in generic
>>> code. This would need to be architecture-specific.
>>>
>>> Secondly, this will return head page of the section regardless of which
>>> page in the section the address corresponds to
>>>
>>>> +
>>>> +       pmd = pmd_offset(*pmd, addr);
>>>> +       if (pmd_none(*pmd))
>>>> +               goto out;
>>>> +
>>>> +       if (pmd_sect(*pmd))
>>>> +               return pmd_page(*pmd);
>>> Likewise on both counts.
>>>
>>>> +
>>>> +       pte = pte_offset_kernel(pmd, addr);
>>>> +       if (pte_none(*pte))
>>>> +               goto out;
>>>> +
>>>> +       page = pte_page(*pte);
>>>> +
>>>> +out:
>>>> +       return page;
>>>> +
>>>> +}
>>> Given we know what the address should map to, I don't think we need to
>>> walk the page tables here. I think this can be:
>>>
>>> static struct page *kernel_image_to_page(const void *addr)
>>> {
>>>       return virt_to_page(lm_alias(vmalloc_addr));
>>> }
>>>
>>>> +
>>>>  /*
>>>>    * Walk a vmap address to the struct page it maps.
>>>>    */
>>>> @@ -244,6 +280,9 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
>>>>          */
>>>>         VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
>>>>
>>>> +       if (is_kernel_image_addr(vmalloc_addr))
>>>> +               return kernel_image_to_page(vmalloc_addr, pgd);
>>> It's not clear to me that this is the right place for this to live.
>>>
>>> It might be best to code the kernel image logic directly in kcore (and
>>> kmem), assuming everyone's OK with that approach.
>>>
>> That will fix kcore and kmem but this will show up in other places too.
>> We've gone through and made sure that virt_addr_valid returns
>> true if and only if virt_to_page returns a valid address. I don't know
>> if we can make as strong a claim about is_vmalloc_addr and
>> vmalloc_to_page in all cases but is_vmalloc_addr should not return true
>> for the kernel image. That would at least let kcore fall back to
>> kern_addr_valid which should correctly handle the kernel image.
>> The suggestion to move the kernel image out of VMALLOC_START/VMALLOC_END
>> seems like the best approach although I haven't tried a prototype
>> at all.
>>
> Moving the kernel into the vmalloc region was kind of the point, for
> KASLR. Undoing that means either disabling KASLR, or splitting the
> vmalloc region into a KASLR region only for the kernel, and a vmalloc
> region like we had when vmlinux lived in the linear region.
>
> In general, I think we should be able to deal with different kinds of
> mappings with different granularity in the vmalloc region. If
> necessary, we could introduce a VM_xxx flag for the kernel to
> distinguish such regions from ordinary VM_MAP regions.
> .
>
 Hi, Ard

 My initial thought is same with you. valloc_to_page is public for any ARCH.
 Only arm64 change the mappings granularity. if we need to adjust the function
 to any ARCH, it should implement it in each ARCH. or add CONFIG_ARM64 code to
 exclude the other ARCH. because the pud_* helper is arch related.
 
 Mark proposed that add kernel_image_is_page helper is more simple.
 and I prefer to the Mark opinions. Do you think? or I miss anythings.
 
 Depend on you and other maintainers.
 
 Thanks
 zhongjiang
