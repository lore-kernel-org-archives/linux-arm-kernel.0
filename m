From: mbenes@suse.cz (Miroslav Benes)
Date: Fri, 19 Oct 2018 17:14:38 +0200 (CEST)
Subject: [PATCH v3 3/4] arm64: implement live patching
In-Reply-To: <20181019121847.eug4p2mxr32cebk2@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz>
 <20181018125820.iw54zbirq74ulknj@linux-8ccs>
 <alpine.LSU.2.21.1810191338020.4692@pobox.suse.cz>
 <20181019121847.eug4p2mxr32cebk2@linux-8ccs>
Message-ID: <alpine.LSU.2.21.1810191709050.4692@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >If I am not mistaken, we do not care for arch.init.plt in livepatch. Is
> >that correct?
> 
> I do not believe patching of __init functions is supported (right?) So
> we do not need to keep arch.init.plt alive post-module-load.

I think we can do that. Theoretically. I'm not sure if it is actually 
useful. Module's init functions are called after the modules is patched, 
so there is no obstacle.

But arch.init.plt would be useful only for the relocations of the patching 
module, right? Patching functions would not part of init section anyway, I 
think, so arch.init.plt is useless post-module-load.
 
> >> int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >> 			      char *secstrings, struct module *mod)
> >> {
> >> @@ -210,11 +225,13 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr,
> >> Elf_Shdr
> >> *sechdrs,
> >>   * entries. Record the symtab address as well.
> >>   */
> >> 	for (i = 0; i < ehdr->e_shnum; i++) {
> >> -		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> >> +		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
> >> 			mod->arch.core.plt = sechdrs + i;
> >> -		else if (!strcmp(secstrings + sechdrs[i].sh_name,
> >> ".init.plt"))
> >> +			mod->arch.core.plt_shndx = i;
> >> +		} else if (!strcmp(secstrings + sechdrs[i].sh_name,
> >> ".init.plt")) {
> >> 			mod->arch.init.plt = sechdrs + i;
> >> -		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> >> +			mod->arch.init.plt_shndx = i;
> >
> >It is initialized here, but that's not necessarily a bad thing.
> 
> I think I added this line for consistency, but I actually don't think
> it is needed. We only would need to keep the section index for
> arch.core.plt then.

Yes. I'd welcome a comment somewhere in both cases. Either that we 
initialize it just for consistency, or that we don't, because it's not 
needed.

Miroslav
