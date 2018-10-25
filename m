From: mbenes@suse.cz (Miroslav Benes)
Date: Thu, 25 Oct 2018 11:00:33 +0200 (CEST)
Subject: [PATCH] arm64/module: use mod->klp_info section header information
In-Reply-To: <20181025080816.525dppcfrrevf6jc@pathway.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181025080816.525dppcfrrevf6jc@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1810251051330.9841@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2018, Petr Mladek wrote:

> On Tue 2018-10-23 19:55:54, Jessica Yu wrote:
> > The arm64 module loader keeps a pointer into info->sechdrs to keep track
> > of section header information for .plt section(s). A pointer to the
> > relevent section header (struct elf64_shdr) in info->sechdrs is stored
> > in mod->arch.{init,core}.plt. This pointer may be accessed while
> > applying relocations in apply_relocate_add() for example. And unlike
> > normal modules, livepatch modules can call apply_relocate_add() after
> > module load. But the info struct (and therefore info->sechdrs) gets
> > freed at the end of load_module() and so mod->arch.{init,core}.plt
> > becomes an invalid pointer after the module is done loading.
> > 
> > Luckily, livepatch modules already keep a copy of Elf section header
> > information in mod->klp_info. So make sure livepatch modules on arm64
> > have access to the section headers in klp_info and set
> > mod->arch.{init,core}.plt to the appropriate section header in
> > mod->klp_info so that they can call apply_relocate_add() even after
> > module load.
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index f475f30eed8c..f3ac04cc9fc3 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3367,6 +3367,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
> > 
> > static int post_relocation(struct module *mod, const struct load_info *info)
> > {
> > +	int err;
> > +
> > 	/* Sort exception table now relocations are done. */
> > 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
> > 
> > @@ -3377,8 +3379,18 @@ static int post_relocation(struct module *mod, const struct load_info *info)
> > 	/* Setup kallsyms-specific fields. */
> > 	add_kallsyms(mod, info);
> > 
> > +	if (is_livepatch_module(mod)) {
> > +		err = copy_module_elf(mod, info);
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> > 	/* Arch-specific module finalizing. */
> > -	return module_finalize(info->hdr, info->sechdrs, mod);
> > +	err = module_finalize(info->hdr, info->sechdrs, mod);
> > +	if (err < 0)
> 
> 	if (err < 0 && is_livepatch_module(mod))

Ah, right.
 
> > +		free_module_elf(mod);
> > +
> > +	return err;
> > }
> 
> Also we need to free the copied stuff in load_module() when
> anything called after post_relocation() fails. I think
> that the following would work:
> 
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3823,6 +3823,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	kfree(mod->args);
>   free_arch_cleanup:
>  	module_arch_cleanup(mod);
> +	if (is_livepatch_module(mod))
> +		free_module_elf(mod);
>   free_modinfo:
>  	free_modinfo(mod);
>   free_unload:

Yes, we need to free it somewhere and I missed it. free_arch_cleanup seems 
to be the correct place.
 
> But I suggest to just move copy_module_elf() up and keep
> calling it from load_module() directly. It would make
> the error handling more clear.

Unfortunately it is not that simple. arm64's module_finalize() uses 
mod->klp_info with the patch, so copy_module_elf() must be called before. 
We could move module_finalize() from post_relocation() to load_module() 
and place copy_module_elf() between those two, but I don't know. That's up 
to Jessica.

Miroslav
