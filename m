From: Phil.Edworthy@renesas.com (Phil.Edworthy at renesas.com)
Date: Tue, 25 Mar 2014 08:52:24 +0000
Subject: [PATCH v5 1/4] pci: APM X-Gene PCIe controller driver
In-Reply-To: <1395270762-6055-2-git-send-email-tinamdar@apm.com>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
 <1395270762-6055-2-git-send-email-tinamdar@apm.com>
Message-ID: <OF8E4162E1.91105680-ON80257CA6.002FEBD9-80257CA6.0030BE31@eu.necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tanmay,

On: 19/03/2014 23:15, Tanmay wrote:
> Subject: [PATCH v5 1/4] pci: APM X-Gene PCIe controller driver
> Sent by: linux-pci-owner at vger.kernel.org
> 
> This patch adds the AppliedMicro X-Gene SOC PCIe controller driver.
> X-Gene PCIe controller supports maximum up to 8 lanes and GEN3 speed.
> X-Gene SOC supports maximum 5 PCIe ports.
<snip>

> +static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
> +                struct of_pci_range *range, u8 *ib_reg_mask)
> +{
> +   void __iomem *csr_base = port->csr_base;
> +   void __iomem *cfg_base = port->cfg_base;
> +   void *bar_addr;
> +   void *pim_addr;
> +   u64 restype = range->flags & IORESOURCE_TYPE_BITS;
> +   u64 cpu_addr = range->cpu_addr;
> +   u64 pci_addr = range->pci_addr;
> +   u64 size = range->size;
> +   u64 mask = ~(size - 1) | EN_REG;
> +   u32 flags = PCI_BASE_ADDRESS_MEM_TYPE_64;
> +   u32 bar_low;
> +   int region;
> +
> +   region = xgene_pcie_select_ib_reg(ib_reg_mask, range->size);
> +   if (region < 0) {
> +      dev_warn(port->dev, "invalid pcie dma-range config\n");
> +      return;
> +   }
> +
> +   if (restype == PCI_BASE_ADDRESS_MEM_PREFETCH)
> +      flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;

Since IORESOURCE_TYPE_BITS is 0x00001f00, and 
PCI_BASE_ADDRESS_MEM_PREFETCH is 0x08, this will never match. I think you 
are mixing up different sets of definitions here. Also, the address 
properties in range->flags are bitfields.

Regards
Phil
