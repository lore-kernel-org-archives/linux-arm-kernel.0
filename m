From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Aug 2017 14:38:40 +0100
Subject: [PATCH 2/2] arm64: compat: Add CONFIG_KUSER_HELPERS
In-Reply-To: <20170804183151.78804-1-salyzyn@android.com>
References: <20170804183151.78804-1-salyzyn@android.com>
Message-ID: <20170815133839.GE12294@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 11:31:40AM -0700, Mark Salyzyn wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> Make it possible to disable the kuser helpers by adding a KUSER_HELPERS
> config option (enabled by default). When disabled, all kuser
> helpers-related code is removed from the kernel and no mapping is done
> at the fixed high address (0xffff0000); any attempt to use a kuser
> helper from a 32-bit process will result in a segfault.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> ---
>  arch/arm64/Kconfig              | 29 ++++++++++++++++++
>  arch/arm64/kernel/Makefile      |  3 +-
>  arch/arm64/kernel/kuser32.S     | 48 ++---------------------------
>  arch/arm64/kernel/sigreturn32.S | 67 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/vdso.c        |  6 ++++
>  5 files changed, 107 insertions(+), 46 deletions(-)
>  create mode 100644 arch/arm64/kernel/sigreturn32.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index dfd908630631..902ad4b5b3d3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1100,6 +1100,35 @@ config COMPAT
>  
>  	  If you want to execute 32-bit userspace applications, say Y.
>  
> +config KUSER_HELPERS
> +	bool "Enable the kuser helpers page in 32-bit processes"
> +	depends on COMPAT
> +	default y
> +	help
> +	  Warning: disabling this option may break 32-bit applications.
> +
> +	  Provide kuser helpers in a special purpose fixed-address page. The
> +	  kernel provides helper code to userspace in read-only form at a fixed
> +	  location to allow userspace to be independent of the CPU type fitted
> +	  to the system. This permits 32-bit binaries to be run on ARMv4 through
> +	  to ARMv8 without modification.

That's a bit over-reaching, I think. You might also need e.g. swp emulation
enabled to run ARMv4 binaries.

> +
> +	  See Documentation/arm/kernel_user_helpers.txt for details.
> +
> +	  However, the fixed-address nature of these helpers can be used by ROP
> +	  (return-orientated programming) authors when creating exploits.
> +
> +	  If all of the 32-bit binaries and libraries that run on your platform
> +	  are built specifically for your platform, and make no use of these
> +	  helpers, then you can turn this option off to hinder such exploits.
> +	  However, in that case, if a binary or library relying on those helpers
> +	  is run, it will receive a SIGSEGV signal, which will terminate the
> +	  program. Typically, binaries compiled for ARMv7 or later do not use
> +	  the kuser helpers.
> +
> +	  Say N here only if you are absolutely certain that you do not need
> +	  these helpers; otherwise, the safe option is to say Y.

I think we should default this to 'N' for arm64.

> +
>  config SYSVIPC_COMPAT
>  	def_bool y
>  	depends on COMPAT && SYSVIPC
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index f2b4e816b6de..314b9abda0a0 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -27,8 +27,9 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
>  $(obj)/%.stub.o: $(obj)/%.o FORCE
>  	$(call if_changed,objcopy)
>  
> -arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
> +arm64-obj-$(CONFIG_COMPAT)		+= sys32.o sigreturn32.o signal32.o	\
>  					   sys_compat.o entry32.o
> +arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
>  arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
>  arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
>  arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
> diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
> index 997e6b27ff6a..d15b5c2935b3 100644
> --- a/arch/arm64/kernel/kuser32.S
> +++ b/arch/arm64/kernel/kuser32.S
> @@ -20,16 +20,13 @@
>   *
>   * AArch32 user helpers.
>   *
> - * Each segment is 32-byte aligned and will be moved to the top of the high
> - * vector page.  New segments (if ever needed) must be added in front of
> - * existing ones.  This mechanism should be used only for things that are
> - * really small and justified, and not be abused freely.
> + * These helpers are provided for compatibility with AArch32 binaries that
> + * still need them. They are installed at a fixed address by
> + * aarch32_setup_additional_pages().
>   *
>   * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
>   */
>  
> -#include <asm/unistd.h>
> -
>  	.align	5
>  	.globl	__kuser_helper_start
>  __kuser_helper_start:
> @@ -77,42 +74,3 @@ __kuser_helper_version:			// 0xffff0ffc
>  	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
>  	.globl	__kuser_helper_end
>  __kuser_helper_end:
> -
> -/*
> - * AArch32 sigreturn code
> - *
> - * For ARM syscalls, the syscall number has to be loaded into r7.
> - * We do not support an OABI userspace.
> - *
> - * For Thumb syscalls, we also pass the syscall number via r7. We therefore
> - * need two 16-bit instructions.
> - */
> -	.globl __aarch32_sigret_code_start
> -__aarch32_sigret_code_start:
> -
> -	/*
> -	 * ARM Code
> -	 */
> -	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_sigreturn
> -	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_sigreturn
> -
> -	/*
> -	 * Thumb code
> -	 */
> -	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
> -	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
> -
> -	/*
> -	 * ARM code
> -	 */
> -	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
> -	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
> -
> -	/*
> -	 * Thumb code
> -	 */
> -	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
> -	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
> -
> -        .globl __aarch32_sigret_code_end
> -__aarch32_sigret_code_end:
> diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
> new file mode 100644
> index 000000000000..6ecda4d84cd5
> --- /dev/null
> +++ b/arch/arm64/kernel/sigreturn32.S

Why do we need a new file for these?

> @@ -0,0 +1,67 @@
> +/*
> + * sigreturn trampolines for AArch32.
> + *
> + * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
> + * Copyright (C) 2012 ARM Ltd.
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
> + *
> + *
> + * AArch32 sigreturn code
> + *
> + * For ARM syscalls, the syscall number has to be loaded into r7.
> + * We do not support an OABI userspace.
> + *
> + * For Thumb syscalls, we also pass the syscall number via r7. We therefore
> + * need two 16-bit instructions.
> + */
> +
> +#include <asm/unistd.h>
> +
> +	.globl __aarch32_sigret_code_start
> +__aarch32_sigret_code_start:
> +
> +	/*
> +	 * ARM Code
> +	 */
> +	// mov	r7, #__NR_compat_sigreturn
> +	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3
> +	// svc	#__NR_compat_sigreturn
> +	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef

If there is a good reason to have this in a new file, why reformat the stuff
at the same time? This looks like more churn.

I have a feeling that there's a nice concise patch set in this lot that's
trying to get out ;)

Will
