From: dannenberg@ti.com (Andreas Dannenberg)
Date: Wed, 2 Mar 2016 15:26:28 -0600
Subject: [v8,2/4] arm: add implementation for arm-smccc
In-Reply-To: <1451912079-29258-3-git-send-email-jens.wiklander@linaro.org>
References: <1451912079-29258-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20160302212628.GA12740@borg.dal.design.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 01:54:37PM +0100, Jens Wiklander wrote:
> Adds implementation for arm-smccc and enables CONFIG_HAVE_SMCCC for
> architectures that may support arm-smccc. It's the responsibility of the
> caller to know if the SMC instruction is supported by the platform.
> 
> Reviewed-by: Lars Persson <lars.persson@axis.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> ---
> arch/arm/Kconfig             |  1 +
>  arch/arm/kernel/Makefile     |  2 ++
>  arch/arm/kernel/armksyms.c   |  6 +++++
>  arch/arm/kernel/smccc-call.S | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+)
>  create mode 100644 arch/arm/kernel/smccc-call.S
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 34e1569..36b9490 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -37,6 +37,7 @@ config ARM
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32
>  	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
>  	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_ARM_SMCCC if CPU_V7
>  	select HAVE_BPF_JIT
>  	select HAVE_CC_STACKPROTECTOR
>  	select HAVE_CONTEXT_TRACKING
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index af9e59b..d2d0042 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -92,4 +92,6 @@ obj-y				+= psci-call.o
>  obj-$(CONFIG_SMP)		+= psci_smp.o
>  endif
>  
> +obj-$(CONFIG_HAVE_ARM_SMCCC)	+= smccc-call.o
> +
>  extra-y := $(head-y) vmlinux.lds
> diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
> index f89811f..7e45f69 100644
> --- a/arch/arm/kernel/armksyms.c
> +++ b/arch/arm/kernel/armksyms.c
> @@ -16,6 +16,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
> +#include <linux/arm-smccc.h>
>  
>  #include <asm/checksum.h>
>  #include <asm/ftrace.h>
> @@ -175,3 +176,8 @@ EXPORT_SYMBOL(__gnu_mcount_nc);
>  EXPORT_SYMBOL(__pv_phys_pfn_offset);
>  EXPORT_SYMBOL(__pv_offset);
>  #endif
> +
> +#ifdef CONFIG_HAVE_ARM_SMCCC
> +EXPORT_SYMBOL(arm_smccc_smc);
> +EXPORT_SYMBOL(arm_smccc_hvc);
> +#endif
> diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
> new file mode 100644
> index 0000000..2e48b67
> --- /dev/null
> +++ b/arch/arm/kernel/smccc-call.S
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright (c) 2015, Linaro Limited
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/linkage.h>
> +
> +#include <asm/opcodes-sec.h>
> +#include <asm/opcodes-virt.h>
> +#include <asm/unwind.h>
> +
> +	/*
> +	 * Wrap c macros in asm macros to delay expansion until after the
> +	 * SMCCC asm macro is expanded.
> +	 */
> +	.macro SMCCC_SMC
> +	__SMC(0)
> +	.endm
> +
> +	.macro SMCCC_HVC
> +	__HVC(0)
> +	.endm
> +
> +	.macro SMCCC instr
> +UNWIND(	.fnstart)
> +	mov	r12, sp
> +	push	{r4-r7}
> +UNWIND(	.save	{r4-r7})
> +	ldm	r12, {r4-r7}
> +	\instr

Jens,
out of curiosity, we don't need any dsb/dmb calls here? I've rummaged
through some other code here at TI and see such barriers being included
right before the smc call. However in all fairness I also don't see such
memory calls included in arch/arm/kernel/psci-call.S that your other
patch is removing, so either they are really not needed or I didn't look
right and need to go to have my prescriptions checked.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

> +	pop	{r4-r7}
> +	ldr	r12, [sp, #(4 * 4)]
> +	stm	r12, {r0-r3}
> +	bx	lr
> +UNWIND(	.fnend)
> +	.endm
> +
> +/*
> + * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
> + *		  unsigned long a3, unsigned long a4, unsigned long a5,
> + *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
> + */
> +ENTRY(arm_smccc_smc)
> +	SMCCC SMCCC_SMC
> +ENDPROC(arm_smccc_smc)
> +
> +/*
> + * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
> + *		  unsigned long a3, unsigned long a4, unsigned long a5,
> + *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
> + */
> +ENTRY(arm_smccc_hvc)
> +	SMCCC SMCCC_HVC
> +ENDPROC(arm_smccc_hvc)
