From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 9 Mar 2018 09:27:15 +0000
Subject: [PATCH 1/7] ARM: linker script: factor out some common
 definitions between XIP and non-XIP
In-Reply-To: <20180309032100.31039-2-nicolas.pitre@linaro.org>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
 <20180309032100.31039-2-nicolas.pitre@linaro.org>
Message-ID: <89d1d757-213c-4f47-af42-347ef27934d9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/18 03:20, Nicolas Pitre wrote:
> Lots of duplications between vmlinux.lds.S and vmlinux-xip.lds.S.
> This may lead to one file being updated but not the other. For example,
> SOFTIRQENTRY_TEXT and HYPERVISOR_TEXT were missing from the XIP version.

It looks to me that HYPERVISOR_TEXT was not present in the XIP version
intentionally - XIP depends on !ARM_LPAE, i.e. not support for virtualisation.

Cheers
Vladimir

> 
> This creates vmlinux.lds.h where a bunch of common defines are moved.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/kernel/vmlinux-xip.lds.S | 35 +++-------------------------------
>  arch/arm/kernel/vmlinux.lds.S     | 38 +------------------------------------
>  arch/arm/kernel/vmlinux.lds.h     | 40 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 69 deletions(-)
>  create mode 100644 arch/arm/kernel/vmlinux.lds.h
> 
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 12b87591eb..0a8922b616 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -15,38 +15,7 @@
>  #include <asm/memory.h>
>  #include <asm/page.h>
>  
> -#define PROC_INFO							\
> -	. = ALIGN(4);							\
> -	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
> -	*(.proc.info.init)						\
> -	VMLINUX_SYMBOL(__proc_info_end) = .;
> -
> -#define IDMAP_TEXT							\
> -	ALIGN_FUNCTION();						\
> -	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
> -	*(.idmap.text)							\
> -	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
> -	. = ALIGN(PAGE_SIZE);						\
> -	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
> -	*(.hyp.idmap.text)						\
> -	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
> -
> -#ifdef CONFIG_HOTPLUG_CPU
> -#define ARM_CPU_DISCARD(x)
> -#define ARM_CPU_KEEP(x)		x
> -#else
> -#define ARM_CPU_DISCARD(x)	x
> -#define ARM_CPU_KEEP(x)
> -#endif
> -
> -#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> -	defined(CONFIG_GENERIC_BUG)
> -#define ARM_EXIT_KEEP(x)	x
> -#define ARM_EXIT_DISCARD(x)
> -#else
> -#define ARM_EXIT_KEEP(x)
> -#define ARM_EXIT_DISCARD(x)	x
> -#endif
> +#include "vmlinux.lds.h"
>  
>  OUTPUT_ARCH(arm)
>  ENTRY(stext)
> @@ -100,10 +69,12 @@ SECTIONS
>  			*(.entry.text)
>  			__entry_text_end = .;
>  			IRQENTRY_TEXT
> +			SOFTIRQENTRY_TEXT
>  			TEXT_TEXT
>  			SCHED_TEXT
>  			CPUIDLE_TEXT
>  			LOCK_TEXT
> +			HYPERVISOR_TEXT
>  			KPROBES_TEXT
>  			*(.gnu.warning)
>  			*(.glue_7)
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 84a1ae3ce4..6a6eb483d9 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -15,43 +15,7 @@
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  
> -#define PROC_INFO							\
> -	. = ALIGN(4);							\
> -	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
> -	*(.proc.info.init)						\
> -	VMLINUX_SYMBOL(__proc_info_end) = .;
> -
> -#define HYPERVISOR_TEXT							\
> -	VMLINUX_SYMBOL(__hyp_text_start) = .;				\
> -	*(.hyp.text)							\
> -	VMLINUX_SYMBOL(__hyp_text_end) = .;
> -
> -#define IDMAP_TEXT							\
> -	ALIGN_FUNCTION();						\
> -	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
> -	*(.idmap.text)							\
> -	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
> -	. = ALIGN(PAGE_SIZE);						\
> -	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
> -	*(.hyp.idmap.text)						\
> -	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
> -
> -#ifdef CONFIG_HOTPLUG_CPU
> -#define ARM_CPU_DISCARD(x)
> -#define ARM_CPU_KEEP(x)		x
> -#else
> -#define ARM_CPU_DISCARD(x)	x
> -#define ARM_CPU_KEEP(x)
> -#endif
> -
> -#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> -	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
> -#define ARM_EXIT_KEEP(x)	x
> -#define ARM_EXIT_DISCARD(x)
> -#else
> -#define ARM_EXIT_KEEP(x)
> -#define ARM_EXIT_DISCARD(x)	x
> -#endif
> +#include "vmlinux.lds.h"
>  
>  OUTPUT_ARCH(arm)
>  ENTRY(stext)
> diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
> new file mode 100644
> index 0000000000..0a86e8a111
> --- /dev/null
> +++ b/arch/arm/kernel/vmlinux.lds.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +#define ARM_CPU_DISCARD(x)
> +#define ARM_CPU_KEEP(x)		x
> +#else
> +#define ARM_CPU_DISCARD(x)	x
> +#define ARM_CPU_KEEP(x)
> +#endif
> +
> +#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> +	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
> +#define ARM_EXIT_KEEP(x)	x
> +#define ARM_EXIT_DISCARD(x)
> +#else
> +#define ARM_EXIT_KEEP(x)
> +#define ARM_EXIT_DISCARD(x)	x
> +#endif
> +
> +#define PROC_INFO							\
> +		. = ALIGN(4);						\
> +		VMLINUX_SYMBOL(__proc_info_begin) = .;			\
> +		*(.proc.info.init)					\
> +		VMLINUX_SYMBOL(__proc_info_end) = .;
> +
> +#define HYPERVISOR_TEXT							\
> +		VMLINUX_SYMBOL(__hyp_text_start) = .;			\
> +		*(.hyp.text)						\
> +		VMLINUX_SYMBOL(__hyp_text_end) = .;
> +
> +#define IDMAP_TEXT							\
> +		ALIGN_FUNCTION();					\
> +		VMLINUX_SYMBOL(__idmap_text_start) = .;			\
> +		*(.idmap.text)						\
> +		VMLINUX_SYMBOL(__idmap_text_end) = .;			\
> +		. = ALIGN(PAGE_SIZE);					\
> +		VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;		\
> +		*(.hyp.idmap.text)					\
> +		VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
> +
> 
