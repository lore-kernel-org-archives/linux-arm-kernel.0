From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 16:39:17 +0000
Subject: [PATCH 06/13] Xen: ARM: Add support for mapping amba device mmio
In-Reply-To: <1447754231-7772-7-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-7-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511201638330.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a bus_notifier for AMBA bus device in order to map the device
> mmio regions when DOM0 booting with ACPI.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Please use scripts/checkpatch.pl to check the coding style


>  drivers/xen/Makefile |  1 +
>  drivers/xen/amba.c   | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 drivers/xen/amba.c
> 
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 2f867e7..139bd0b 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -12,6 +12,7 @@ CFLAGS_features.o			:= $(nostackp)
>  CFLAGS_efi.o				+= -fshort-wchar
>  
>  dom0-$(CONFIG_ARM64) += platform.o
> +dom0-$(CONFIG_ARM_AMBA) += amba.o
>  dom0-$(CONFIG_PCI) += pci.o
>  dom0-$(CONFIG_USB_SUPPORT) += dbgp.o
>  dom0-$(CONFIG_XEN_ACPI) += acpi.o $(xen-pad-y)
> diff --git a/drivers/xen/amba.c b/drivers/xen/amba.c
> new file mode 100644
> index 0000000..e491c8e
> --- /dev/null
> +++ b/drivers/xen/amba.c
> @@ -0,0 +1,99 @@
> +/*
> + * Copyright (c) 2015, Linaro Limited.
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
> + * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> + * Place - Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * Author: Shannon Zhao <shannon.zhao@linaro.org>
> + */
> +
> +#include <linux/amba/bus.h>
> +#include <linux/acpi.h>
> +#include <xen/xen.h>
> +#include <xen/interface/memory.h>
> +#include <asm/xen/hypervisor.h>
> +#include <asm/xen/hypercall.h>
> +
> +static int xen_map_amba_device_mmio(struct amba_device *adev)
> +{
> +	int rc = 0;
> +	struct resource *r = &adev->res;
> +
> +	if (resource_type(r) == IORESOURCE_MEM)
> +	{
> +		int j;
> +		int nr = DIV_ROUND_UP(resource_size(r), PAGE_SIZE);
> +		xen_pfn_t *gpfns = kmalloc(sizeof(xen_pfn_t) * nr, GFP_KERNEL);
> +		xen_ulong_t *idxs = kmalloc(sizeof(xen_ulong_t) * nr,
> +					    GFP_KERNEL);
> +		int *errs = kmalloc(sizeof(int) * nr, GFP_KERNEL);
> +		struct xen_add_to_physmap_range xatp;
> +
> +		for (j = 0; j < nr; j++) {
> +			gpfns[j] = (r->start >> PAGE_SHIFT) + j;
> +			idxs[j] = (r->start >> PAGE_SHIFT) + j;
> +			errs[j] = 0;

same comments as before: use XEN_PFN_DOWN and check for return errors
from kmalloc


> +		}
> +
> +		xatp.domid = DOMID_SELF;
> +		xatp.size = nr;
> +		xatp.space = XENMAPSPACE_dev_mmio;
> +
> +		set_xen_guest_handle(xatp.gpfns, gpfns);
> +		set_xen_guest_handle(xatp.idxs, idxs);
> +		set_xen_guest_handle(xatp.errs, errs);
> +
> +		rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
> +
> +		kfree(gpfns);
> +		kfree(idxs);
> +		kfree(errs);
> +		if (rc != 0)
> +			return rc;
> +	}
> +
> +	return rc;
> +}
> +
> +static int xen_amba_notifier(struct notifier_block *nb,
> +			     unsigned long action, void *data)
> +{
> +	struct amba_device *adev = to_amba_device(data);
> +	int r = 0;
> +
> +	if (!acpi_disabled && (action == BUS_NOTIFY_ADD_DEVICE))
> +		r = xen_map_amba_device_mmio(adev);
> +
> +	if (r)
> +	{
> +		dev_err(&adev->dev, "Failed to add_to_physmap device (%s) mmio!\n",
> +			adev->dev.init_name);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block amba_device_nb = {
> +	.notifier_call = xen_amba_notifier,
> +};
> +
> +static int __init register_xen_amba_notifier(void)
> +{
> +	if (!xen_initial_domain())
> +		return 0;
> +
> +	return bus_register_notifier(&amba_bustype, &amba_device_nb);
> +}
> +
> +arch_initcall(register_xen_amba_notifier);
> -- 
> 2.1.0
> 
