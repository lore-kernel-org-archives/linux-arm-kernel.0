From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 17:22:21 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <1292244903-30392-2-git-send-email-shawn.guo@freescale.com>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<1292244903-30392-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <201012151722.21939.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 December 2010, Shawn Guo wrote:
> Add core definitions for MXS-based SoC MX23 and MX28.

How different are these from the MXC SoCs? Is it really
worth having a totally separate plat-* directory for them?

AFAICT, combining the two would make it much easier to build
a kernel that works on mx23/28 as well as mx25 or the later
MXS implementations.

> diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
> new file mode 100644
> index 0000000..53e89a0
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/hardware.h
> +
> +#ifndef __MACH_MXS_HARDWARE_H__
> +#define __MACH_MXS_HARDWARE_H__
> +
> +#ifdef __ASSEMBLER__
> +#define IOMEM(addr)	(addr)
> +#else
> +#define IOMEM(addr)	((void __force __iomem *)(addr))
> +#endif

This looks like a rather ugly hack to hide misuse of __iomem
pointers. If you pass virtual addresses of I/O registers,
just make them always be of type (void __iomem *), so you
can actually benefit from the sparse annotations, rather
working against them.

> +
> +#ifndef __ASSEMBLER__
> +static inline void __mxs_setl(u32 mask, void __iomem *reg)
> +{
> +	__raw_writel(mask, reg + MXS_SET_ADDR);
> +}
> +
> +static inline void __mxs_clrl(u32 mask, void __iomem *reg)
> +{
> +	__raw_writel(mask, reg + MXS_CLR_ADDR);
> +}
> +
> +static inline void __mxs_togl(u32 mask, void __iomem *reg)
> +{
> +	__raw_writel(mask, reg + MXS_TOG_ADDR);
> +}
> +#endif

Why __raw_writel()? All regular I/O accesses should use
readl/writel etc, not the internal helpers.

	Arnd
