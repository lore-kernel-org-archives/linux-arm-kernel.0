From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 05 Mar 2014 10:20:28 +0900
Subject: [PATCH v5 7/7] pci: Add support for creating a generic host_bridge
 from device tree
In-Reply-To: <1393948204-11555-8-git-send-email-Liviu.Dudau@arm.com>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
 <1393948204-11555-8-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <001f01cf3811$18463ed0$48d2bc70$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 05, 2014 12:50 AM, Liviu Dudau wrote:
> 
> Several platforms use a rather generic version of parsing
> the device tree to find the host bridge ranges. Move the common code
> into the generic PCI code and use it to create a pci_host_bridge
> structure that can be used by arch code.
> 
> Based on early attempts by Andrew Murray to unify the code.
> Used powerpc and microblaze PCI code as starting point.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 8708b652..800678a 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c

[.....]

> +		res = kzalloc(sizeof(struct resource), GFP_KERNEL);

It makes build error with exynos_defconfig. (ARM32)
Thus, 'slab.h' is necessary in order to fix the build error.

./drivers/pci/host-bridge.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/slab.h>

 #include "pci.h"


> +		if (!res) {
> +			err = -ENOMEM;
> +			goto bridge_ranges_nomem;
> +		}
> +
> +		of_pci_range_to_resource(&range, dev, res);
> +
> +		if (resource_type(res) == IORESOURCE_IO)
> +			*io_base = range.cpu_addr;
> +
> +		pci_add_resource_offset(resources, res,
> +				res->start - range.pci_addr);
> +	}
> +
> +	/* Apply architecture specific fixups for the ranges */
> +	pcibios_fixup_bridge_ranges(resources);

It also makes compile problem with exynos_defconfig as below:

drivers/built-in.o: In function `pci_host_bridge_of_get_ranges':
drivers/pci/host-bridge.c:157: undefined reference to `pcibios_fixup_bridge_ranges'

Best regards,
Jingoo Han
