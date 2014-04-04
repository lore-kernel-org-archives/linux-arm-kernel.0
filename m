From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 4 Apr 2014 10:55:59 -0600
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
In-Reply-To: <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140404165559.GE9007@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 02:25:47PM +0100, Lucas Stach wrote:
> This is the recommended method of doing the IRQ
> mapping. For old devicetrees we fall back to the
> previous practice.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied with Stephen's Tested-by to my pending/host-tegra branch.  I'll
rebase and rename it after v3.15-rc1, and I think we can squeeze it into
v3.15 shortly after that.  Thanks.

> ---
>  drivers/pci/host/pci-tegra.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 330f7e3a32dd..083cf37ca047 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -639,10 +639,15 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
>  static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>  	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
> +	int irq;
>  
>  	tegra_cpuidle_pcie_irqs_in_use();
>  
> -	return pcie->irq;
> +	irq = of_irq_parse_and_map_pci(pdev, slot, pin);
> +	if (!irq)
> +		irq = pcie->irq;
> +
> +	return irq;
>  }
>  
>  static void tegra_pcie_add_bus(struct pci_bus *bus)
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
