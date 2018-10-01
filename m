From: jan.kundrat@cesnet.cz (=?iso-8859-1?Q?Jan_Kundr=E1t?=)
Date: Mon, 01 Oct 2018 12:56:37 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
In-Reply-To: <20180924165218.26c7c418@windsurf>
References: <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
 <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
 <20180924151040.5e57462b@windsurf>
 <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
 <20180924165218.26c7c418@windsurf>
Message-ID: <0f80dc88-dffe-4ca6-bb85-c4e5c967e0e1@cesnet.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pond?l? 24. z??? 2018 16:52:18 CEST, Thomas Petazzoni wrote:
> Hello,
>
> On Mon, 24 Sep 2018 15:15:12 +0100, Lorenzo Pieralisi wrote:
>
>> I understand that, I wanted to make sure we come up with a fix asap
>> and what I put forward would cover everything discussed in this thread,
>> at least temporarily, giving us time to check ISA related issues while
>> unmapping IO space.
>
> Something like this should implemented what you suggest I guess:
>
> diff --git a/drivers/pci/controller/pci-mvebu.c 
> b/drivers/pci/controller/pci-mvebu.c
> index 50eb0729385b..a41d79b8d46a 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1145,7 +1145,6 @@ static int 
> mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  {
>         struct device *dev = &pcie->pdev->dev;
>         struct device_node *np = dev->of_node;
> -       unsigned int i;
>         int ret;
>  
>         INIT_LIST_HEAD(&pcie->resources);
> @@ -1179,13 +1178,58 @@ static int 
> mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>                                          resource_size(&pcie->io) - 1);
>                 pcie->realio.name = "PCI I/O";
>  
> +               pci_add_resource(&pcie->resources, &pcie->realio);
> +       }
> +
> +       return devm_request_pci_bus_resources(dev, &pcie->resources);
> +}
> +
> +/*
> + * This is a copy of pci_host_probe(), except that it does the I/O
> + * remap as the last step, once we are sure we won't fail.
> + *
> + * It should be removed once the I/O remap error handling issue has
> + * been sorted out.
> + */
> +static int mvebu_pci_host_probe(struct pci_host_bridge *bridge)
> +{
> +       struct mvebu_pcie *pcie;
> +       struct pci_bus *bus, *child;
> +       int ret;
> +
> +       ret = pci_scan_root_bus_bridge(bridge);
> +       if (ret < 0) {
> +               dev_err(bridge->dev.parent, "Scanning root bridge failed");
> +               return ret;
> +       }
> +
> +       pcie = pci_host_bridge_priv(bridge);
> +       if (resource_size(&pcie->io) != 0) {
> +               unsigned int i;
> +
>                 for (i = 0; i < resource_size(&pcie->realio); i += SZ_64K)
>                         pci_ioremap_io(i, pcie->io.start + i);
> +       }
>  
> -               pci_add_resource(&pcie->resources, &pcie->realio);
> +       bus = bridge->bus;
> +
> +       /*
> +        * We insert PCI resources into the iomem_resource and
> +        * ioport_resource trees in either pci_bus_claim_resources()
> +        * or pci_bus_assign_resources().
> +        */
> +       if (pci_has_flag(PCI_PROBE_ONLY)) {
> +               pci_bus_claim_resources(bus);
> +       } else {
> +               pci_bus_size_bridges(bus);
> +               pci_bus_assign_resources(bus);
> +
> +               list_for_each_entry(child, &bus->children, node)
> +                       pcie_bus_configure_settings(child);
>         }
>  
> -       return devm_request_pci_bus_resources(dev, &pcie->resources);
> +       pci_bus_add_devices(bus);
> +       return 0;
>  }
>  
>  static int mvebu_pcie_probe(struct platform_device *pdev)
> @@ -1268,7 +1312,7 @@ static int mvebu_pcie_probe(struct 
> platform_device *pdev)
>         bridge->align_resource = mvebu_pcie_align_resource;
>         bridge->msi = pcie->msi;
>  
> -       return pci_host_probe(bridge);
> +       return mvebu_pci_host_probe(bridge);
>  }
>  
>  static const struct of_device_id mvebu_pcie_of_match_table[] = {
>
> If that's what you meant, I'll go ahead and test on actual hardware and
> submit as a proper patch.

Thomas, Russell, Lorenzo,
did you have time to convert this into a patch which can hit 4.19? I don't 
see anything related in 4.19-rc6, but perhaps I missed something. Is there 
something that I should test or otherwise help?

With kind regards,
Jan
