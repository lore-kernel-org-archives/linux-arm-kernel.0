From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 25 Nov 2015 18:09:13 -0500 (EST)
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2015, Stephen Boyd wrote:

> The ARM compiler inserts calls to __aeabi_uidiv() and
> __aeabi_idiv() when it needs to perform division on signed and
> unsigned integers. If a processor has support for the udiv and
> sdiv division instructions the calls to these support routines
> can be replaced with those instructions. Now that recordmcount
> records the locations of calls to these library functions in
> two sections (one for udiv and one for sdiv), iterate over these
> sections early at boot and patch the call sites with the
> appropriate division instruction when we determine that the
> processor supports the division instructions. Using the division
> instructions should be faster and less power intensive than
> running the support code.

A few remarks:

1) The code assumes unconditional branches to __aeabi_idiv and 
   __aeabi_uidiv. What if there are conditional branches? Also, tail 
   call optimizations will generate a straight b opcode rather than a bl 
   and patching those will obviously have catastrophic results.  I think 
   you should validate the presence of a bl before patching over it.

2) For those cases where a call to __aeabi_uidiv and __aeabi_idiv is not 
   patched due to (1), you could patch a uidiv/idiv plus "bx lr" 
   at those function entry points too.

3) In fact I was wondering if the overhead of the branch and back is 
   really significant compared to the non trivial cost of a idiv 
   instruction and all the complex infrastructure required to patch 
   those branches directly, and consequently if the performance 
   difference is actually worth it versus simply doing (2) alone.

4) Please add some printing to the boot log (debug level should be fine)  
   about the fact that you did modify n branch instances with a div 
   insn. That _could_ turn out to be a useful clue when debugging kernel 
   "strangeties".

> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: M?ns Rullg?rd <mans@mansr.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/Kconfig               | 14 +++++++++
>  arch/arm/include/asm/cputype.h |  8 ++++-
>  arch/arm/include/asm/setup.h   |  3 ++
>  arch/arm/kernel/module.c       | 40 +++++++++++++++++++++++++
>  arch/arm/kernel/setup.c        | 68 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/vmlinux.lds.S  | 13 ++++++++
>  6 files changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0365cbbc9179..aa8bc7da6331 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1617,6 +1617,20 @@ config AEABI
>  
>  	  To use this you need GCC version 4.0.0 or later.
>  
> +config ARM_PATCH_UIDIV
> +	bool "Runtime patch calls to __aeabi_{u}idiv() with udiv/sdiv"
> +	depends on CPU_32v7 && !XIP_KERNEL && AEABI
> +	help
> +	  Some v7 CPUs have support for the udiv and sdiv instructions
> +	  that can be used in place of calls to __aeabi_uidiv and __aeabi_idiv
> +	  functions provided by the ARM runtime ABI.
> +
> +	  Enabling this option allows the kernel to modify itself to replace
> +	  branches to these library functions with the udiv and sdiv
> +	  instructions themselves. Typically this will be faster and less
> +	  power intensive than running the library support code to do
> +	  integer division.
> +
>  config OABI_COMPAT
>  	bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
>  	depends on AEABI && !THUMB2_KERNEL
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 85e374f873ac..48c77d422a0d 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -250,8 +250,14 @@ static inline int cpu_is_pj4(void)
>  
>  	return 0;
>  }
> +
> +static inline bool __attribute_const__ cpu_is_pj4_nomp(void)
> +{
> +	return read_cpuid_part() == 0x56005810;
> +}
>  #else
> -#define cpu_is_pj4()	0
> +#define cpu_is_pj4()		0
> +#define cpu_is_pj4_nomp()	0
>  #endif
>  
>  static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> index e0adb9f1bf94..a514552d5cbd 100644
> --- a/arch/arm/include/asm/setup.h
> +++ b/arch/arm/include/asm/setup.h
> @@ -25,4 +25,7 @@ extern int arm_add_memory(u64 start, u64 size);
>  extern void early_print(const char *str, ...);
>  extern void dump_machine_table(void);
>  
> +extern void patch_udiv(void *addr, size_t size);
> +extern void patch_sdiv(void *addr, size_t size);
> +
>  #endif
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index efdddcb97dd1..aa59e5cfe6a0 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -20,7 +20,9 @@
>  #include <linux/string.h>
>  #include <linux/gfp.h>
>  
> +#include <asm/hwcap.h>
>  #include <asm/pgtable.h>
> +#include <asm/setup.h>
>  #include <asm/sections.h>
>  #include <asm/smp_plat.h>
>  #include <asm/unwind.h>
> @@ -51,6 +53,38 @@ void *module_alloc(unsigned long size)
>  }
>  #endif
>  
> +#ifdef CONFIG_ARM_PATCH_UIDIV
> +static int module_patch_aeabi_uidiv(unsigned long loc, const Elf32_Sym *sym)
> +{
> +	extern char __aeabi_uidiv[], __aeabi_idiv[];
> +	unsigned long udiv_addr = (unsigned long)__aeabi_uidiv;
> +	unsigned long sdiv_addr = (unsigned long)__aeabi_idiv;
> +	unsigned int mask;
> +
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
> +		mask = HWCAP_IDIVT;
> +	else
> +		mask = HWCAP_IDIVA;
> +
> +	if (elf_hwcap & mask) {
> +		if (sym->st_value == udiv_addr) {
> +			patch_udiv(&loc, sizeof(loc));
> +			return 1;
> +		} else if (sym->st_value == sdiv_addr) {
> +			patch_sdiv(&loc, sizeof(loc));
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int module_patch_aeabi_uidiv(unsigned long loc, const Elf32_Sym *sym)
> +{
> +	return 0;
> +}
> +#endif
> +
>  int
>  apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  	       unsigned int relindex, struct module *module)
> @@ -109,6 +143,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  				return -ENOEXEC;
>  			}
>  
> +			if (module_patch_aeabi_uidiv(loc, sym))
> +				break;
> +
>  			offset = __mem_to_opcode_arm(*(u32 *)loc);
>  			offset = (offset & 0x00ffffff) << 2;
>  			if (offset & 0x02000000)
> @@ -195,6 +232,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  				return -ENOEXEC;
>  			}
>  
> +			if (module_patch_aeabi_uidiv(loc, sym))
> +				break;
> +
>  			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
>  			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
>  
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 20edd349d379..39a46059d5e8 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -32,6 +32,7 @@
>  #include <linux/compiler.h>
>  #include <linux/sort.h>
>  #include <linux/psci.h>
> +#include <linux/module.h>
>  
>  #include <asm/unified.h>
>  #include <asm/cp15.h>
> @@ -375,6 +376,72 @@ void __init early_print(const char *str, ...)
>  	printk("%s", buf);
>  }
>  
> +#ifdef CONFIG_ARM_PATCH_UIDIV
> +/* "sdiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 4" if we're on pj4 w/o MP */
> +static u32 __attribute_const__ sdiv_instruction(void)
> +{
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +		if (cpu_is_pj4_nomp())
> +			return __opcode_to_mem_thumb32(0xee300691);
> +		return __opcode_to_mem_thumb32(0xfb90f0f1);
> +	}
> +
> +	if (cpu_is_pj4_nomp())
> +		return __opcode_to_mem_arm(0xee300691);
> +	return __opcode_to_mem_arm(0xe710f110);
> +}
> +
> +/* "udiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 0" if we're on pj4 w/o MP */
> +static u32 __attribute_const__ udiv_instruction(void)
> +{
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +		if (cpu_is_pj4_nomp())
> +			return __opcode_to_mem_thumb32(0xee300611);
> +		return __opcode_to_mem_thumb32(0xfbb0f0f1);
> +	}
> +
> +	if (cpu_is_pj4_nomp())
> +		return __opcode_to_mem_arm(0xee300611);
> +	return __opcode_to_mem_arm(0xe730f110);
> +}
> +
> +static void __init_or_module patch(u32 **addr, size_t count, u32 insn)
> +{
> +	for (; count != 0; count -= 4)
> +		**addr++ = insn;
> +}
> +
> +void __init_or_module patch_udiv(void *addr, size_t size)
> +{
> +	patch(addr, size, udiv_instruction());
> +}
> +
> +void __init_or_module patch_sdiv(void *addr, size_t size)
> +{
> +	return patch(addr, size, sdiv_instruction());
> +}
> +
> +static void __init patch_aeabi_uidiv(void)
> +{
> +	extern char __start_udiv_loc[], __stop_udiv_loc[];
> +	extern char __start_idiv_loc[], __stop_idiv_loc[];
> +	unsigned int mask;
> +
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
> +		mask = HWCAP_IDIVT;
> +	else
> +		mask = HWCAP_IDIVA;
> +
> +	if (!(elf_hwcap & mask))
> +		return;
> +
> +	patch_udiv(__start_udiv_loc, __stop_udiv_loc - __start_udiv_loc);
> +	patch_sdiv(__start_idiv_loc, __stop_idiv_loc - __start_idiv_loc);
> +}
> +#else
> +static void __init patch_aeabi_uidiv(void) { }
> +#endif
> +
>  static void __init cpuid_init_hwcaps(void)
>  {
>  	int block;
> @@ -642,6 +709,7 @@ static void __init setup_processor(void)
>  	elf_hwcap = list->elf_hwcap;
>  
>  	cpuid_init_hwcaps();
> +	patch_aeabi_uidiv();
>  
>  #ifndef CONFIG_ARM_THUMB
>  	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 8b60fde5ce48..bc87a2e04e6f 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -28,6 +28,18 @@
>  	*(.hyp.idmap.text)						\
>  	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
>  
> +#ifdef CONFIG_ARM_PATCH_UIDIV
> +#define UIDIV_REC	. = ALIGN(8);					\
> +			VMLINUX_SYMBOL(__start_udiv_loc) = .;		\
> +			*(__udiv_loc)					\
> +			VMLINUX_SYMBOL(__stop_udiv_loc) = .;		\
> +			VMLINUX_SYMBOL(__start_idiv_loc) = .;		\
> +			*(__idiv_loc)					\
> +			VMLINUX_SYMBOL(__stop_idiv_loc) = .;
> +#else
> +#define UIDIV_REC
> +#endif
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  #define ARM_CPU_DISCARD(x)
>  #define ARM_CPU_KEEP(x)		x
> @@ -210,6 +222,7 @@ SECTIONS
>  	.init.data : {
>  #ifndef CONFIG_XIP_KERNEL
>  		INIT_DATA
> +		UIDIV_REC
>  #endif
>  		INIT_SETUP(16)
>  		INIT_CALLS
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
