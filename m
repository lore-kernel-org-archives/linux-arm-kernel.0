From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Jun 2015 15:48:10 +0100
Subject: [PATCH 09/10] arm64/BUG: Use BRK instruction for generic BUG traps
In-Reply-To: <1434036566-9848-10-git-send-email-Dave.Martin@arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
 <1434036566-9848-10-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150616144810.GE30522@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Just a few comments, inline.

On Thu, Jun 11, 2015 at 04:29:23PM +0100, Dave P Martin wrote:
> Currently, the minimal default BUG() implementation from asm-
> generic is used for arm64.
> 
> This patch uses the BRK software breakpoint instruction to generate
> a trap instead, similarly to most other arches, with the generic
> BUG code generating the dmesg boilerplate.
> 
> This allows bug metadata to be moved to a separate table and
> reduces the amount of inline code at BUG and WARN sites.  This also
> avoids clobbering any registers before they can be dumped.
> 
> To mitigate the size of the bug table further, this patch makes
> use of the existing infrastructure for encoding addresses within
> the bug table as 32-bit offsets instead of absolute pointers.
> (Note that this limits the kernel size to 2GB.)
> 
> Traps are registered at arch_initcall time for aarch64, but BUG
> has minimal real dependencies and it is desirable to be able to
> generate bug splats as early as possible.  This patch redirects
> all debug exceptions caused by BRK directly to bug_handler() until
> the full debug exception support has been initialised.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/Kconfig           |    8 ++++++
>  arch/arm64/include/asm/brk.h |    1 +
>  arch/arm64/include/asm/bug.h |   64 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/traps.c    |   57 ++++++++++++++++++++++++++++++++++++-
>  arch/arm64/mm/fault.c        |   12 ++++++--
>  5 files changed, 139 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/include/asm/bug.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7796af4..aedda42 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -110,6 +110,14 @@ config TRACE_IRQFLAGS_SUPPORT
>  config RWSEM_XCHGADD_ALGORITHM
>  	def_bool y
>  
> +config GENERIC_BUG
> +	def_bool y
> +	depends on BUG
> +
> +config GENERIC_BUG_RELATIVE_POINTERS
> +	def_bool y
> +	depends on GENERIC_BUG
> +
>  config GENERIC_HWEIGHT
>  	def_bool y
>  
> diff --git a/arch/arm64/include/asm/brk.h b/arch/arm64/include/asm/brk.h
> index 99b8dfb..f4d5894 100644
> --- a/arch/arm64/include/asm/brk.h
> +++ b/arch/arm64/include/asm/brk.h
> @@ -27,5 +27,6 @@
>  #define FAULT_BRK_IMM			0x100
>  #define KGDB_DYN_DBG_BRK_IMM		0x400
>  #define KGDB_COMPILED_DBG_BRK_IMM	0x401
> +#define BUG_BRK_IMM			0x7ff

Just curious, but how did you come up with this number?

>  #endif /* ! _ARCH_ARM64_ASM_BRK_H */
> diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> new file mode 100644
> index 0000000..0429c7b
> --- /dev/null
> +++ b/arch/arm64/include/asm/bug.h
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright (C) 2015  ARM Limited
> + * Author: Dave Martin <Dave.Martin@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _ARCH_ARM64_ASM_BUG_H
> +#define _ARCH_ARM64_ASM_BUG_H

Please follow the standard header guard pattern we use for arm64 (__ASM_).

> +
> +#include <asm/brk.h>
> +
> +#ifdef CONFIG_GENERIC_BUG
> +#define HAVE_ARCH_BUG
> +
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
> +#define __BUGVERBOSE_LOCATION(file, line)				\
> +		".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
> +	"2:	.string \"" file "\"\n\t"				\
> +		".popsection\n\t"					\
> +									\
> +		".long 2b - 0b\n\t"					\
> +		".short " #line "\n\t"
> +#else
> +#define _BUGVERBOSE_LOCATION(file, line)
> +#endif
> +
> +#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
> +
> +#define __BUG_FLAGS(flags) asm volatile (		\
> +		".pushsection __bug_table,\"a\"\n\t"	\
> +		".align 2\n\t"				\
> +	"0:	.long 1f - 0b\n\t"			\
> +_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
> +		".short " #flags "\n\t"			\
> +		".popsection\n"				\
> +							\
> +	"1:	brk %[imm]"				\
> +		:: [imm] "i" (BUG_BRK_IMM)		\
> +)
> +
> +#define BUG() do {				\
> +	_BUG_FLAGS(0);				\
> +	unreachable();				\
> +} while (0)
> +
> +#define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
> +
> +#endif /* ! CONFIG_GENERIC_BUG */
> +
> +#include <asm-generic/bug.h>
> +
> +#endif /* ! _ARCH_ARM64_ASM_BUG_H */
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 1ef2940..5fdf776 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -17,6 +17,7 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/bug.h>
>  #include <linux/signal.h>
>  #include <linux/personality.h>
>  #include <linux/kallsyms.h>
> @@ -32,8 +33,11 @@
>  #include <linux/syscalls.h>
>  
>  #include <asm/atomic.h>
> +#include <asm/brk.h>
> +#include <asm/bug.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/esr.h>
> +#include <asm/insn.h>
>  #include <asm/traps.h>
>  #include <asm/stacktrace.h>
>  #include <asm/exception.h>
> @@ -460,7 +464,58 @@ void __pgd_error(const char *file, int line, unsigned long val)
>  	pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
>  }
>  
> +/* GENERIC_BUG traps */
> +
> +int is_valid_bugaddr(unsigned long addr)
> +{
> +	/*
> +	 * bug_handler() only called for BUG #BUG_BRK_IMM.

s/BUG/BRK/ ?

> +	 * So the answer is trivial -- any spurious instances with no
> +	 * bug table entry will be rejected by report_bug() and passed
> +	 * back to the debug-monitors code and handled as a fatal
> +	 * unexpected debug exception.
> +	 */
> +	return 1;
> +}

Could we define is_valid_bugaddr as a macro in the header file and avoid
the potential out-of-line call?

> +
> +static int bug_handler(struct pt_regs *regs, unsigned int esr)
> +{
> +	if (user_mode(regs))
> +		return DBG_HOOK_ERROR;
> +
> +	switch (report_bug(regs->pc, regs)) {
> +	case BUG_TRAP_TYPE_BUG:
> +		die("Oops - BUG", regs, 0);
> +		/* die() does not return */

Are you sure about that? A quick glance at the code didn't convince me...

Will
