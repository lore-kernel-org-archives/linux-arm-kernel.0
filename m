From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 22 Dec 2016 13:57:50 +0100
Subject: [PATCH v5 09/14] ACPI: platform: setup MSI domain for ACPI based
 platform device
In-Reply-To: <1482384922-21507-10-git-send-email-guohanjun@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-10-git-send-email-guohanjun@huawei.com>
Message-ID: <CAJZ5v0g4AoU-g4UWZFxLgQ_yfTC7KSBnZ_Ve945d+i58e=GuDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 6:35 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> With the platform msi domain created, we can set up the msi domain
> for a platform device when it's probed.
>
> In order to do that, we need to get the domain that the platform
> device connecting to, so the iort_get_platform_device_domain() is
> introduced to retrieve the domain from iort.
>
> After the domain is retrieved, we need a proper way to set the
> domain to paltform device, as some platform devices such as an
> irqchip needs the msi irqdomain to be the interrupt parent domain,
> we need to get irqdomain before platform device is probed but after
> the platform device is allocated, so introduce a callback (pre_add_cb)
> in pdevinfo to prepare firmware related information which is needed
> for device probe, then set the msi domain in that callback.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/acpi/acpi_platform.c    | 11 +++++++++++
>  drivers/acpi/arm64/iort.c       | 43 +++++++++++++++++++++++++++++++++++++++++
>  drivers/base/platform.c         |  3 +++
>  include/linux/acpi_iort.h       |  3 +++
>  include/linux/platform_device.h |  3 +++
>  5 files changed, 63 insertions(+)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index b4c1a6a..5d8d61b4 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -12,6 +12,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> @@ -48,6 +49,15 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
>  }
>
>  /**
> + * acpi_platform_pre_add_cb - callback before platform device is added, to
> + * prepare firmware related information which is needed for device probe
> + */
> +static void acpi_platform_pre_add_cb(struct device *dev)
> +{
> +       acpi_configure_pmsi_domain(dev);
> +}
> +
> +/**
>   * acpi_create_platform_device - Create platform device for ACPI device node
>   * @adev: ACPI device node to create a platform device for.
>   * @properties: Optional collection of build-in properties.
> @@ -109,6 +119,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>         pdevinfo.num_res = count;
>         pdevinfo.fwnode = acpi_fwnode_handle(adev);
>         pdevinfo.properties = properties;
> +       pdevinfo.pre_add_cb = acpi_platform_pre_add_cb;

Why don't you point that directly to acpi_configure_pmsi_domain()?  It
doesn't look like the wrapper is necessary at all.

And I'm not sure why the new callback is necessary ->

>
>         if (acpi_dma_supported(adev))
>                 pdevinfo.dma_mask = DMA_BIT_MASK(32);
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index bc68d93..6b72fcb 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -527,6 +527,49 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
>         return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
>  }
>
> +/**
> + * iort_get_platform_device_domain() - Find MSI domain related to a
> + * platform device
> + * @dev: the dev pointer associated with the platform device
> + *
> + * Returns: the MSI domain for this device, NULL otherwise
> + */
> +static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
> +{
> +       struct acpi_iort_node *node, *msi_parent;
> +       struct fwnode_handle *iort_fwnode;
> +       struct acpi_iort_its_group *its;
> +
> +       /* find its associated iort node */
> +       node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +                             iort_match_node_callback, dev);
> +       if (!node)
> +               return NULL;
> +
> +       /* then find its msi parent node */
> +       msi_parent = iort_node_get_id(node, NULL, IORT_MSI_TYPE, 0);
> +       if (!msi_parent)
> +               return NULL;
> +
> +       /* Move to ITS specific data */
> +       its = (struct acpi_iort_its_group *)msi_parent->node_data;
> +
> +       iort_fwnode = iort_find_domain_token(its->identifiers[0]);
> +       if (!iort_fwnode)
> +               return NULL;
> +
> +       return irq_find_matching_fwnode(iort_fwnode, DOMAIN_BUS_PLATFORM_MSI);
> +}
> +
> +void acpi_configure_pmsi_domain(struct device *dev)
> +{
> +       struct irq_domain *msi_domain;
> +
> +       msi_domain = iort_get_platform_device_domain(dev);
> +       if (msi_domain)
> +               dev_set_msi_domain(dev, msi_domain);
> +}
> +
>  static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>  {
>         u32 *rid = data;
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index c4af003..3e68f31 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -537,6 +537,9 @@ struct platform_device *platform_device_register_full(
>                         goto err;
>         }
>
> +       if (pdevinfo->pre_add_cb)
> +               pdevinfo->pre_add_cb(&pdev->dev);
> +

-> because it looks like this might be done in acpi_platform_notify()
for platform devices.

>         ret = platform_device_add(pdev);
>         if (ret) {

Thanks,
Rafael
