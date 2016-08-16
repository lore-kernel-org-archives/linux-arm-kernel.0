From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Aug 2016 16:39:51 +0200
Subject: [PATCH] arm: module-plts: improve algorithm for counting PLTs
In-Reply-To: <1471352117-19113-1-git-send-email-neidhard.kim@lge.com>
References: <1471352117-19113-1-git-send-email-neidhard.kim@lge.com>
Message-ID: <CAKv+Gu_x0KWbtgy6+arEPRQZ=G1Ma7dvX=p07K2UR4aZj=jnYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Dave)

Hello Jongsung,

On 16 August 2016 at 14:55, Jongsung Kim <neidhard.kim@lge.com> wrote:
> Current count_plts() uses O(n^2) algorithm for counting distinct
> PLTs. It's good and fast enough when handling relatively small
> number of relocs. But the time for counting grows so fast by its
> nature. A Cortex-A53 operating at 1GHz takes about 10 seconds to
> count 4,819 distinct PLTs from 257,394 relocs. It can be serious
> for embedded systems those usually want to boot fast.
>

If I take the largest module I can find in my multi_v7_defconfig build, I get

$ readelf -r ./net/mac80211/mac80211.ko |wc -l
7984
$ readelf -r ./net/mac80211/mac80211.ko |grep -E JUMP\|CALL |wc -l
3675

Where does the figure 257,394 originate from?

> This patch introduces faster O(n) algorithm for counting unique
> PLTs using hash-table. The following table compares the time (in
> usecs) for counting distinct PLTs from relocs (using Cortex-A53
> @1GHz mentioned above):
>
>         --------------------------------------
>           relocs    PLTs      O(n^2)     O(n)
>         --------------------------------------
>               15       1           1       27
>               30       6           1       29
>               60      14           5       31
>              120      26          15       32
>              240      47          51       36
>              480      88         216       50
>              960     125         560       67
>            1,920     191       1,476      106
>            3,840     253       5,731      179
>            7,680     431      21,226      347
>           15,360     637      88,211      698
>           30,720   1,291     331,626    1,369
>           61,440   1,902     803,964    2,917
>          122,880   3,320   4,129,439    6,428
>          245,760   4,646   8,837,064   13,024
>         ======================================
>
> The time increases near-linearly, and the time to handling same
> 257,394 relocs is reduced to < 20msec from 10 seconds. (< 0.2%)
>
> With very small number of PLTs, O(n^2) counting is still faster
> than O(n) counting, because O(n) counting needs additional O(n)
> memory space allocation. In these cases, however, the difference
> looks very short and negligible.
>
> This patch does not replaces original O(n^2) counting algorithm
> with introduced O(n) algorithm, to use it as fall-back algorithm
> when required memory allocation fails.
>

I think there are other optimizations that are much simpler that we
could look into first. For instance, PLT entries can only be used for
call and jump relocations that refer to SHN_UNDEF symbols: this is a
rather fundamental restriction, since the PLT itself must be in range
for these call and jump instructions. If the module grows so big that
PLT entries are required for jumps inside the same module, we can no
longer guarantee that the PLT can be located close enough.

I quickly tested this with the module above:
Before:

# insmod cfg80211.ko
[   45.981587] Allocating 238 PLT entries for 3632 external
jumps/calls (out of 3632 relocations)
[   45.981967] Allocating 4 PLT entries for 10 external jumps/calls
(out of 10 relocations)
[   45.982386] Allocating 19 PLT entries for 37 external jumps/calls
(out of 37 relocations)
[   45.982895] Allocating 7 PLT entries for 11 external jumps/calls
(out of 11 relocations)
[   45.983409] Allocating 4 PLT entries for 16 external jumps/calls
(out of 16 relocations)

# insmod mac80211.ko
[   52.028863] Allocating 545 PLT entries for 5762 external
jumps/calls (out of 5762 relocations)
[   52.029207] Allocating 8 PLT entries for 16 external jumps/calls
(out of 16 relocations)
[   52.029431] Allocating 4 PLT entries for 4 external jumps/calls
(out of 4 relocations)
[   52.029676] Allocating 39 PLT entries for 107 external jumps/calls
(out of 107 relocations)

(i.e., without the optimization, all jumps and calls are identified as
potentially external)

After:

# insmod cfg80211.ko
[   47.685451] Allocating 111 PLT entries for 2097 external
jumps/calls (out of 3632 relocations)
[   47.686016] Allocating 3 PLT entries for 5 external jumps/calls
(out of 10 relocations)
[   47.686440] Allocating 11 PLT entries for 11 external jumps/calls
(out of 37 relocations)
[   47.686837] Allocating 4 PLT entries for 4 external jumps/calls
(out of 11 relocations)
[   47.687098] Allocating 3 PLT entries for 13 external jumps/calls
(out of 16 relocations)

# insmod mac80211.ko
[   50.410922] Allocating 231 PLT entries for 2857 external
jumps/calls (out of 5762 relocations)
[   50.411277] Allocating 2 PLT entries for 2 external jumps/calls
(out of 16 relocations)
[   50.411562] Allocating 1 PLT entries for 1 external jumps/calls
(out of 4 relocations)
[   50.411918] Allocating 20 PLT entries for 43 external jumps/calls
(out of 107 relocations)

Another thing to note is that the .init section hardly deserves its
own PLT. In the example above the 3rd resp 2nd line refers to
.init.text, and there is really no point in putting 11 resp 2 PLT
entries (or 88 resp 16 bytes) into a separate section just so that we
can release it again after init. So the next optimization is to simply
merge them.

