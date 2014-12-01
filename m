From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 01 Dec 2014 13:53:24 -0800
Subject: CONFIG_DEBUG_SET_MODULE_RONX broken (was Re: [PATCHv2] arm64:
 add support to dump the kernel page tables)
In-Reply-To: <878uiyxzro.fsf@rustcorp.com.au>
References: <1416262710-7798-1-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jK7FWs2v52T2RBdKhdYcV5wGm3F4H4km9h-B15Z6S0A2Q@mail.gmail.com>
 <546E7748.4000603@codeaurora.org> <878uiyxzro.fsf@rustcorp.com.au>
Message-ID: <547CE354.5030508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2014 10:05 PM, Rusty Russell wrote:
>>
>> Yep, I'm seeing the same thing. We're failing the bounds check:
>>
>> if (!is_module_address(start) || !is_module_address(end - 1))
>>                   return -EINVAL;
>
> That's a weird test, but I can agree that it's now broken.  What's it for?
>

Both arm and arm64 map underlying memory with page table mappings that may
be greater than PAGE_SIZE. Rather than deal with the hassle of trying to
tear down the larger mappings and call stop_machine to flush the TLBs, we
just disallow changing attributes of arbitrary memory. Module memory is
always mapped with 4K pages so it's safe to change the attributes, hence
the bounds check above. On arm we just bounds check via
MODULE_START <= addr < MODULE_END so that wasn't affected.

>> There are now two problems with this check
>>
>> 1) 4982223e51e8 module: set nx before marking module MODULE_STATE_COMING
>> moved around the order of when nx was set. Now we hit the mod->state ==
>> MODULE_STATE_UNFORMED in __module_address so module_address on anything
>> always returns false. I think my previous testing must have been done
>> on a branch without that patch.
>>
>> 2) It's possible for the end of the region we are trying to set as nx
>> to not be fully page size aligned. This seems to be caused by things
>> getting aligned in layout_section but becoming unaligned in layout_symtab
>
> Yes, but you only need the first change in your patch: mod->init_size
> should already be aligned (and unlike mod->core_size, we haven't
> modified it).
>

the init size can be modified via get_offset though. In my testing I needed
to align up both mod->init_size and mod->core_size for is_module_address to
pass on all set_memory_* calls made by the module layer.

>> diff --git a/kernel/module.c b/kernel/module.c
>> index 972151b..3791330 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2316,10 +2316,14 @@ static void layout_symtab(struct module *mod, struct load_info *info)
>>           info->stroffs = mod->core_size = info->symoffs + ndst * sizeof(Elf_Sym);
>>           mod->core_size += strtab_size;
>>
>> +       mod->core_size = debug_align(mod->core_size);
>> +
>>           /* Put string table section at end of init part of module. */
>>           strsect->sh_flags |= SHF_ALLOC;
>>           strsect->sh_entsize = get_offset(mod, &mod->init_size, strsect,
>>                                            info->index.str) | INIT_OFFSET_MASK;
>> +
>> +       mod->init_size = debug_align(mod->init_size);
>>           pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
>>    }
>>
>> I haven't tried a bisect to see if this is new.
>>
>> I'm kind of tempted to switch the bounds check back to
>> (addr >= MODULES_VADDR && addr < MODULES_END) unless there is a clean way to
>> fixup module.c
>
> Thanks,
> Rusty.
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
