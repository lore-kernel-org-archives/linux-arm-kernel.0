From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Oct 2018 15:28:34 +0000
Subject: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
In-Reply-To: <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
Message-ID: <20181029152834.GA16289@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jessica,

On Fri, Oct 26, 2018 at 07:25:01PM +0200, Jessica Yu wrote:
> The arm64 module loader keeps a pointer into info->sechdrs to keep track
> of section header information for .plt section(s). A pointer to the
> relevent section header (struct elf64_shdr) in info->sechdrs is stored
> in mod->arch.{init,core}.plt. This pointer may be accessed while
> applying relocations in apply_relocate_add() for example. And unlike
> normal modules, livepatch modules can call apply_relocate_add() after
> module load. But the info struct (and therefore info->sechdrs) gets
> freed at the end of load_module() and so mod->arch.{init,core}.plt
> becomes an invalid pointer after the module is done loading.
> 
> Luckily, livepatch modules already keep a copy of Elf section header
> information in mod->klp_info. So make sure livepatch modules on arm64
> have access to the section headers in klp_info and set
> mod->arch.{init,core}.plt to the appropriate section header in
> mod->klp_info so that they can call apply_relocate_add() even after
> module load.
> 
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
> 
> v2:
>  - fix missing free_module_elf() in error path
>  - move copy_module_elf() and module_finalize() out of post_relocation()
>    to make error handling more clear
>  - add braces to if-else block in arm64 module_frob_arch_sections()
> 
> arch/arm64/include/asm/module.h |  1 +
> arch/arm64/kernel/module-plts.c | 17 ++++++++++++-----
> arch/arm64/kernel/module.c      | 10 ++++++++++
> kernel/module.c                 | 29 +++++++++++++++--------------
> 4 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index fef773c94e9d..ac9b97f9ae5e 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -25,6 +25,7 @@ struct mod_plt_sec {
> 	struct elf64_shdr	*plt;
> 	int			plt_num_entries;
> 	int			plt_max_entries;
> +	int			plt_shndx;
> };

Does this mean we can drop the plt pointer from this struct altogether, and
simply offset into the section headers when applying the relocations?

Cheers,

Will
