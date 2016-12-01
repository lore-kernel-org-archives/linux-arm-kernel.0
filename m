From: amakarov.linux@gmail.com (Aleksey Makarov)
Date: Thu, 1 Dec 2016 17:12:17 +0600
Subject: [PATCH v3 11/14] ACPI: irq: introduce interrupt producer
In-Reply-To: <1477408169-22217-12-git-send-email-guohanjun@huawei.com>
References: <1477408169-22217-1-git-send-email-guohanjun@huawei.com>
 <1477408169-22217-12-git-send-email-guohanjun@huawei.com>
Message-ID: <04573e29-6222-24f0-82f4-381367ee8bf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Hanjun,

On 10/25/2016 09:09 PM, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> In ACPI 6.1 spec, section 19.6.62, Interrupt Resource Descriptor Macro,

[ ... ]

> ---
>  drivers/acpi/gsi.c      | 10 ++++--
>  drivers/acpi/resource.c | 85 ++++++++++++++++++++++++++++++++++---------------
>  include/acpi/acpi_bus.h |  1 +
>  3 files changed, 68 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index ee9e0f2..29ee547 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -55,13 +55,19 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>  		      int polarity)
>  {
>  	struct irq_fwspec fwspec;
> +	struct acpi_device *adev = dev ? to_acpi_device(dev) : NULL;

Why are you sure dev is always an acpi device?
Look for example at drivers/acpi/pci_irq.c:377 where this function
is called for a PCI device

>
> -	if (WARN_ON(!acpi_gsi_domain_id)) {
> +	if (adev && &adev->fwnode && adev->interrupt_producer)

&adev->fwnode is always true

> +		/* devices in DSDT connecting to spefic interrupt producer */
> +		fwspec.fwnode = adev->interrupt_producer;
> +	else if (acpi_gsi_domain_id)
> +		/* devices connecting to gicd in default */
> +		fwspec.fwnode = acpi_gsi_domain_id;
> +	else {
>  		pr_warn("GSI: No registered irqchip, giving up\n");
>  		return -EINVAL;
>  	}

[ ... ]

All the best
Aleksey Makarov
