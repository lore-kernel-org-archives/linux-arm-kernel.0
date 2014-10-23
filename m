From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 22 Oct 2014 23:18:31 -0600
Subject: [PATCH v3 05/27] PCI: tegra: Save msi chip in pci_sys_data
In-Reply-To: <1413342435-7876-6-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-6-git-send-email-wangyijing@huawei.com>
Message-ID: <20141023051831.GB11770@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 11:06:53AM +0800, Yijing Wang wrote:
> Save msi chip in pci_sys_data instead of assign
> msi chip to every pci bus in .add_bus().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host/pci-tegra.c |   13 +++----------
>  1 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3d43874..5af0525 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -694,15 +694,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  	return irq;
>  }
>  
> -static void tegra_pcie_add_bus(struct pci_bus *bus)
> -{
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> -
> -		bus->msi = &pcie->msi.chip;
> -	}
> -}
> -
>  static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  {
>  	struct tegra_pcie *pcie = sys_to_pcie(sys);
> @@ -1881,11 +1872,13 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
>  
>  	memset(&hw, 0, sizeof(hw));
>  
> +#ifdef CONFIG_PCI_MSI
> +	hw.msi_chip = &pcie->msi.chip;
> +#endif

Why did you use "#ifdef CONFIG_PCI_MSI" instead of the
"IS_ENABLED(CONFIG_PCI_MSI)" used previously?

It's true that CONFIG_PCI_MSI will never be a tristate symbol, so we don't
really *need* the extra smarts of IS_ENABLED(), but I'm fairly sympathetic
to James' argument [1] that we should just use IS_ENABLED() all the time
because it's simpler overall.

If you want to change the #ifdef to IS_ENABLED(), that should be a separate
patch from your msi_chip change, and we can debate the merits of that by
itself.

[1] http://lkml.iu.edu//hypermail/linux/kernel/1204.3/00081.html

>  	hw.nr_controllers = 1;
>  	hw.private_data = (void **)&pcie;
>  	hw.setup = tegra_pcie_setup;
>  	hw.map_irq = tegra_pcie_map_irq;
> -	hw.add_bus = tegra_pcie_add_bus;
>  	hw.scan = tegra_pcie_scan_bus;
>  	hw.ops = &tegra_pcie_ops;
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
