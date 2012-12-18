From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 18 Dec 2012 12:04:38 +0000
Subject: [Xen-devel] [PATCH v2 5/6] ARM: Dummy Virtual Machine platform
 support
In-Reply-To: <1355762141-29616-6-git-send-email-will.deacon@arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-6-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.DEB.2.02.1212181202310.17523@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Dec 2012, Will Deacon wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Add support for the smallest, dumbest possible platform, to be
> used as a guest for KVM or other hypervisors.
> 
> It only mandates a GIC and architected timers. Fits nicely with
> a multiplatform zImage. Uses very little silicon area.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/Kconfig            |  2 ++
>  arch/arm/Makefile           |  1 +
>  arch/arm/mach-virt/Kconfig  |  9 +++++++
>  arch/arm/mach-virt/Makefile |  5 ++++
>  arch/arm/mach-virt/virt.c   | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 82 insertions(+)
>  create mode 100644 arch/arm/mach-virt/Kconfig
>  create mode 100644 arch/arm/mach-virt/Makefile
>  create mode 100644 arch/arm/mach-virt/virt.c

Should it come along with a DTS?


> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2a04375..552d72e0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1127,6 +1127,8 @@ source "arch/arm/mach-versatile/Kconfig"
>  source "arch/arm/mach-vexpress/Kconfig"
>  source "arch/arm/plat-versatile/Kconfig"
>  
> +source "arch/arm/mach-virt/Kconfig"
> +
>  source "arch/arm/mach-w90x900/Kconfig"
>  
>  # Definitions to make life easier
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 5f914fc..e8232ad 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -192,6 +192,7 @@ machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
>  machine-$(CONFIG_ARCH_SPEAR13XX)	+= spear13xx
>  machine-$(CONFIG_ARCH_SPEAR3XX)		+= spear3xx
>  machine-$(CONFIG_MACH_SPEAR600)		+= spear6xx
> +machine-$(CONFIG_ARCH_VIRT)		+= virt
>  machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
>  
>  # Platform directory name.  This list is sorted alphanumerically
> diff --git a/arch/arm/mach-virt/Kconfig b/arch/arm/mach-virt/Kconfig
> new file mode 100644
> index 0000000..a568a2a
> --- /dev/null
> +++ b/arch/arm/mach-virt/Kconfig
> @@ -0,0 +1,9 @@
> +config ARCH_VIRT
> +	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select ARM_GIC
> +	select ARM_ARCH_TIMER
> +	select HAVE_SMP
> +	select CPU_V7
> +	select SPARSE_IRQ
> +	select USE_OF
> diff --git a/arch/arm/mach-virt/Makefile b/arch/arm/mach-virt/Makefile
> new file mode 100644
> index 0000000..7ddbfa6
> --- /dev/null
> +++ b/arch/arm/mach-virt/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for the linux kernel.
> +#
> +
> +obj-y					:= virt.o
> diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
> new file mode 100644
> index 0000000..174b9da
> --- /dev/null
> +++ b/arch/arm/mach-virt/virt.c
> @@ -0,0 +1,65 @@
> +/*
> + * Dummy Virtual Machine - does what it says on the tin.
> + *
> + * Copyright (C) 2012 ARM Ltd
> + * Authors: Will Deacon <will.deacon@arm.com>,
> + *          Marc Zyngier <marc.zyngier@arm.com>
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
> + */
> +
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/arch_timer.h>
> +#include <asm/hardware/gic.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +const static struct of_device_id irq_match[] = {
> +	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
> +	{}
> +};
> +
> +static void __init gic_init_irq(void)
> +{
> +	of_irq_init(irq_match);
> +}
> +
> +static void __init virt_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static void __init virt_timer_init(void)
> +{
> +	WARN_ON(arch_timer_of_register() != 0);
> +	WARN_ON(arch_timer_sched_clock_init() != 0);
> +}
> +
> +static const char *virt_dt_match[] = {
> +	"linux,dummy-virt",
> +	NULL
> +};
> +
> +static struct sys_timer virt_timer = {
> +	.init = virt_timer_init,
> +};
> +
> +DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
> +	.init_irq	= gic_init_irq,
> +	.handle_irq     = gic_handle_irq,
> +	.timer		= &virt_timer,
> +	.init_machine	= virt_init,
> +	.dt_compat	= virt_dt_match,
> +MACHINE_END
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
