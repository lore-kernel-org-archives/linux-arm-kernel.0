From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 9 Feb 2011 12:17:01 +0000
Subject: [RFC 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys runtime
	patching
In-Reply-To: <E1PaDPa-00023l-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPa-00023l-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <20110209121701.GD2818@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I haven't been using the runtime patching, but building picoxcell based 
off of todays next I'm seeing a pretty harmless warning.  Fixup below.

Jamie

On Tue, Jan 04, 2011 at 08:23:18PM +0000, Russell King - ARM Linux wrote:
> This idea came from Nicolas, Eric Miao produced an initial version,
> which was then rewritten into this.
> 
> Patch the physical to virtual translations at runtime.  As we modify
> the code, this makes it incompatible with XIP kernels, but on allows
> is to achieve this with minimal loss of performance.
> 
> As many translations are of the form:
> 
> 	physical = virtual + (PHYS_OFFSET - PAGE_OFFSET)
> 	virtual = physical - (PHYS_OFFSET - PAGE_OFFSET)
> 
> we generate an 'add' instruction for __virt_to_phys(), and a 'sub'
> instruction for __phys_to_virt().  We calculate at run time (PHYS_OFFSET
> - PAGE_OFFSET) by comparing the address prior to MMU initialization with
> where it should be once the MMU has been initialized, and place this
> constant into the above add/sub instructions.
> 
> Once we have (PHYS_OFFSET - PAGE_OFFSET), we can calcuate the real
> PHYS_OFFSET as PAGE_OFFSET is a build-time constant, and save this for
> the C-mode PHYS_OFFSET variable definition to use.
> 
> At present, we are unable to support Realview with Sparsemem enabled
> as this uses a complex mapping function, and MSM as this requires a
> constant which will not fit in our math instruction.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig              |   14 +++++++++
>  arch/arm/include/asm/memory.h |   55 ++++++++++++++++++++++++++++--------
>  arch/arm/kernel/head.S        |   63 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/module.c      |   23 ++++++++++++++-
>  arch/arm/kernel/setup.c       |    2 +-
>  arch/arm/kernel/vmlinux.lds.S |    4 ++
>  6 files changed, 147 insertions(+), 14 deletions(-)
> 
[...]
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 0c1bb68..6a42e17 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -276,12 +276,28 @@ struct mod_unwind_map {
>  	const Elf_Shdr *txt_sec;
>  };
>  
> +static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
> +	const Elf_Shdr *sechdrs, const char *name)
> +{
> +	const Elf_Shdr *s, *se;
> +	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> +
> +	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++)
> +		if (strcmp(name, secstrs + s->sh_name) == 0)
> +			return s;
> +
> +	return NULL;
> +}
> +
> +extern void fixup_pv_table(const void *, unsigned long);
> +
>  int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>  		    struct module *mod)
>  {
> +	const Elf_Shdr *s = NULL;
>  #ifdef CONFIG_ARM_UNWIND
>  	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> -	const Elf_Shdr *s, *sechdrs_end = sechdrs + hdr->e_shnum;
> +	const Elf_Shdr *sechdrs_end = sechdrs + hdr->e_shnum;
>  	struct mod_unwind_map maps[ARM_SEC_MAX];
>  	int i;
>  
> @@ -323,6 +339,11 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>  					         maps[i].txt_sec->sh_addr,
>  					         maps[i].txt_sec->sh_size);
>  #endif
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> +	s = find_mod_section(hdr, sechdrs, ".pv_table");
> +	if (s)
> +		fixup_pv_table((void *)s->sh_addr, s->sh_size);
> +#endif

If we don't have CONFIG_ARM_PATCH_PHYS_VIRT defined then we get:

arch/arm/kernel/module.c:272: warning: ?find_mod_section? defined but not used

8<------

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 74e25ab..ba65805 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -269,6 +269,7 @@ struct mod_unwind_map {
 	const Elf_Shdr *txt_sec;
 };
 
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
 static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
 	const Elf_Shdr *sechdrs, const char *name)
 {
@@ -281,6 +282,7 @@ static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
 
 	return NULL;
 }
+#endif
 
 extern void fixup_pv_table(const void *, unsigned long);
 
