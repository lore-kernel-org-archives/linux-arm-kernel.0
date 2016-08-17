From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Aug 2016 12:06:53 +0100
Subject: [PATCH 0/2] ARM: kernel: module PLT optimizations
In-Reply-To: <1471362706-29859-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471362706-29859-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160817110643.GA23341@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 05:51:44PM +0200, Ard Biesheuvel wrote:
> As reported by Jongsung, the O(n^2) search in the PLT allocation code may
> disproportionately affect module load time for modules with a larger number
> of relocations.
> 
> Since the existing routines rather naively take branch instructions into
> account that are internal to the module, we can improve the situation
> significantly by checking the symbol section index first, and disregarding
> symbols that are defined in the same module.
> 
> Patch #1 merge the core and init PLTs, since the latter is virtually empty
> anyway.
> 
> Patch #2 implements the optimization to only take SHN_UNDEF symbols into
> account.

Could we not sort the relocs on target address at the modpost stage?

The order of reloc entries in ELF is not significant, so we could sort
them offline before the module loader sees them.

The kernel code then just needs to merge adjacent relocs with the same
target to each PLT.  This won't be optimal for all cases, but it's
simple.


Alternatively, we could do the reloc->PLT grouping work at modpost time,
spitting out the result some extra ELF section which the module loader
can consume.  This may be a better approach if we want to be able to
allocate a single PLT to relocs in multiple sections.

Either approach keeps the module loader logic simple and O(n), and
should be easily reused across arches (if someone needs that).

[...]

Cheers
---Dave

