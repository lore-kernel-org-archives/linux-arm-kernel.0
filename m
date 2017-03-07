From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Tue, 7 Mar 2017 11:12:36 +0000
Subject: [PATCH v2 2/7] PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
In-Reply-To: <1488880372-7390-3-git-send-email-kishon@ti.com>
References: <1488880372-7390-1-git-send-email-kishon@ti.com>
 <1488880372-7390-3-git-send-email-kishon@ti.com>
Message-ID: <14c771fd-f225-338b-3b1a-255df0e0b278@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?s 9:52 AM de 3/7/2017, Kishon Vijay Abraham I escreveu:
> Populate cpu_addr_fixup ops to extract the least 28 bits of the
> corresponding cpu address.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 0984baf..07c45ec 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -88,6 +88,11 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
>  	writel(value, pcie->base + offset);
>  }
>  
> +static u64 dra7xx_pcie_cpu_addr_fixup(u64 pci_addr)
> +{
> +	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
> +}
> +
>  static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
> @@ -152,11 +157,6 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  
> -	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -
>  	dw_pcie_setup_rc(pp);
>  
>  	dra7xx_pcie_establish_link(dra7xx);
> @@ -329,6 +329,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  }
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> +	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
>  	.link_up = dra7xx_pcie_link_up,
>  };
>  
> 

Simpler, no doubt.

Acked-By: Joao Pinto <jpinto@synopsys.com>
