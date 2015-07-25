From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sat, 25 Jul 2015 16:20:52 +0800
Subject: [PATCH v5 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
In-Reply-To: <1437643598-19795-5-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <55B346E4.2090304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 05:26 PM, Marc Zyngier wrote:
> In order to be able to populate the device msi_domain field,
> add the necessary hooks to propagate the host bridge msi_domain
> across secondary busses to devices.
>
> So far, nobody populates the initial msi_domain.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/pci/probe.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..2fd4f8e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -661,6 +661,32 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>   	}
>   }
>
> +static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
> +{
> +	/*
> +	 * Any firmware interface that can resolve the msi_domain
> +	 * should be called from here.
> +	 */
> +
> +	return NULL;
> +}
> +
> +static void pci_set_bus_msi_domain(struct pci_bus *bus)
> +{
> +	struct irq_domain *d;
> +
> +	/*
> +	 * Either bus is the root, and we must obtain it from the
> +	 * firmware, or we inherit it from the bridge device.
> +	 */
> +	if (pci_is_root_bus(bus))
> +		d = pci_host_bridge_msi_domain(bus);
> +	else
> +		d = dev_get_msi_domain(&bus->self->dev);
> +
> +	dev_set_msi_domain(&bus->dev, d);
> +}
> +
>   static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>   					   struct pci_dev *bridge, int busnr)
>   {
> @@ -714,6 +740,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>   	bridge->subordinate = child;
>
>   add_dev:
> +	pci_set_bus_msi_domain(child);
>   	ret = device_register(&child->dev);
>   	WARN_ON(ret < 0);
>
> @@ -1544,6 +1571,17 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_enable_acs(dev);
>   }
>
> +static void pci_set_msi_domain(struct pci_dev *dev)
> +{
> +	/*
> +	 * If no domain has been set through the pcibios callback,
> +	 * inherit the default from the bus device.
> +	 */
> +	if (!dev_get_msi_domain(&dev->dev))
> +		dev_set_msi_domain(&dev->dev,
> +				   dev_get_msi_domain(&dev->bus->dev));
> +}
> +
>   void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   {
>   	int ret;
> @@ -1585,6 +1623,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   	ret = pcibios_add_device(dev);
>   	WARN_ON(ret < 0);
>
> +	/* Setup MSI irq domain */
> +	pci_set_msi_domain(dev);
> +
>   	/* Notifier could use PCI capabilities */
>   	dev->match_driver = false;
>   	ret = device_add(&dev->dev);
> @@ -1975,6 +2016,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>   	b->bridge = get_device(&bridge->dev);
>   	device_enable_async_suspend(b->bridge);
>   	pci_set_bus_of_node(b);
> +	pci_set_bus_msi_domain(b);
>
>   	if (!parent)
>   		set_dev_node(b->bridge, pcibus_to_node(b));

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
