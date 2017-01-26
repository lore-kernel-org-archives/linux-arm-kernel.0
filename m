From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Thu, 26 Jan 2017 10:51:06 +0900
Subject: [PATCH 2/2 v2] perf tools: Enable bpf prologue for arm64
In-Reply-To: <20170125072311.22922-1-hekuang@huawei.com>
References: <20170124190908.GG10340@kernel.org>
 <20170125072311.22922-1-hekuang@huawei.com>
Message-ID: <20170126105106.ff80f087e8c0996868bc659f@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jan 2017 07:23:11 +0000
He Kuang <hekuang@huawei.com> wrote:

> Since HAVE_KPROBES can be enabled in arm64, this patch introduces
> regs_query_register_offset() to convert register name to offset for
> arm64, so the BPF prologue feature is ready to use.
> 
> This patch also changes the 'dwarfnum' to 'offset' in register table,
> so the related functions are consistent with x86.
> 
> Signed-off-by: He Kuang <hekuang@huawei.com>
> ---
>  tools/perf/arch/arm64/Makefile          |   1 +
>  tools/perf/arch/arm64/util/dwarf-regs.c | 124 ++++++++++++++++++--------------
>  2 files changed, 72 insertions(+), 53 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index 18b1351..eebe1ec 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -2,3 +2,4 @@ ifndef NO_DWARF
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_JITDUMP := 1
> +PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
> index d49efeb..5ec62a4 100644
> --- a/tools/perf/arch/arm64/util/dwarf-regs.c
> +++ b/tools/perf/arch/arm64/util/dwarf-regs.c
> @@ -9,72 +9,90 @@
>   */
>  
>  #include <stddef.h>
> +#include <linux/ptrace.h> /* for struct user_pt_regs */
> +#include <errno.h> /* for EINVAL */
> +#include <string.h> /* for strcmp */
> +#include <linux/ptrace.h> /* for struct user_pt_regs */

Here is a duplicated line.

Other parts look good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
except for the above line.

Thank you!

