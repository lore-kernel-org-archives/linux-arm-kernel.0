From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 20 Nov 2014 15:20:40 -0800
Subject: CONFIG_DEBUG_SET_MODULE_RONX broken (was Re: [PATCHv2] arm64: add
 support to dump the kernel page tables)
In-Reply-To: <CAGXu5jK7FWs2v52T2RBdKhdYcV5wGm3F4H4km9h-B15Z6S0A2Q@mail.gmail.com>
References: <1416262710-7798-1-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jK7FWs2v52T2RBdKhdYcV5wGm3F4H4km9h-B15Z6S0A2Q@mail.gmail.com>
Message-ID: <546E7748.4000603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(cc Rusty Russell for reference)

On 11/19/2014 3:01 PM, Kees Cook wrote:
> On Mon, Nov 17, 2014 at 2:18 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> In a similar manner to arm, it's useful to be able to dump the page
>> tables to verify permissions and memory types. Add a debugfs file
>> to check the page tables.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>
> This seems to behave well for me. Thanks!
>
> Tested-by: Kees Cook <keescook@chromium.org>
>
> In my configuration, though, with CONFIG_DEBUG_SET_MODULE_RONX=y, I'm
> only seeing RO, and no NX changes. I haven't constructed a test for
> the module memory behavior directly (to see if this is a page table
> issue or a PTDUMP reporting issue). This series I'm testing has gone
> through some backporting on my end, so I wanted to just double-check
> and see if you saw this too, or if it's specific to my environment:
>
> ---[ Modules ]---
> 0xffffffbffc000000-0xffffffbffc005000          20K     ro x  SHD AF
> UXN MEM/NORMAL
> 0xffffffbffc005000-0xffffffbffc007000           8K     RW x  SHD AF
> UXN MEM/NORMAL
> 0xffffffbffc00c000-0xffffffbffc00e000           8K     ro x  SHD AF
> UXN MEM/NORMAL
> 0xffffffbffc00e000-0xffffffbffc010000           8K     RW x  SHD AF
> UXN MEM/NORMAL
> ...
>
> Thanks,
>
> -Kees
>

Yep, I'm seeing the same thing. We're failing the bounds check:

if (!is_module_address(start) || !is_module_address(end - 1))
                 return -EINVAL;

There are now two problems with this check

1) 4982223e51e8 module: set nx before marking module MODULE_STATE_COMING
moved around the order of when nx was set. Now we hit the mod->state ==
MODULE_STATE_UNFORMED in __module_address so module_address on anything
always returns false. I think my previous testing must have been done
on a branch without that patch.

2) It's possible for the end of the region we are trying to set as nx
to not be fully page size aligned. This seems to be caused by things
getting aligned in layout_section but becoming unaligned in layout_symtab

diff --git a/kernel/module.c b/kernel/module.c
index 972151b..3791330 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2316,10 +2316,14 @@ static void layout_symtab(struct module *mod, struct load_info *info)
         info->stroffs = mod->core_size = info->symoffs + ndst * sizeof(Elf_Sym);
         mod->core_size += strtab_size;
  
+       mod->core_size = debug_align(mod->core_size);
+
         /* Put string table section at end of init part of module. */
         strsect->sh_flags |= SHF_ALLOC;
         strsect->sh_entsize = get_offset(mod, &mod->init_size, strsect,
                                          info->index.str) | INIT_OFFSET_MASK;
+
+       mod->init_size = debug_align(mod->init_size);
         pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
  }
  
I haven't tried a bisect to see if this is new.

I'm kind of tempted to switch the bounds check back to
(addr >= MODULES_VADDR && addr < MODULES_END) unless there is a clean way to
fixup module.c

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
