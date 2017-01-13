From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Jan 2017 10:45:24 +0000
Subject: [PATCH v7 12/15] msi: platform: make
 platform_msi_create_device_domain() ACPI aware
In-Reply-To: <1484147199-4267-13-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-13-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20170113104524.GC20837@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 11:06:36PM +0800, Hanjun Guo wrote:
> platform_msi_create_device_domain() is used to ctreate
> irqdomain for the device such as irqchip mbigen generating
> the MSIs, it's almost ready for ACPI use except
> of_node_to_fwnode() is for dt only, make it ACPI aware then
> things will work in both DTS and ACPI.

"The irqdomain creation carried out in:

platform_msi_create_device_domain()

relies on the fwnode_handle interrupt controller token to associate the
interrupt controller with a specific irqdomain. Current code relies on
the OF layer to retrieve a fwnode_handle for the device representing the
interrupt controller from its device->of_node pointer.  This makes
platform_msi_create_device_domain() DT specific whilst it really is not
because after the merge of commit f94277af03ea ("of/platform: Initialise
dev->fwnode appropriately") the fwnode_handle can easily be retrieved
from the dev->fwnode pointer in a firmware agnostic way.

Update platform_msi_create_device_domain() to retrieve the interrupt
controller fwnode_handle from the dev->fwnode pointer so that it can
be used seamlessly in ACPI and DT systems".

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> ---
>  drivers/base/platform-msi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index be6a599..035ca3b 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -345,8 +345,7 @@ struct irq_domain *
>  
>  	data->host_data = host_data;
>  	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
> -					     of_node_to_fwnode(dev->of_node),
> -					     ops, data);
> +					     dev->fwnode, ops, data);
>  	if (!domain)
>  		goto free_priv;
>  
> -- 
> 1.9.1
> 
