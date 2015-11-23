From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 11:37:47 +0000
Subject: [PATCH v3 07/62] arm/acpi: Add arch_acpi_os_map_memory helper
 function for ARM
In-Reply-To: <1447753261-7552-8-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-8-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231137000.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>

Hi Shannon,

could you please add a couple of lines to the commit message mentioning
why __va(phys) is an acceptable implementation of arch_acpi_os_map_memory?

Thanks,

Stefano

> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/Makefile      |  1 +
>  xen/arch/arm/acpi/Makefile |  1 +
>  xen/arch/arm/acpi/lib.c    | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)
>  create mode 100644 xen/arch/arm/acpi/Makefile
>  create mode 100644 xen/arch/arm/acpi/lib.c
> 
> diff --git a/xen/arch/arm/Makefile b/xen/arch/arm/Makefile
> index 1ef39f7..1851ae8 100644
> --- a/xen/arch/arm/Makefile
> +++ b/xen/arch/arm/Makefile
> @@ -2,6 +2,7 @@ subdir-$(arm32) += arm32
>  subdir-$(arm64) += arm64
>  subdir-y += platforms
>  subdir-$(arm64) += efi
> +subdir-$(HAS_ACPI) += acpi
>  
>  obj-$(EARLY_PRINTK) += early_printk.o
>  obj-y += cpu.o
> diff --git a/xen/arch/arm/acpi/Makefile b/xen/arch/arm/acpi/Makefile
> new file mode 100644
> index 0000000..b5be22d
> --- /dev/null
> +++ b/xen/arch/arm/acpi/Makefile
> @@ -0,0 +1 @@
> +obj-y += lib.o
> diff --git a/xen/arch/arm/acpi/lib.c b/xen/arch/arm/acpi/lib.c
> new file mode 100644
> index 0000000..b68623b
> --- /dev/null
> +++ b/xen/arch/arm/acpi/lib.c
> @@ -0,0 +1,33 @@
> +/*
> + *  lib.c - Architecture-Specific Low-Level ACPI Support
> + *
> + *  Copyright (C) 2015, Shannon Zhao <shannon.zhao@linaro.org>
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#include <xen/acpi.h>
> +#include <xen/mm.h>
> +#include <asm/mm.h>
> +
> +void __iomem *
> +arch_acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
> +{
> +    return __va(phys);
> +}
> -- 
> 2.1.0
> 
