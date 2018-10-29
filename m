From: mbenes@suse.cz (Miroslav Benes)
Date: Mon, 29 Oct 2018 14:24:16 +0100 (CET)
Subject: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
In-Reply-To: <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
Message-ID: <alpine.LSU.2.21.1810291415340.22023@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index dd23655fda3a..490e56070a7e 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -461,5 +461,15 @@ int module_finalize(const Elf_Ehdr *hdr,
> #endif
> 	}
> 
> +#ifdef CONFIG_LIVEPATCH
> +	/*
> +	 * For livepatching, switch to the saved section header info for .plt
> +	 * stored in mod->klp_info. This is needed so that livepatch is able to
> +	 * call apply_relocate_add() after patch module load.
> +	 */
> +	if (is_livepatch_module(me))
> +		me->arch.core.plt = me->klp_info->sechdrs + me->arch.core.plt_shndx;
> +#endif

I missed it before, but the hunk should be under "#ifdef 
CONFIG_ARM64_MODULE_PLTS" protection similarly to ftrace_trampoline just 
above. me->arch.core.plt may not exist otherwise.

Miroslav
