From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Oct 2010 20:10:54 +0200
Subject: [PATCHv4] ARM: imx: Add iram allocator functions
In-Reply-To: <1286383682-26506-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1286383682-26506-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20101006181054.GL29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Oct 06, 2010 at 11:48:02AM -0500, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Add IRAM(Internal RAM) allocation functions using GENERIC_ALLOCATOR.
> The allocation size is 4KB multiples to guarantee alignment. The
> idea for these functions is for i.MX platforms to use them
> to dynamically allocate IRAM usage.
> 
> Applies on 2.6.36-rc6
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@canonical.com>
> ---
>  arch/arm/plat-mxc/Kconfig             |    4 ++
>  arch/arm/plat-mxc/Makefile            |    1 +
>  arch/arm/plat-mxc/include/mach/iram.h |   37 ++++++++++++++++
>  arch/arm/plat-mxc/iram.c              |   74 +++++++++++++++++++++++++++++++++
>  4 files changed, 116 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/iram.h
>  create mode 100644 arch/arm/plat-mxc/iram.c
> 
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index 6785db4..0e99bb4 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -110,4 +110,8 @@ config ARCH_MXC_AUDMUX_V1
>  config ARCH_MXC_AUDMUX_V2
>  	bool
>  
> +config IRAM_ALLOC
> +	bool
> +	select GENERIC_ALLOCATOR
> +
>  endif
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index 78d405e..35cf07b 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_MXC_TZIC) += tzic.o
>  
>  obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
>  obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
> +obj-$(CONFIG_IRAM_ALLOC) += iram.o
If you really prefer IRAM_ALLOC over IRAM, why call your source iram.c?

>  obj-$(CONFIG_MXC_PWM)  += pwm.o
>  obj-$(CONFIG_USB_EHCI_MXC) += ehci.o
>  obj-$(CONFIG_MXC_ULPI) += ulpi.o
> diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/plat-mxc/include/mach/iram.h
> new file mode 100644
> index 0000000..351dacd
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/iram.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +#include <linux/errno.h>
> +
> +#ifdef CONFIG_IRAM_ALLOC

> +int __init iram_init(unsigned long base, unsigned long size);
> +void *iram_alloc(unsigned int size, unsigned long *dma_addr);
> +void iram_free(unsigned long dma_addr, unsigned int size);

> +#else

> +static inline int __init iram_init(unsigned long base, unsigned long size)
> +{
> +	return -ENOMEM;
> +}
> +
> +static inline void *iram_alloc(unsigned int size, unsigned long *dma_addr)
> +{
> +	return NULL;
> +}
> +
> +static inline void iram_free(unsigned long base, unsigned long size) {}

> +#endif
Can you please add newlines around the cpp stuff?

> diff --git a/arch/arm/plat-mxc/iram.c b/arch/arm/plat-mxc/iram.c
> new file mode 100644
> index 0000000..25c9e73
> --- /dev/null
> +++ b/arch/arm/plat-mxc/iram.c
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
linux/init.h isn't enough (contrary to what I guessed in an earlier
mail).  EXPORT_SYMBOL is defined in linux/module.h.

> +#include <linux/spinlock.h>
> +#include <linux/genalloc.h>

#include <mach/iram.h>, then you can remove the #include of linux/errno.h.
This should fix some sparse warnings.

> +
> +static unsigned long iram_phys_base;
> +static void __iomem *iram_virt_base;
> +static struct gen_pool *iram_pool;
> +
> +static inline unsigned long iram_phys_to_virt(unsigned long p)
> +{
> +	p = (unsigned long)iram_virt_base + (p - iram_phys_base);
> +	return p;
iram_phys_to_virt should return a value of type (void __iomem *), not
unsigned long.

> +}
> +
> +void __iomem*iram_alloc(unsigned int size, unsigned long *dma_addr)
> +{
> +	if (!iram_pool)
> +		return NULL;
> +
> +	*dma_addr = gen_pool_alloc(iram_pool, size);
> +	pr_debug("iram alloc - %dB at 0x%p\n", size, (void *)*dma_addr);
> +	if (!dma_addr)
> +		return NULL;
> +	return iram_phys_to_virt(*dma_addr);
> +}
> +EXPORT_SYMBOL(iram_alloc);
> +
> +void iram_free(unsigned long addr, unsigned int size)
> +{
> +	if (!iram_pool)
> +		return;
> +
> +	gen_pool_free(iram_pool, addr, size);
> +}
> +EXPORT_SYMBOL(iram_free);
> +
> +int __init iram_init(unsigned long base, unsigned long size)
> +{
> +	iram_phys_base = base;
> +
> +	iram_pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!iram_pool)
> +		return -ENOMEM;
> +
> +	gen_pool_add(iram_pool, base, size, -1);
> +	iram_virt_base = ioremap(iram_phys_base, size);
> +	if (!iram_virt_base)
> +		return -EIO;
> +
> +	pr_info("i.MX IRAM pool: %ld KB at 0x%p\n", size / 1024, iram_virt_base);
Is this message interesting enough to deserve a pr_info?  I'd make it
pr_debug.

> +	return 0;
> +}
> -- 
> 1.6.0.4

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
