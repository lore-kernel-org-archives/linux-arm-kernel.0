From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 11:52:07 +0000
Subject: [Xen-devel] [PATCH v3 09/62] arm/acpi: Add basic ACPI
 initialization
In-Reply-To: <1447753261-7552-10-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-10-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231149570.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:

> From: Parth Dixit <parth.dixit@linaro.org>
> 
> acpi_boot_table_init() will be called in start_xen to get the RSDP and
> all the table pointers. With this patch, we can get ACPI boot-time
> tables from firmware on ARM64.

The patch looks good, only one comment below.


> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/acpi/Makefile |  1 +
>  xen/arch/arm/acpi/boot.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  xen/arch/arm/setup.c       |  4 +++
>  3 files changed, 67 insertions(+)
>  create mode 100644 xen/arch/arm/acpi/boot.c
> 
> diff --git a/xen/arch/arm/acpi/Makefile b/xen/arch/arm/acpi/Makefile
> index b5be22d..196c40a 100644
> --- a/xen/arch/arm/acpi/Makefile
> +++ b/xen/arch/arm/acpi/Makefile
> @@ -1 +1,2 @@
>  obj-y += lib.o
> +obj-y += boot.o
> diff --git a/xen/arch/arm/acpi/boot.c b/xen/arch/arm/acpi/boot.c
> new file mode 100644
> index 0000000..ad51afc
> --- /dev/null
> +++ b/xen/arch/arm/acpi/boot.c
> @@ -0,0 +1,62 @@
> +/*
> + *  ARM Specific Low-Level ACPI Boot Support
> + *
> + *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> + *  Copyright (C) 2001 Jun Nakajima <jun.nakajima@intel.com>
> + *  Copyright (C) 2014, Naresh Bhat <naresh.bhat@linaro.org>
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
> +#include <xen/init.h>
> +#include <xen/acpi.h>
> +
> +#include <asm/acpi.h>
> +
> +/*
> + * acpi_boot_table_init() called from setup_arch(), always.
> + *      1. find RSDP and get its address, and then find XSDT
> + *      2. extract all tables and checksums them all
> + *
> + * return value: (currently ignored)
> + *	0: success
> + *	!0: failure
> + *
> + * We can parse ACPI boot-time tables such as FADT, MADT after
> + * this function is called.
> + */
> +int __init acpi_boot_table_init(void)
> +{
> +    int error;
> +
> +    /* If acpi_disabled, bail out */
> +    if ( acpi_disabled )
> +        return 1;
> +
> +    /* Initialize the ACPI boot-time table parser. */
> +    error = acpi_table_init();
> +    if ( error )
> +    {
> +        disable_acpi();
> +        return error;
> +    }
> +
> +    return 0;
> +}
> diff --git a/xen/arch/arm/setup.c b/xen/arch/arm/setup.c
> index 3b29904..768312f 100644
> --- a/xen/arch/arm/setup.c
> +++ b/xen/arch/arm/setup.c
> @@ -36,6 +36,7 @@
>  #include <xen/pfn.h>
>  #include <xen/vmap.h>
>  #include <xen/libfdt/libfdt.h>
> +#include <xen/acpi.h>
>  #include <asm/page.h>
>  #include <asm/current.h>
>  #include <asm/setup.h>
> @@ -753,6 +754,9 @@ void __init start_xen(unsigned long boot_phys_offset,
>  
>      setup_mm(fdt_paddr, fdt_size);
>  
> +    /* Parse the ACPI tables for possible boot-time configuration */
> +    acpi_boot_table_init();

Are you sure that you need to call acpi_boot_table_init before vm_init?


>      vm_init();
>      dt_unflatten_host_device_tree();
>  
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
