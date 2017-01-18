From: mbenes@suse.cz (Miroslav Benes)
Date: Wed, 18 Jan 2017 11:37:49 +0100 (CET)
Subject: arm: module: Add apply_relocate_add
In-Reply-To: <20170117044921.GI9045@packer-debian-8-amd64.digitalocean.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-4-git-send-email-abelvesa@linux.com>
 <20170117044921.GI9045@packer-debian-8-amd64.digitalocean.com>
Message-ID: <alpine.LSU.2.20.1701181133410.23458@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jan 2017, Jessica Yu wrote:

> +++ Abel Vesa [06/12/16 17:06 +0000]:
> > It was only added to fix compiler error. It is not implemented
> > yet.
> > 
> > Signed-off-by: Abel Vesa <abelvesa@linux.com>
> > ---
> > arch/arm/kernel/module.c | 9 +++++++++
> > 1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> > index 4f14b5c..bf94922 100644
> > --- a/arch/arm/kernel/module.c
> > +++ b/arch/arm/kernel/module.c
> > @@ -52,6 +52,15 @@ void *module_alloc(unsigned long size)
> > #endif
> > 
> > int
> > +apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
> > +		   unsigned int symindex, unsigned int relindex,
> > +		   struct module *module)
> > +{
> > +	/* Not implemented yet */
> > +	return 0;
> > +}
> 
> Are SHT_RELA relocation sections actually supported on 32-bit arm? It looks
> like there's only support for SHT_REL.
> 
> arch/arm/Kconfig:84:	select MODULES_USE_ELF_REL
> 
> If we support SHT_REL sections, the correct fix is to probably have
> klp_write_object_relocations() check if the relocation section is
> SHT_REL or SHT_RELA, and call the appropriate function (apply_relocate
> or apply_relocate_add), similar to how the module loader does it.

Agreed. According to arch/Kconfig and definitions you can use only one of 
MODULES_USE_ELF_REL and MODULES_USE_ELF_RELA. arm arch uses the former. So 
yes, I think we should use the same if/else construct from the module 
loader in klp_write_object_relocations()... and it should go with this 
patch set, because arm is the first arch to actually use SHT_REL and not 
SHT_RELA (iiuc). x86, s390 and powerpc (archs we support) use SHT_RELA.

Miroslav