>  #include <dwarf-regs.h>
>  
> -struct pt_regs_dwarfnum {
> +struct pt_regs_offset {
>  	const char *name;
> -	unsigned int dwarfnum;
> +	int offset;
>  };
>  
> -#define STR(s) #s
> -#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
> -#define GPR_DWARFNUM_NAME(num) \
> -	{.name = STR(%x##num), .dwarfnum = num}
> -#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
> -
>  /*
>   * Reference:
>   * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0057b/IHI0057B_aadwarf64.pdf
>   */
> -static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
> -	GPR_DWARFNUM_NAME(0),
> -	GPR_DWARFNUM_NAME(1),
> -	GPR_DWARFNUM_NAME(2),
> -	GPR_DWARFNUM_NAME(3),
> -	GPR_DWARFNUM_NAME(4),
> -	GPR_DWARFNUM_NAME(5),
> -	GPR_DWARFNUM_NAME(6),
> -	GPR_DWARFNUM_NAME(7),
> -	GPR_DWARFNUM_NAME(8),
> -	GPR_DWARFNUM_NAME(9),
> -	GPR_DWARFNUM_NAME(10),
> -	GPR_DWARFNUM_NAME(11),
> -	GPR_DWARFNUM_NAME(12),
> -	GPR_DWARFNUM_NAME(13),
> -	GPR_DWARFNUM_NAME(14),
> -	GPR_DWARFNUM_NAME(15),
> -	GPR_DWARFNUM_NAME(16),
> -	GPR_DWARFNUM_NAME(17),
> -	GPR_DWARFNUM_NAME(18),
> -	GPR_DWARFNUM_NAME(19),
> -	GPR_DWARFNUM_NAME(20),
> -	GPR_DWARFNUM_NAME(21),
> -	GPR_DWARFNUM_NAME(22),
> -	GPR_DWARFNUM_NAME(23),
> -	GPR_DWARFNUM_NAME(24),
> -	GPR_DWARFNUM_NAME(25),
> -	GPR_DWARFNUM_NAME(26),
> -	GPR_DWARFNUM_NAME(27),
> -	GPR_DWARFNUM_NAME(28),
> -	GPR_DWARFNUM_NAME(29),
> -	REG_DWARFNUM_NAME("%lr", 30),
> -	REG_DWARFNUM_NAME("%sp", 31),
> -	REG_DWARFNUM_END,
> +#define REG_OFFSET_NAME(r, num) {.name = "%" #r,			\
> +			.offset = offsetof(struct user_pt_regs, regs[num])}
> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
> +#define GPR_OFFSET_NAME(r) \
> +	{.name = "%x" #r, .offset = offsetof(struct user_pt_regs, regs[r])}
> +
> +/* This table is for reverse searching for the offset or register
> + * names in aarch64_regstr_tbl[].
> + */
> +static const struct pt_regs_offset regoffset_table[] = {
> +	GPR_OFFSET_NAME(0),
> +	GPR_OFFSET_NAME(1),
> +	GPR_OFFSET_NAME(2),
> +	GPR_OFFSET_NAME(3),
> +	GPR_OFFSET_NAME(4),
> +	GPR_OFFSET_NAME(5),
> +	GPR_OFFSET_NAME(6),
> +	GPR_OFFSET_NAME(7),
> +	GPR_OFFSET_NAME(8),
> +	GPR_OFFSET_NAME(9),
> +	GPR_OFFSET_NAME(10),
> +	GPR_OFFSET_NAME(11),
> +	GPR_OFFSET_NAME(12),
> +	GPR_OFFSET_NAME(13),
> +	GPR_OFFSET_NAME(14),
> +	GPR_OFFSET_NAME(15),
> +	GPR_OFFSET_NAME(16),
> +	GPR_OFFSET_NAME(17),
> +	GPR_OFFSET_NAME(18),
> +	GPR_OFFSET_NAME(19),
> +	GPR_OFFSET_NAME(20),
> +	GPR_OFFSET_NAME(21),
> +	GPR_OFFSET_NAME(22),
> +	GPR_OFFSET_NAME(23),
> +	GPR_OFFSET_NAME(24),
> +	GPR_OFFSET_NAME(25),
> +	GPR_OFFSET_NAME(26),
> +	GPR_OFFSET_NAME(27),
> +	GPR_OFFSET_NAME(28),
> +	GPR_OFFSET_NAME(29),
> +	REG_OFFSET_NAME(lr, 30),
> +	REG_OFFSET_NAME(sp, 31),
> +	REG_OFFSET_END,
>  };
>  
> +/* Minus 1 for the ending REG_OFFSET_END */
> +#define ARCH_MAX_REGS ((sizeof(regoffset_table) /		\
> +			sizeof(regoffset_table[0])) - 1)
> +
> +/* Return architecture dependent register string (for kprobe-tracer) */
> +const char *get_arch_regstr(unsigned int n)
> +{
> +	return (n < ARCH_MAX_REGS) ? regoffset_table[n].name : NULL;
> +}
> +
> +/* Reuse code from arch/arm64/kernel/ptrace.c */
>  /**
> - * get_arch_regstr() - lookup register name from it's DWARF register number
> - * @n:	the DWARF register number
> + * regs_query_register_offset() - query register offset from its name
> + * @name:	the name of a register
>   *
> - * get_arch_regstr() returns the name of the register in struct
> - * regdwarfnum_table from it's DWARF register number. If the register is not
> - * found in the table, this returns NULL;
> + * regs_query_register_offset() returns the offset of a register in struct
> + * user_pt_regs from its name. If the name is invalid, this returns -EINVAL;
>   */
> -const char *get_arch_regstr(unsigned int n)
> +int regs_query_register_offset(const char *name)
>  {
> -	const struct pt_regs_dwarfnum *roff;
> -	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
> -		if (roff->dwarfnum == n)
> -			return roff->name;
> -	return NULL;
> +	const struct pt_regs_offset *roff;
> +
> +	for (roff = regoffset_table; roff->name != NULL; roff++)
> +		if (!strcmp(roff->name, name))
> +			return roff->offset;
> +	return -EINVAL;
>  }
> -- 
> 1.8.5.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