I will send out the patches separately, please tell me what you think.

Thanks,
Ard.


> Reported-by: Chanho Min <chanho.min@lge.com>
> Suggested-by: Youngho Shin <youngho.shin@lge.com>
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
> Reviewed-by: Namhyung Kim <namhyung.kim@lge.com>
> ---
>  arch/arm/kernel/module-plts.c | 111 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index 0c7efc3..dae7459 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -9,6 +9,8 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/vmalloc.h>
>
>  #include <asm/cache.h>
>  #include <asm/opcodes.h>
> @@ -25,11 +27,26 @@
>                                                     (PLT_ENT_STRIDE - 8))
>  #endif
>
> +#define PLT_HASH_SHIFT         10
> +#define PLT_HASH_SIZE          (1 << PLT_HASH_SHIFT)
> +#define PLT_HASH_MASK          (PLT_HASH_SIZE - 1)
> +
>  struct plt_entries {
>         u32     ldr[PLT_ENT_COUNT];
>         u32     lit[PLT_ENT_COUNT];
>  };
>
> +struct plt_hash_entry {
> +       struct plt_hash_entry *next;
> +       Elf32_Rel const *plt;
> +};
> +
> +struct plt_hash_table {
> +       struct plt_hash_entry *table[PLT_HASH_SIZE];
> +       size_t used;
> +       struct plt_hash_entry entry[0];
> +};
> +
>  static bool in_init(const struct module *mod, u32 addr)
>  {
>         return addr - (u32)mod->init_layout.base < mod->init_layout.size;
> @@ -100,7 +117,7 @@ static int duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num,
>  }
>
>  /* Count how many PLT entries we may need */
> -static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
> +static unsigned int _count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
>  {
>         unsigned int ret = 0;
>         int i;
> @@ -129,6 +146,98 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
>         return ret;
>  }
>
> +static unsigned int hash_plt(Elf32_Rel const *plt, Elf32_Addr base, u32 mask)
> +{
> +       u32 const *loc = (u32 *)(base + plt->r_offset);
> +       u32 hash = (plt->r_info >> 8) ^ (*loc & mask);
> +       return hash & PLT_HASH_MASK;
> +}
> +
> +static bool
> +same_plts(Elf32_Rel const *a, Elf32_Rel const *b, Elf32_Addr base, u32 mask)
> +{
> +       u32 const *loc1;
> +       u32 const *loc2;
> +
> +       if (a->r_info != b->r_info)
> +               return false;
> +
> +       loc1 = (u32 *)(base + a->r_offset);
> +       loc2 = (u32 *)(base + b->r_offset);
> +
> +       return ((*loc1 ^ *loc2) & mask) == 0;
> +}
> +
> +static int hash_insert_plt(struct plt_hash_table *table, Elf32_Rel const *plt,
> +                          Elf32_Addr base, u32 mask)
> +{
> +       unsigned int hash = hash_plt(plt, base, mask);
> +       struct plt_hash_entry *entry;
> +
> +       for (entry = table->table[hash]; entry; entry = entry->next)
> +               if (same_plts(entry->plt, plt, base, mask))
> +                       return 0;
> +
> +       entry = &table->entry[table->used++];
> +       entry->next = table->table[hash];
> +       entry->plt = plt;
> +       table->table[hash] = entry;
> +
> +       return 1;
> +}
> +
> +static size_t count_plts(Elf32_Addr base, Elf32_Rel const *rel, int num)
> +{
> +       struct plt_hash_table *table;
> +       size_t plts;
> +       u32 mask;
> +       int i;
> +
> +       /* count PLTs first to optimize memory usage */
> +       for (plts = i = 0; i < num; i++) {
> +               switch (ELF32_R_TYPE(rel[i].r_info)) {
> +               case R_ARM_CALL:
> +               case R_ARM_PC24:
> +               case R_ARM_JUMP24:
> +#ifdef CONFIG_THUMB2_KERNEL
> +               case R_ARM_THM_CALL:
> +               case R_ARM_THM_JUMP24:
> +#endif
> +                       plts++;
> +                       break;
> +               }
> +       }
> +
> +       table = vzalloc(sizeof(struct plt_hash_table) +
> +                       sizeof(struct plt_hash_entry) * plts);
> +       if (!table) {
> +               /* fall-back to O(n^2) counting on memory shortage */
> +               return _count_plts(base, rel, num);
> +       }
> +
> +       for (plts = i = 0; i < num; i++) {
> +               switch (ELF32_R_TYPE(rel[i].r_info)) {
> +               case R_ARM_CALL:
> +               case R_ARM_PC24:
> +               case R_ARM_JUMP24:
> +                       mask = __opcode_to_mem_arm(0x00ffffff);
> +                       plts += hash_insert_plt(table, &rel[i], base, mask);
> +                       break;
> +#ifdef CONFIG_THUMB2_KERNEL
> +               case R_ARM_THM_CALL:
> +               case R_ARM_THM_JUMP24:
> +                       mask = __opcode_to_mem_thumb32(0x07ff2fff);
> +                       plts += hash_insert_plt(table, &rel[i], base, mask);
> +                       break;
> +#endif
> +               }
> +       }
> +
> +       vfree(table);
> +
> +       return plts;
> +}
> +
>  int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                               char *secstrings, struct module *mod)
>  {
> --
> 2.7.4
>
