From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Nov 2015 12:00:32 +0000
Subject: [PATCH V5 8/9] PCI: OF: Move of_pci_dma_configure() to
 pci_dma_configure()
In-Reply-To: <564B4111.6010805@arm.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1446072654-5608-9-git-send-email-Suravee.Suthikulpanit@amd.com>
 <564B4111.6010805@arm.com>
Message-ID: <564C6860.4000002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Arnd

On 17/11/15 15:00, Robin Murphy wrote:
> Hi Suravee,
>
> On 28/10/15 22:50, Suravee Suthikulpanit wrote:
>> This patch move of_pci_dma_configure() to a more generic
>> pci_dma_configure(), which can be extended by non-OF code (e.g. ACPI).
>>
>> This has no functional change.
>
> Unfortunately, it appears that it does...
>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Acked-by: Rob Herring <robh+dt@kernel.org>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
[...]
>> +/**
>> + * pci_dma_configure - Setup DMA configuration
>> + * @dev: ptr to pci_dev struct of the PCI device
>> + *
>> + * Function to update PCI devices's DMA configuration using the same
>> + * info from the OF node of host bridge's parent (if any).
>> + */
>> +static void pci_dma_configure(struct pci_dev *dev)
>> +{
>> +    struct device *bridge = pci_get_host_bridge_device(dev);
>> +
>> +    if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
>
> Previously I was seeing of_dma_configure, and thus of_iommu_configure,
> called for every PCI device on Juno. The check above now prevents this
> happening, since the PCI devices are probed directly from the bus and
> don't have OF nodes of their own. They now get left in some
> half-configured state where arch_setup_dma_ops isn't called either.

Just to follow up on that, Arnd's patch to tidy up dma_get_ops (now 
queued[1]) makes this even worse, since preventing arch_setup_dma_ops 
being called means the PCI devices now get the dummy DMA ops which leave 
the drivers failing to probe at all, IOMMU hacks or not :(

Robin.

[1]:https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=fixes/core&id=1dccb598df549d892b6450c261da54cdd7af44b4

> Should this be checking bridge->parent->of_node rather than
> dev->dev.of_node (which seems to work), or am I missing something?
>
> Sorry I don't really have the bandwidth to look into this in detail
> myself, right now I'm just trying to get my magic hacks rebased ;)
>
> Robin.
>
>> +        if (bridge->parent)
>> +            of_dma_configure(&dev->dev, bridge->parent->of_node);
>> +    }
>> +
>> +    pci_put_host_bridge_device(bridge);
>> +}
