From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 18 Nov 2015 13:48:06 +0800
Subject: [Xen-devel] [PATCH 05/13] Xen: ARM: Add support for mapping
 platform device mmio
In-Reply-To: <20151117143822.GH3003@char.us.oracle.com>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-6-git-send-email-shannon.zhao@linaro.org>
 <20151117143822.GH3003@char.us.oracle.com>
Message-ID: <564C1116.8000603@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/17 22:38, Konrad Rzeszutek Wilk wrote:
> On Tue, Nov 17, 2015 at 05:57:03PM +0800, shannon.zhao at linaro.org wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> Add a bus_notifier for platform bus device in order to map the device
>> mmio regions when DOM0 booting with ACPI.
>>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>>  drivers/xen/Makefile   |   1 +
>>  drivers/xen/platform.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 105 insertions(+)
>>  create mode 100644 drivers/xen/platform.c
>>
>> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
>> index e293bc5..2f867e7 100644
>> --- a/drivers/xen/Makefile
>> +++ b/drivers/xen/Makefile
>> @@ -11,6 +11,7 @@ CFLAGS_features.o			:= $(nostackp)
>>  
>>  CFLAGS_efi.o				+= -fshort-wchar
>>  
>> +dom0-$(CONFIG_ARM64) += platform.o
>>  dom0-$(CONFIG_PCI) += pci.o
>>  dom0-$(CONFIG_USB_SUPPORT) += dbgp.o
>>  dom0-$(CONFIG_XEN_ACPI) += acpi.o $(xen-pad-y)
>> diff --git a/drivers/xen/platform.c b/drivers/xen/platform.c
>> new file mode 100644
>> index 0000000..0f95e7f
>> --- /dev/null
>> +++ b/drivers/xen/platform.c
>> @@ -0,0 +1,104 @@
>> +/*
>> + * Copyright (c) 2015, Linaro Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
>> + * Place - Suite 330, Boston, MA 02111-1307 USA.
>> + *
>> + * Author: Shannon Zhao <shannon.zhao@linaro.org>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/acpi.h>
>> +#include <xen/xen.h>
>> +#include <xen/interface/memory.h>
>> +#include <asm/xen/hypervisor.h>
>> +#include <asm/xen/hypercall.h>
>> +
>> +static int xen_map_platform_device_mmio(struct platform_device *pdev)
>> +{
>> +	int i, rc = 0;
> 
> unsigned int i;
>> +
>> +	for (i = 0; i < pdev->num_resources; i++)
>> +	{
>> +		struct resource *r = &pdev->resource[i];
>> +
>> +		if (resource_type(r) == IORESOURCE_MEM)
> 
> Make this:
> 
> 	if (resource_type(r) != IORESOURCE_MEM)
> 		continue;
> 
>> +		{
> 
> And then you don't have to move all of this code to the right.
> 
>> +			int j;
> unsigned int
>> +			int nr = DIV_ROUND_UP(resource_size(r), PAGE_SIZE);
> 
> unsigned int
>> +			xen_pfn_t *gpfns = kmalloc(sizeof(xen_pfn_t) * nr,
>> +						   GFP_KERNEL);
>> +			xen_ulong_t *idxs = kmalloc(sizeof(xen_ulong_t) * nr,
>> +						    GFP_KERNEL);
>> +			int *errs = kmalloc(sizeof(int) * nr, GFP_KERNEL);
> 
> You can use kzalloc.
>> +			struct xen_add_to_physmap_range xatp;
> 
> This declaration of variables and then setting does not look like that
> pretty to my mind. (And it is a headache to debug if for example 'nr' ends up
> being zero for example). Or worst -1U since you had it as 'int'.
> 
Yes, a little. Maybe I can add a check for nr. Would that be fine?

Thanks,
-- 
Shannon
