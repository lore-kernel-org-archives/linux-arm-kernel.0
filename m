From: robherring2@gmail.com (Rob Herring)
Date: Fri, 02 Dec 2011 08:13:04 -0600
Subject: [PATCH] ARM: add EDAC atomic_scrub function
In-Reply-To: <1322834882-26363-1-git-send-email-robherring2@gmail.com>
References: <1322834882-26363-1-git-send-email-robherring2@gmail.com>
Message-ID: <4ED8DCF0.1020701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like EDAC list has changed. Resending to linux-edac list.

On 12/02/2011 08:08 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add support for architecture specific EDAC atomic_scrub to ARM. Only ARMv6+
> is implemented as ldrex/strex instructions are needed. Supporting EDAC on
> ARMv5 or earlier is unlikely at this point anyway.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/include/asm/edac.h |   48 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 48 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/edac.h
> 
> diff --git a/arch/arm/include/asm/edac.h b/arch/arm/include/asm/edac.h
> new file mode 100644
> index 0000000..0df7a2c
> --- /dev/null
> +++ b/arch/arm/include/asm/edac.h
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright 2011 Calxeda, Inc.
> + * Based on PPC version Copyright 2007 MontaVista Software, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef ASM_EDAC_H
> +#define ASM_EDAC_H
> +/*
> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
> + * Implements the per arch atomic_scrub() that EDAC use for software
> + * ECC scrubbing.  It reads memory and then writes back the original
> + * value, allowing the hardware to detect and correct memory errors.
> + */
> +static inline void atomic_scrub(void *va, u32 size)
> +{
> +#if __LINUX_ARM_ARCH__ >= 6
> +	unsigned int *virt_addr = va;
> +	unsigned int temp, temp2;
> +	unsigned int i;
> +
> +	for (i = 0; i < size / sizeof(*virt_addr); i++, virt_addr++) {
> +		/* Very carefully read and write to memory atomically
> +		 * so we are interrupt, DMA and SMP safe.
> +		 */
> +		__asm__ __volatile__("\n"
> +			"1:	ldrex	%0, [%2]\n"
> +			"	strex	%1, %0, [%2]\n"
> +			"	teq	%1, #0\n"
> +			"	bne	1b\n"
> +			: "=&r"(temp), "=&r"(temp2)
> +			: "r"(virt_addr)
> +			: "cc");
> +	}
> +#endif
> +}
> +
> +#endif
