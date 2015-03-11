From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Mar 2015 12:48:38 +0100
Subject: [PATCH 1/5] of/fdt: allow FDT virtual address outside of linear
 direct mapping
In-Reply-To: <CAKv+Gu-76EnCfNHnqsR6SgEMO3eYi9Jn0Eg-JoNDRbBH8OFn2g@mail.gmail.com>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAL_JsqL=hgQWM93tgp3cCWU290-fbj37LtvqLWFo+vPFVYws3A@mail.gmail.com>
 <CAKv+Gu-76EnCfNHnqsR6SgEMO3eYi9Jn0Eg-JoNDRbBH8OFn2g@mail.gmail.com>
Message-ID: <CAKv+Gu93sQHhBi0afRNRsqR6YeBAhX=LnOMWDPmBN-ydwWQH5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 09:34, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 10 March 2015 at 22:47, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Mar 3, 2015 at 5:03 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> The early FDT code reserves the physical region that contains the
>>> FDT, and uses __pa() to calculate the FDT's physical address.
>>> However, if the FDT is mapped outside of the linear direct mapping,
>>> __pa() cannot be used.
>>>
>>> So create a __weak default wrapper called fdt_virt_to_phys() around
>>> __pa(), and use that instead. This allows architectures to drop in
>>> their own virt/phys mapping for the FDT blob.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>
>>> I am aware that __weak functions are generally frowned upon, but in this
>>> case, I wonder if it is worth the trouble to add arch specific header files
>>> so we can include them here.
>>>
>>>  drivers/of/fdt.c | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 3a896c9aeb74..b10ce880000b 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -547,6 +547,18 @@ static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
>>>  }
>>>
>>>  /**
>>> + * fdt_virt_to_phys - translate a virtual address inside the FDT image
>>> + *                    to its corresponding physical address
>>> + *
>>> + * This needs to be overridden by the architecture if the virtual mapping
>>> + * of the FDT is separate from the linear direct mapping of system RAM
>>> + */
>>> +phys_addr_t __weak __init fdt_virt_to_phys(void *virt)
>>> +{
>>> +       return __pa(virt);
>>> +}
>>> +
>>> +/**
>>>   * early_init_fdt_scan_reserved_mem() - create reserved memory regions
>>>   *
>>>   * This function grabs memory from early allocator for device exclusive use
>>> @@ -562,7 +574,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
>>>                 return;
>>>
>>>         /* Reserve the dtb region */
>>> -       early_init_dt_reserve_memory_arch(__pa(initial_boot_params),
>>> +       early_init_dt_reserve_memory_arch(fdt_virt_to_phys(initial_boot_params),
>>
>> This is already a weak function call, so I'd rather change
>> early_init_dt_reserve_memory_arch to take the virt address and do the
>> conversion inside it.
>> Or we could just pass both addresses from the
>> arch code to the core code.
>>
>
> Alternatively, could we just have a way to tell the core FDT code
> /not/ to do the reservation at all? It would make sense in the
> non-linear mapped FDT case to round up the reservation to the mapped
> size so that the remainder is not mapped elsewhere with different
> attributes, so it is not just the physical address but also the size
> that is different, and it is trivial to add the memblock_reserve() to
> the remapping code.

Actually, having the FDT region retain duplicate mappings of physical
pages that are not covered by the FDT memory reservation itself is not
recognized as a big deal, so memblock_reserve()'ing the actual size of
the FDT is fine.

But still, what you are proposing (I think) is update the prototype of
early_init_dt_scan() to take an additional physical address, which
would also involve updating a handful of architectures to modify the
call sites (yay). And the alternative to change
early_init_dt_reserve_memory_arch() to take a virtual address won't
work for high memory.

So what about just doing this instead?

@@ -574,7 +562,8 @@ void __init early_init_fdt_scan_reserved_mem(void)
                return;

        /* Reserve the dtb region */
-       early_init_dt_reserve_memory_arch(fdt_virt_to_phys(initial_boot_params),
+       if (!IS_ENABLED(CONFIG_OF_HAVE_VIRT_REMAPPED_FDT))
+               early_init_dt_reserve_memory_arch(__pa(initial_boot_params),
                                          fdt_totalsize(initial_boot_params),
                                          0);

This way, it is left up to the architecture to decide which memory
(and how much) to reserve.