> 
> I quickly tested this with the module above:
> Before:
> 
> # insmod cfg80211.ko
> [   45.981587] Allocating 238 PLT entries for 3632 external
> jumps/calls (out of 3632 relocations)
> [   45.981967] Allocating 4 PLT entries for 10 external jumps/calls
> (out of 10 relocations)
> [   45.982386] Allocating 19 PLT entries for 37 external jumps/calls
> (out of 37 relocations)
> [   45.982895] Allocating 7 PLT entries for 11 external jumps/calls
> (out of 11 relocations)
> [   45.983409] Allocating 4 PLT entries for 16 external jumps/calls
> (out of 16 relocations)
> 
> # insmod mac80211.ko
> [   52.028863] Allocating 545 PLT entries for 5762 external
> jumps/calls (out of 5762 relocations)
> [   52.029207] Allocating 8 PLT entries for 16 external jumps/calls
> (out of 16 relocations)
> [   52.029431] Allocating 4 PLT entries for 4 external jumps/calls
> (out of 4 relocations)
> [   52.029676] Allocating 39 PLT entries for 107 external jumps/calls
> (out of 107 relocations)
> 
> (i.e., without the optimization, all jumps and calls are identified as
> potentially external)
> 
> After:
> 
> # insmod cfg80211.ko
> [   47.685451] Allocating 111 PLT entries for 2097 external
> jumps/calls (out of 3632 relocations)
> [   47.686016] Allocating 3 PLT entries for 5 external jumps/calls
> (out of 10 relocations)
> [   47.686440] Allocating 11 PLT entries for 11 external jumps/calls
> (out of 37 relocations)
> [   47.686837] Allocating 4 PLT entries for 4 external jumps/calls
> (out of 11 relocations)
> [   47.687098] Allocating 3 PLT entries for 13 external jumps/calls
> (out of 16 relocations)
> 
> # insmod mac80211.ko
> [   50.410922] Allocating 231 PLT entries for 2857 external
> jumps/calls (out of 5762 relocations)
> [   50.411277] Allocating 2 PLT entries for 2 external jumps/calls
> (out of 16 relocations)
> [   50.411562] Allocating 1 PLT entries for 1 external jumps/calls
> (out of 4 relocations)
> [   50.411918] Allocating 20 PLT entries for 43 external jumps/calls
> (out of 107 relocations)
> 
> Another thing to note is that the .init section hardly deserves its
> own PLT. In the example above the 3rd resp 2nd line refers to
> .init.text, and there is really no point in putting 11 resp 2 PLT
> entries (or 88 resp 16 bytes) into a separate section just so that we
> can release it again after init. So the next optimization is to simply
> merge them.
> 
> I will send out the patches separately, please tell me what you think.
> 
> Thanks,
> Ard.
> 
> 
> > Reported-by: Chanho Min <chanho.min@lge.com>
> > Suggested-by: Youngho Shin <youngho.shin@lge.com>
> > Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
> > Reviewed-by: Namhyung Kim <namhyung.kim@lge.com>
> > ---
> >  arch/arm/kernel/module-plts.c | 111 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 110 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> > index 0c7efc3..dae7459 100644
> > --- a/arch/arm/kernel/module-plts.c
> > +++ b/arch/arm/kernel/module-plts.c
> > @@ -9,6 +9,8 @@
> >  #include <linux/elf.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/vmalloc.h>
> >
> >  #include <asm/cache.h>
> >  #include <asm/opcodes.h>
> > @@ -25,11 +27,26 @@
> >                                                     (PLT_ENT_STRIDE - 8))
> >  #endif
> >
> > +#define PLT_HASH_SHIFT         10
> > +#define PLT_HASH_SIZE          (1 << PLT_HASH_SHIFT)
> > +#define PLT_HASH_MASK          (PLT_HASH_SIZE - 1)
> > +
> >  struct plt_entries {
> >         u32     ldr[PLT_ENT_COUNT];
> >         u32     lit[PLT_ENT_COUNT];
> >  };
> >
> > +struct plt_hash_entry {
> > +       struct plt_hash_entry *next;
> > +       Elf32_Rel const *plt;
> > +};
> > +
> > +struct plt_hash_table {
> > +       struct plt_hash_entry *table[PLT_HASH_SIZE];
> > +       size_t used;
> > +       struct plt_hash_entry entry[0];
> > +};
> > +
> >  static bool in_init(const struct module *mod, u32 addr)
> >  {
> >         return addr - (u32)mod->init_layout.base < mod->init_layout.size;
> > @@ -100,7 +117,7 @@ static int duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num,
> >  }
> >
> >  /* Count how many PLT entries we may need */
> > -static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
> > +static unsigned int _count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
> >  {
> >         unsigned int ret = 0;
> >         int i;
> > @@ -129,6 +146,98 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
> >         return ret;
> >  }
> >
> > +static unsigned int hash_plt(Elf32_Rel const *plt, Elf32_Addr base, u32 mask)
> > +{
> > +       u32 const *loc = (u32 *)(base + plt->r_offset);
> > +       u32 hash = (plt->r_info >> 8) ^ (*loc & mask);
> > +       return hash & PLT_HASH_MASK;
> > +}
> > +
> > +static bool
> > +same_plts(Elf32_Rel const *a, Elf32_Rel const *b, Elf32_Addr base, u32 mask)
> > +{
> > +       u32 const *loc1;
> > +       u32 const *loc2;
> > +
> > +       if (a->r_info != b->r_info)
> > +               return false;
> > +
> > +       loc1 = (u32 *)(base + a->r_offset);
> > +       loc2 = (u32 *)(base + b->r_offset);
> > +
> > +       return ((*loc1 ^ *loc2) & mask) == 0;
> > +}
> > +
> > +static int hash_insert_plt(struct plt_hash_table *table, Elf32_Rel const *plt,
> > +                          Elf32_Addr base, u32 mask)
> > +{
> > +       unsigned int hash = hash_plt(plt, base, mask);
> > +       struct plt_hash_entry *entry;
> > +
> > +       for (entry = table->table[hash]; entry; entry = entry->next)
> > +               if (same_plts(entry->plt, plt, base, mask))
> > +                       return 0;
> > +
> > +       entry = &table->entry[table->used++];
> > +       entry->next = table->table[hash];
> > +       entry->plt = plt;
> > +       table->table[hash] = entry;
> > +
> > +       return 1;
> > +}
> > +
> > +static size_t count_plts(Elf32_Addr base, Elf32_Rel const *rel, int num)
> > +{
> > +       struct plt_hash_table *table;
> > +       size_t plts;
> > +       u32 mask;
> > +       int i;
> > +
> > +       /* count PLTs first to optimize memory usage */
> > +       for (plts = i = 0; i < num; i++) {
> > +               switch (ELF32_R_TYPE(rel[i].r_info)) {
> > +               case R_ARM_CALL:
> > +               case R_ARM_PC24:
> > +               case R_ARM_JUMP24:
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +               case R_ARM_THM_CALL:
> > +               case R_ARM_THM_JUMP24:
> > +#endif
> > +                       plts++;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       table = vzalloc(sizeof(struct plt_hash_table) +
> > +                       sizeof(struct plt_hash_entry) * plts);
> > +       if (!table) {
> > +               /* fall-back to O(n^2) counting on memory shortage */
> > +               return _count_plts(base, rel, num);
> > +       }
> > +
> > +       for (plts = i = 0; i < num; i++) {
> > +               switch (ELF32_R_TYPE(rel[i].r_info)) {
> > +               case R_ARM_CALL:
> > +               case R_ARM_PC24:
> > +               case R_ARM_JUMP24:
> > +                       mask = __opcode_to_mem_arm(0x00ffffff);
> > +                       plts += hash_insert_plt(table, &rel[i], base, mask);
> > +                       break;
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +               case R_ARM_THM_CALL:
> > +               case R_ARM_THM_JUMP24:
> > +                       mask = __opcode_to_mem_thumb32(0x07ff2fff);
> > +                       plts += hash_insert_plt(table, &rel[i], base, mask);
> > +                       break;
> > +#endif
> > +               }
> > +       }
> > +
> > +       vfree(table);
> > +
> > +       return plts;
> > +}
> > +
> >  int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >                               char *secstrings, struct module *mod)
> >  {
> > --
> > 2.7.4
> >
> 
