From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 7 Feb 2017 09:54:51 +0900
Subject: [PATCH v2 1/3] perf tools: Use offset instead of dwarfnum in
 register table.
In-Reply-To: <20170206130229.GI19939@arm.com>
References: <20170203110607.97529-1-hekuang@huawei.com>
 <20170203130026.GF11585@arm.com> <589598D8.8050304@huawei.com>
 <20170206130229.GI19939@arm.com>
Message-ID: <20170207095451.10ac50a90de0fdac529a2522@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Feb 2017 13:02:29 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Sat, Feb 04, 2017 at 05:03:20PM +0800, Hekuang wrote:
> > hi
> > 
> > ? 2017/2/3 21:00, Will Deacon ??:
> > >On Fri, Feb 03, 2017 at 11:06:05AM +0000, He Kuang wrote:
> > >>This patch changes the 'dwarfnum' to 'offset' in register table, so
> > >>the index of array becomes the dwarfnum (the index of each register
> > >>defined by DWARF) and the "offset" member means the byte-offset of the
> > >>register in (user_)pt_regs. This change makes the code consistent with
> > >>x86.
> > >>
> > >>Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > >>Signed-off-by: He Kuang <hekuang@huawei.com>
> > >>---
> > >>  tools/perf/arch/arm64/util/dwarf-regs.c | 107 ++++++++++++++++----------------
> > >>  1 file changed, 52 insertions(+), 55 deletions(-)
> > >Thanks for splitting this up. Comment below.
> > >
> > >>diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
> > >>index d49efeb..090f36b 100644
> > >>--- a/tools/perf/arch/arm64/util/dwarf-regs.c
> > >>+++ b/tools/perf/arch/arm64/util/dwarf-regs.c
> > >>@@ -9,72 +9,69 @@
> > >>   */
> > >>  #include <stddef.h>
> > >>+#include <linux/ptrace.h> /* for struct user_pt_regs */
> > >>  #include <dwarf-regs.h>
> > >>-struct pt_regs_dwarfnum {
> > >>+struct pt_regs_offset {
> > >>  	const char *name;
> > >>-	unsigned int dwarfnum;
> > >>+	int offset;
> > >>  };
> > >>-#define STR(s) #s
> > >>-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
> > >>-#define GPR_DWARFNUM_NAME(num) \
> > >>-	{.name = STR(%x##num), .dwarfnum = num}
> > >>-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
> > >>-
> > >>  /*
> > >>   * Reference:
> > >>   * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0057b/IHI0057B_aadwarf64.pdf
> > >>   */
> > >>-static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
> > >>-	GPR_DWARFNUM_NAME(0),
> > >>-	GPR_DWARFNUM_NAME(1),
> > >>-	GPR_DWARFNUM_NAME(2),
> > >>-	GPR_DWARFNUM_NAME(3),
> > >>-	GPR_DWARFNUM_NAME(4),
> > >>-	GPR_DWARFNUM_NAME(5),
> > >>-	GPR_DWARFNUM_NAME(6),
> > >>-	GPR_DWARFNUM_NAME(7),
> > >>-	GPR_DWARFNUM_NAME(8),
> > >>-	GPR_DWARFNUM_NAME(9),
> > >>-	GPR_DWARFNUM_NAME(10),
> > >>-	GPR_DWARFNUM_NAME(11),
> > >>-	GPR_DWARFNUM_NAME(12),
> > >>-	GPR_DWARFNUM_NAME(13),
> > >>-	GPR_DWARFNUM_NAME(14),
> > >>-	GPR_DWARFNUM_NAME(15),
> > >>-	GPR_DWARFNUM_NAME(16),
> > >>-	GPR_DWARFNUM_NAME(17),
> > >>-	GPR_DWARFNUM_NAME(18),
> > >>-	GPR_DWARFNUM_NAME(19),
> > >>-	GPR_DWARFNUM_NAME(20),
> > >>-	GPR_DWARFNUM_NAME(21),
> > >>-	GPR_DWARFNUM_NAME(22),
> > >>-	GPR_DWARFNUM_NAME(23),
> > >>-	GPR_DWARFNUM_NAME(24),
> > >>-	GPR_DWARFNUM_NAME(25),
> > >>-	GPR_DWARFNUM_NAME(26),
> > >>-	GPR_DWARFNUM_NAME(27),
> > >>-	GPR_DWARFNUM_NAME(28),
> > >>-	GPR_DWARFNUM_NAME(29),
> > >>-	REG_DWARFNUM_NAME("%lr", 30),
> > >>-	REG_DWARFNUM_NAME("%sp", 31),
> > >>-	REG_DWARFNUM_END,
> > >>-};
> > >>+#define REG_OFFSET_NAME(r, num) {.name = "%" #r,			\
> > >>+			.offset = offsetof(struct user_pt_regs, regs[num])}
> > >Whilst this works in practice, this is undefined behaviour for "sp", since
> > >you'll go off the end of the regs array.
> > 
> > It's not undefined behaviour here,
> > struct user_pt_regs {
> >         __u64           regs[31];
> >         __u64           sp;
> >         __u64           pc;
> >         __u64           pstate;
> > };
> > user_pt_regs->regs[31] is user_pt_regs->sp and the offset value is correct.
> 
> I think it's undefined from the C standard perspective.

Actually, this '%sp' is used for kprobes/uprobes dynamic events, which only 
depend on how regs_query_register_offset()@arch/arm64/kernel/ptrace.c is implemented.
And also, since perf-probe uses debuginfo, it can find out the base register.

So we don't need to care the C standard in this file :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
