From: mbenes@suse.cz (Miroslav Benes)
Date: Wed, 24 Oct 2018 13:57:24 +0200 (CEST)
Subject: [PATCH] arm64/module: use mod->klp_info section header information
In-Reply-To: <20181023175553.gaobskk26koft6s2@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
Message-ID: <alpine.LSU.2.21.1810241341580.20865@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018, Jessica Yu wrote:

> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index f0690c2ca3e0..05067717dfc5 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -210,9 +210,15 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr
> *sechdrs,
> 	 * entries. Record the symtab address as well.
> 	 */
> 	for (i = 0; i < ehdr->e_shnum; i++) {
> -		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> +		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
> 			mod->arch.core.plt = sechdrs + i;
> -		else if (!strcmp(secstrings + sechdrs[i].sh_name,
> ".init.plt"))
> +			/*
> +			 * Keep the section index for the .plt section for
> +			 * livepatching. Note that .init.plt is irrelevant to
> +			 * livepatch, so only the shndx for .plt is saved.
> +			 */
> +			mod->arch.core.plt_shndx = i;
> +		} else if (!strcmp(secstrings + sechdrs[i].sh_name,
> ".init.plt"))

Else branches should have braces now too according to the coding style.

Otherwise it looks good to me.

Thanks,
Miroslav
