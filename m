From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 14:02:37 +0100
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <3531202.AZ56rRAZTf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 20:35:20 Vincent Yang wrote:
> The remote firmware(SCB) owns the SMP control. This MCPM driver gets
> CPU/CLUSTER power up/down done by SCB over mailbox.
> 
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
> ---
>  arch/arm/mach-mb86s7x/Makefile |   2 +-
>  arch/arm/mach-mb86s7x/mcpm.c   | 360 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mb86s7x/smc.S    |  27 ++++
>  3 files changed, 388 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
>  create mode 100644 arch/arm/mach-mb86s7x/smc.S
> 
> diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
> index 97640b6..b0fa34b 100644
> --- a/arch/arm/mach-mb86s7x/Makefile
> +++ b/arch/arm/mach-mb86s7x/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_ARCH_MB86S7X)	+= board.o
> +obj-$(CONFIG_ARCH_MB86S7X)	+= board.o mcpm.o smc.o

The two files are using ARMv7-only instructions in inline assembly,
which means that you will get a compile error for a combined arvm6+armv7
kernel. Please add the appropriate 'CFLAGS_mcpm.o += -march=armv7-a'
statements in the Makefile for each file with this problem.

> +
> +static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> +static int mb86s7x_pm_use_count[S7X_MAX_CLUSTER][S7X_MAX_CPU];
> +extern void __iomem *mb86s7x_shm_base;

Out of principle, you should never put an 'extern' declaration into .c
file. Better put this into a header file that is shared between all files
accessing the variable. In this particular case, I think it would be
better to just move the mb86s7x_set_wficolor() implementation into
drivers/soc/mb86s7x/scb_mhu.c and add an exported symbol for that, so
you can keep the variable local to the mhu implementation.

> +#define mb86s70evb_exit_coherency_flush(level) { \
> +	asm volatile( \
> +	"stmfd	sp!, {fp, ip}\n\t" \
> +	"mrc	p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
> +	"bic	r0, r0, #"__stringify(CR_C)"\n\t" \
> +	"mcr	p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
> +	"isb\n\t" \
> +	"bl	v7_flush_dcache_"__stringify(level)"\n\t" \
> +	"bl	mb86s70evb_outer_flush_all\n\t" \
> +	"mrc	p15, 0, r0, c1, c0, 1   @ get ACTLR\n\t" \
> +	"bic	r0, r0, #(1 << 6)       @ disable local coherency\n\t" \
> +	"mcr	p15, 0, r0, c1, c0, 1   @ set ACTLR\n\t" \
> +	"isb\n\t" \
> +	"dsb\n\t" \
> +	"ldmfd	sp!, {fp, ip}" \
> +		: : : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", \
> +		"r9", "r10", "lr", "memory"); \
> +	}

Please make this an inline function instead of a macro.

> +
> +extern void mb86s7x_cpu_entry(unsigned long secondary_entry);

Same comment about the extern declaration here. The header won't be
used by the implementation file as that is written in assembly,
but it's better to be consistent.

	Arnd
