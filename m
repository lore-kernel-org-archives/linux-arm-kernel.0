From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Oct 2014 11:52:16 +0100
Subject: [PATCHv2 3/5] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <1412170630-18408-4-git-send-email-punit.agrawal@arm.com>
References: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
 <1412170630-18408-1-git-send-email-punit.agrawal@arm.com>
 <1412170630-18408-4-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141006105216.GD12935@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 02:37:08PM +0100, Punit Agrawal wrote:
> The SWP instruction was deprecated in the ARMv6 architecture,
> superseded by the LDREX/STREX family of instructions for
> load-linked/store-conditional operations. The ARMv7 multiprocessing
> extensions mandate that SWP/SWPB instructions are treated as undefined
> from reset, with the ability to enable them through the System Control
> Register SW bit. With ARMv8, the option to enable these instructions
> through System Control Register was dropped as well.
> 
> This patch ports the alternate solution to emulate the SWP and SWPB
> instructions using LDXR/STXR sequences from the arm port to
> arm64. The emulation is turned off by default and can be enabled at
> runtime using sysctl.

[...]

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd4e81a..89262da 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -149,6 +149,45 @@ config ARCH_XGENE
>  	help
>  	  This enables support for AppliedMicro X-Gene SOC Family
>  
> +comment "Processor Features"
> +
> +menuconfig ARMV8_DEPRECATED
> +	bool "Emulate deprecated/obsolete ARMv8 instructions"
> +	depends on COMPAT
> +	help
> +	  Legacy software support may require certain instructions
> +	  that have been deprecated or obsoleted in the architecture.
> +
> +	  Enable this config to enable selective emulation of these
> +	  features.
> +
> +	  If unsure, say N
> +
> +if ARMV8_DEPRECATED
> +
> +config SWP_EMULATION
> +	bool "Emulate SWP/SWPB instructions"
> +	help
> +	  ARMv8 obsoletes the use of A32 SWP/SWPB instructions such that
> +	  they are always undefined. Say Y here to enable software
> +	  emulation of these instructions for userspace using LDXR/STXR.
> +
> +	  In some older versions of glibc [<=2.8] SWP is used during futex
> +	  trylock() operations with the assumption that the code will not
> +	  be preempted. This invalid assumption may be more likely to fail
> +	  with SWP emulation enabled, leading to deadlock of the user
> +	  application.
> +
> +	  NOTE: when accessing uncached shared regions, LDXR/STXR rely
> +	  on an external transaction monitoring block called a global
> +	  monitor to maintain update atomicity. If your system does not
> +	  implement a global monitor, this option can cause programs that
> +	  perform SWP operations to uncached memory to deadlock.
> +
> +	  If unsure, say N
> +
> +endif
> +
>  endmenu
>  
>  menu "Bus support"
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index dc1f73b..c3b7c2f 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -105,6 +105,14 @@ bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>  int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> +
> +bool aarch32_insn_is_wide_instruction(u32 instr);
> +
> +#define RN_OFFSET	16
> +#define RT_OFFSET	12
> +#define RT2_OFFSET	 0

We should prefix these with A32_ or similar.

> +u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
>  #endif /* __ASSEMBLY__ */
>  
>  #endif	/* __ASM_INSN_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index e77dd61..39590f3 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -31,6 +31,7 @@ arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
>  arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>  arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>  arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
> +arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> new file mode 100644
> index 0000000..23fc6f8
> --- /dev/null
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -0,0 +1,287 @@
> +/*
> + *  Copied from arch/arm/kernel/swp_emulate.c and modified for ARMv8
> + *
> + *  Copyright (C) 2009,2012,2014 ARM Limited
> + *  __user_* functions adapted from include/asm/uaccess.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/perf_event.h>
> +#include <linux/sched.h>
> +#include <linux/sysctl.h>
> +
> +#include <asm/insn.h>
> +#include <asm/opcodes.h>
> +#include <asm/system_misc.h>
> +#include <asm/traps.h>
> +#include <asm/uaccess.h>
> +
> +/*
> + * The runtime support for deprecated instruction support can be in one of
> + * following two states -
> + *
> + * 0 = undef
> + * 1 = emulate (software emulation)
> + */
> +#define INSTR_UNDEF (0)
> +#define INSTR_EMULATE (1)

You don't need these brackets, but I think this is better off as an enum
anyway.

> +
> +/*
> + *  Implement emulation of the SWP/SWPB instructions using load-exclusive and
> + *  store-exclusive.
> + *
> + *  Syntax of SWP{B} instruction: SWP{B}<c> <Rt>, <Rt2>, [<Rn>]
> + *  Where: Rt  = destination
> + *	   Rt2 = source
> + *	   Rn  = address
> + */
> +
> +/*
> + * SWP defaults to undef as it's been obsoleted in the architecture
> + */
> +static int swp_enable = 0;
> +static int swp_enable_min = INSTR_UNDEF;
> +static int swp_enable_max = INSTR_EMULATE;

Since we're going to be adding other emulations that need similar code,
perhaps it would be better to have a way to register an emulation?

E.g. something like:

enum insn_emulation_type {
	INSN_UNDEF,
	INSN_EMULATE,
	INSN_HW,
};

enum legacy_insn_status {
	INSN_DEPRECATED,
	INSN_OPTIONAL,
	INSN_OBSOLETE,
};

struct insn_emulation_ops {
	const char		*name;
	enum legacy_insn_type	status;
	struct undef_hook	hook;
	int			(*set_emulation_type)(enum insn_emulation_type type);
};

That way, we can move all the default behaviour handling, proc/sys
munging and undef hook handling into a single place.

Will
