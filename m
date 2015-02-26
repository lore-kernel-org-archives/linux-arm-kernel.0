From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 26 Feb 2015 12:03:00 +1030
Subject: [PATCH 3/3] kernel/module.c: Update debug alignment after
 symtable generation
In-Reply-To: <1424902497-32141-4-git-send-email-lauraa@codeaurora.org>
References: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
 <1424902497-32141-4-git-send-email-lauraa@codeaurora.org>
Message-ID: <87sidtlann.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laura Abbott <lauraa@codeaurora.org> writes:
> When CONFIG_DEBUG_SET_MODULE_RONX is enabled, the sizes of
> module sections are aligned up so appropriate permissions can
> be applied. Adjusting for the symbol table may cause them to
> become unaligned. Make sure to re-align the sizes afterward.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

This won't clash with anything I'm planning, so happy for this to go in
through the arm trees.  CC:stable should be fine if you want too.

Thanks,
Rusty.

> ---
>  kernel/module.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index b34813f..cc93cf6 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2313,11 +2313,13 @@ static void layout_symtab(struct module *mod, struct load_info *info)
>  	info->symoffs = ALIGN(mod->core_size, symsect->sh_addralign ?: 1);
>  	info->stroffs = mod->core_size = info->symoffs + ndst * sizeof(Elf_Sym);
>  	mod->core_size += strtab_size;
> +	mod->core_size = debug_align(mod->core_size);
>  
>  	/* Put string table section at end of init part of module. */
>  	strsect->sh_flags |= SHF_ALLOC;
>  	strsect->sh_entsize = get_offset(mod, &mod->init_size, strsect,
>  					 info->index.str) | INIT_OFFSET_MASK;
> +	mod->init_size = debug_align(mod->init_size);
>  	pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
>  }
>  
> -- 
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
