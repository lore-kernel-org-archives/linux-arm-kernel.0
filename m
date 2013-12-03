From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Dec 2013 10:16:37 +0000
Subject: [PATCH v5 2/4] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <1385793148-28979-3-git-send-email-vijay.kilari@gmail.com>
References: <1385793148-28979-1-git-send-email-vijay.kilari@gmail.com>
 <1385793148-28979-3-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20131203101637.GA7552@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I think that there's a slight problem with this on BE systems.

On Sat, Nov 30, 2013 at 06:32:26AM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>
> Add KGDB debug support for kernel debugging.
> With this patch, basic KGDB debugging is possible.GDB register
> layout is updated and GDB tool can establish connection with
> target and can set/clear breakpoints.
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/debug-monitors.h |   47 +++++
>  arch/arm64/include/asm/kgdb.h           |   86 +++++++++
>  arch/arm64/kernel/Makefile              |    1 +
>  arch/arm64/kernel/kgdb.c                |  289 +++++++++++++++++++++++++++++++
>  4 files changed, 423 insertions(+)

[...]

> +struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> +       { "x0", 8, offsetof(struct pt_regs, regs[0])},
> +       { "x1", 8, offsetof(struct pt_regs, regs[1])},
> +       { "x2", 8, offsetof(struct pt_regs, regs[2])},
> +       { "x3", 8, offsetof(struct pt_regs, regs[3])},
> +       { "x4", 8, offsetof(struct pt_regs, regs[4])},
> +       { "x5", 8, offsetof(struct pt_regs, regs[5])},
> +       { "x6", 8, offsetof(struct pt_regs, regs[6])},
> +       { "x7", 8, offsetof(struct pt_regs, regs[7])},
> +       { "x8", 8, offsetof(struct pt_regs, regs[8])},
> +       { "x9", 8, offsetof(struct pt_regs, regs[9])},
> +       { "x10", 8, offsetof(struct pt_regs, regs[10])},
> +       { "x11", 8, offsetof(struct pt_regs, regs[11])},
> +       { "x12", 8, offsetof(struct pt_regs, regs[12])},
> +       { "x13", 8, offsetof(struct pt_regs, regs[13])},
> +       { "x14", 8, offsetof(struct pt_regs, regs[14])},
> +       { "x15", 8, offsetof(struct pt_regs, regs[15])},
> +       { "x16", 8, offsetof(struct pt_regs, regs[16])},
> +       { "x17", 8, offsetof(struct pt_regs, regs[17])},
> +       { "x18", 8, offsetof(struct pt_regs, regs[18])},
> +       { "x19", 8, offsetof(struct pt_regs, regs[19])},
> +       { "x20", 8, offsetof(struct pt_regs, regs[20])},
> +       { "x21", 8, offsetof(struct pt_regs, regs[21])},
> +       { "x22", 8, offsetof(struct pt_regs, regs[22])},
> +       { "x23", 8, offsetof(struct pt_regs, regs[23])},
> +       { "x24", 8, offsetof(struct pt_regs, regs[24])},
> +       { "x25", 8, offsetof(struct pt_regs, regs[25])},
> +       { "x26", 8, offsetof(struct pt_regs, regs[26])},
> +       { "x27", 8, offsetof(struct pt_regs, regs[27])},
> +       { "x28", 8, offsetof(struct pt_regs, regs[28])},
> +       { "x29", 8, offsetof(struct pt_regs, regs[29])},
> +       { "x30", 8, offsetof(struct pt_regs, regs[30])},
> +       { "sp", 8, offsetof(struct pt_regs, sp)},
> +       { "pc", 8, offsetof(struct pt_regs, pc)},
> +       { "pstate", 4, offsetof(struct pt_regs, pstate)},

As pt_regs::pstate is a u64, we're only describing half of the field
here (to match GDB's expectations). While we happen to get the half
we're interested in on an LE system, on a BE system this will point at
the zeroed half.

[...]

> +char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
> +{
> +       if (regno >= DBG_MAX_REG_NUM || regno < 0)
> +               return NULL;
> +
> +       if (dbg_reg_def[regno].offset != -1)
> +               memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
> +                      dbg_reg_def[regno].size);

So here we'll read zeroes rather than the bits we're interested in.

> +       else
> +               memset(mem, 0, dbg_reg_def[regno].size);
> +       return dbg_reg_def[regno].name;
> +}
> +
> +int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
> +{
> +       if (regno >= DBG_MAX_REG_NUM || regno < 0)
> +               return -EINVAL;
> +
> +       if (dbg_reg_def[regno].offset != -1)
> +               memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
> +                      dbg_reg_def[regno].size);

And here we'll write to bits which should be zero, not the bits we're
interested in.

[...]

> +static struct notifier_block kgdb_notifier = {
> +       .notifier_call  = kgdb_notify,
> +       .priority       = -INT_MAX,

On an unrelated note, is there a reason this isn't INT_MIN? This is
one-off.

Thanks,
Mark.
