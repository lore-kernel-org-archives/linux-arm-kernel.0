From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 27 Jun 2018 19:39:06 +0300
Subject: [PATCH 4/4] PCI: mediatek: Add loadable kernel module support
In-Reply-To: <1530091298-28120-5-git-send-email-honghui.zhang@mediatek.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
 <1530091298-28120-5-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <CAHp75VdsSZifb5xZ2Q8cmJV=PgAaoN=iOhMfyVX4uE4vNpo=Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
>
> Implement remove callback function for Mediatek PCIe driver to add
> loadable kernel module support.

> +static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
> +{
> +       struct mtk_pcie_port *port, *tmp;
> +

> +       if (list_empty(&pcie->ports))
> +               return;

This is redundant.

> +
> +       list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +               irq_set_chained_handler_and_data(port->irq, NULL, NULL);
> +
> +               if (port->irq_domain)
> +                       irq_domain_remove(port->irq_domain);
> +
> +               if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +                       if (port->msi_domain)
> +                               irq_domain_remove(port->msi_domain);
> +                       if (port->inner_domain)
> +                               irq_domain_remove(port->inner_domain);
> +               }
> +
> +               irq_dispose_mapping(port->irq);
> +       }
> +}

> +static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
> +{
> +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +       struct list_head *windows = &host->windows;
> +
> +       pci_unmap_iospace(&pcie->pio);
> +       pci_free_resource_list(windows);
> +}
> +
> +static int mtk_pcie_remove(struct platform_device *pdev)
> +{
> +       struct mtk_pcie *pcie = platform_get_drvdata(pdev);
> +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +
> +       pci_stop_root_bus(host->bus);
> +       pci_remove_root_bus(host->bus);
> +       mtk_pcie_free_resources(pcie);
> +
> +       mtk_pcie_irq_teardown(pcie);
> +

> +       if (!list_empty(&pcie->ports))

I think this is also not needed. Do you put runtime PM by the way?

> +               mtk_pcie_put_resources(pcie);
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
