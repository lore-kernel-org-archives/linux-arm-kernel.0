From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Nov 2013 22:18:07 +0100
Subject: [PATCH 20/23] ARM: signal: sigreturn_codes should be endian
 neutral to work in BE8
In-Reply-To: <1381271679-27804-21-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
 <1381271679-27804-21-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20131105211807.GR14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 09, 2013 at 12:34:36AM +0200, Ben Dooks wrote:
> From: Victor Kamensky <victor.kamensky@linaro.org>
> 
> In case of BE8 kernel data is in BE order whereas code stays in LE
> order. Move sigreturn_codes to separate .S file and use proper
> assembler mnemonics for these code snippets. In this case compiler
> will take care of proper instructions byteswaps for BE8 case.
> Change assumes that sufficiently Thumb-capable tools are used to
> build kernel.
> 
> Problem was discovered during ltp testing of BE system: all rt_sig*
> tests failed. Tested against the same tests in both BE and LE modes.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/kernel/Makefile          |  3 +-
>  arch/arm/kernel/signal.c          | 24 +-----------
>  arch/arm/kernel/sigreturn_codes.S | 80 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 24 deletions(-)
>  create mode 100644 arch/arm/kernel/sigreturn_codes.S
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 5140df5f..39c9834 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -17,7 +17,8 @@ CFLAGS_REMOVE_return_address.o = -pg
>  
>  obj-y		:= elf.o entry-common.o irq.o opcodes.o \
>  		   process.o ptrace.o return_address.o \
> -		   setup.o signal.o stacktrace.o sys_arm.o time.o traps.o
> +		   setup.o signal.o sigreturn_codes.o \
> +		   stacktrace.o sys_arm.o time.o traps.o
>  
>  obj-$(CONFIG_ATAGS)		+= atags_parse.o
>  obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index ab33042..64845fc 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -21,29 +21,7 @@
>  #include <asm/unistd.h>
>  #include <asm/vfp.h>
>  
> -/*
> - * For ARM syscalls, we encode the syscall number into the instruction.
> - */
> -#define SWI_SYS_SIGRETURN	(0xef000000|(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
> -#define SWI_SYS_RT_SIGRETURN	(0xef000000|(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
> -
> -/*
> - * With EABI, the syscall number has to be loaded into r7.
> - */
> -#define MOV_R7_NR_SIGRETURN	(0xe3a07000 | (__NR_sigreturn - __NR_SYSCALL_BASE))
> -#define MOV_R7_NR_RT_SIGRETURN	(0xe3a07000 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE))
> -
> -/*
> - * For Thumb syscalls, we pass the syscall number via r7.  We therefore
> - * need two 16-bit instructions.
> - */
> -#define SWI_THUMB_SIGRETURN	(0xdf00 << 16 | 0x2700 | (__NR_sigreturn - __NR_SYSCALL_BASE))
> -#define SWI_THUMB_RT_SIGRETURN	(0xdf00 << 16 | 0x2700 | (__NR_rt_sigreturn - __NR_SYSCALL_BASE))
> -
> -static const unsigned long sigreturn_codes[7] = {
> -	MOV_R7_NR_SIGRETURN,    SWI_SYS_SIGRETURN,    SWI_THUMB_SIGRETURN,
> -	MOV_R7_NR_RT_SIGRETURN, SWI_SYS_RT_SIGRETURN, SWI_THUMB_RT_SIGRETURN,
> -};
> +extern const unsigned long sigreturn_codes[7];
>  
>  static unsigned long signal_return_offset;
>  
> diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
> new file mode 100644
> index 0000000..3c5d0f2
> --- /dev/null
> +++ b/arch/arm/kernel/sigreturn_codes.S
> @@ -0,0 +1,80 @@
> +/*
> + * sigreturn_codes.S - code sinpets for sigreturn syscalls
> + *
> + * Created by:	Victor Kamensky, 2013-08-13
> + * Copyright:	(C) 2013  Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <asm/unistd.h>
> +
> +/*
> + * For ARM syscalls, we encode the syscall number into the instruction.
> + * With EABI, the syscall number has to be loaded into r7. As result
> + * ARM syscall sequence snippet will have move and svc in .arm encoding
> + *
> + * For Thumb syscalls, we pass the syscall number via r7.  We therefore
> + * need two 16-bit instructions in .thumb encoding
> + *
> + * Please note sigreturn_codes code are not executed in place. Instead
> + * they just copied by kernel into appropriate places. Code inside of
> + * arch/arm/kernel/signal.c is very sensitive to layout of these code
> + * snippets.
> + */
> +
> +#if __LINUX_ARM_ARCH__ <= 4
> +	/*
> +	 * Note we manually set minimally required arch that supports
> +	 * required thumb opcodes for early arch versions. It is OK
> +	 * for this file to be used in combination with other
> +	 * lower arch variants, since these code snippets are only
> +	 * used as input data.
> +	 */
> +	.arch armv4t
> +#endif
> +
> +	.section .rodata
> +	.global sigreturn_codes
> +	.type	sigreturn_codes, #object
> +
> +	.arm
This breaks a ARMv7-M build, see
http://arm-soc.lixom.net/buildlogs/misc/next-20131105-1-g2b29c44/buildall.arm.efm32_defconfig.log.failed

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
