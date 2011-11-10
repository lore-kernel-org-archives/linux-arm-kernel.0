From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Nov 2011 22:45:45 +0000
Subject: [PATCH v8 04/16] ARM: LPAE: Move the FSR definitions to
 separate files
In-Reply-To: <1320682618-1182-5-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111110224545.GU12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 04:16:46PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
> index 49e9e38..25b45c1 100644
> --- a/arch/arm/mm/fault.h
> +++ b/arch/arm/mm/fault.h
> @@ -1,3 +1,20 @@
> -void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
> +#ifndef __ARCH_ARM_FAULT_H
> +#define __ARCH_ARM_FAULT_H
> +
> +/*
> + * Fault status register encodings.  We steal bit 31 for our own purposes.
> + */
> +#define FSR_LNX_PF		(1 << 31)
> +#define FSR_WRITE		(1 << 11)
> +#define FSR_FS4			(1 << 10)
> +#define FSR_FS3_0		(15)
> +
> +static inline int fsr_fs(unsigned int fsr)
> +{
> +	return (fsr & FSR_FS3_0) | (fsr & FSR_FS4) >> 6;
> +}

Much better.
