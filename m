From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 6 Mar 2017 15:25:30 +0530
Subject: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
In-Reply-To: <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com>
Message-ID: <58BD3212.9070202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 17 February 2017 10:50 PM, Joao Pinto wrote:
> ?s 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
>> Add endpoint mode support to designware driver. This uses the
>> EP Core layer introduced recently to add endpoint mode support.
>> *Any* function driver can now use this designware device
>> in order to achieve the EP functionality.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/dwc/Kconfig              |    5 +
>>  drivers/pci/dwc/Makefile             |    1 +
>>  drivers/pci/dwc/pcie-designware-ep.c |  342 ++++++++++++++++++++++++++++++++++
>>  drivers/pci/dwc/pcie-designware.c    |   51 +++++
>>  drivers/pci/dwc/pcie-designware.h    |   72 +++++++
>>  5 files changed, 471 insertions(+)
>>  create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
>>
>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>> index dfb8a69..00335c7 100644
>> --- a/drivers/pci/dwc/Kconfig
>> +++ b/drivers/pci/dwc/Kconfig
>> @@ -9,6 +9,11 @@ config PCIE_DW_HOST
>>  	depends on PCI_MSI_IRQ_DOMAIN
>>          select PCIE_DW
>>  
>> +config PCIE_DW_EP
>> +	bool
>> +	depends on PCI_ENDPOINT
>> +	select PCIE_DW
>> +
>>  config PCI_DRA7XX
>>  	bool "TI DRA7xx PCIe controller"
>>  	depends on PCI
>> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
>> index a2df13c..b38425d 100644
>> --- a/drivers/pci/dwc/Makefile
>> +++ b/drivers/pci/dwc/Makefile
>> @@ -1,5 +1,6 @@
>>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>> +obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>> new file mode 100644
>> index 0000000..e465c5e
>> --- /dev/null
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -0,0 +1,342 @@
>> +/**
>> + * Synopsys Designware PCIe Endpoint controller driver
>> + *
>> + * Copyright (C) 2017 Texas Instruments
>> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 of
>> + * the License as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <https://urldefense.proofpoint.com/v2/url?u=http-3A__www.gnu.org_licenses_&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=Wif-q5OZ-YZwRCxX1bBAl5itP28aoQ8Fv7NmxvWSvyg&s=N2kaSPkx7uqpiP9O357WPoXruWEiOzF6AhCVChKmdxc&e= >.
>> + */
>> +
>> +#include <linux/of.h>
>> +
>> +#include "pcie-designware.h"
>> +#include <linux/pci-epc.h>
>> +#include <linux/pci-epf.h>
>> +
>> +void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>> +{
>> +	struct pci_epc *epc = ep->epc;
>> +	struct pci_epf *epf;
>> +
>> +	list_for_each_entry(epf, &epc->pci_epf, list)
>> +		pci_epf_linkup(epf);
>> +}
>> +
>> +static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>> +{
>> +	u32 reg;
>> +
>> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, 0x0);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, 0x0);
>> +}
>> +
>> +static int dw_pcie_ep_write_header(struct pci_epc *epc,
>> +				   struct pci_epf_header *hdr)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	void __iomem *base = pci->dbi_base;
>> +
>> +	dw_pcie_write_dbi(pci, base, PCI_VENDOR_ID, 0x2, hdr->vendorid);
>> +	dw_pcie_write_dbi(pci, base, PCI_DEVICE_ID, 0x2, hdr->deviceid);
>> +	dw_pcie_write_dbi(pci, base, PCI_REVISION_ID, 0x1, hdr->revid);
>> +	dw_pcie_write_dbi(pci, base, PCI_CLASS_PROG, 0x1, hdr->progif_code);
>> +	dw_pcie_write_dbi(pci, base, PCI_CLASS_DEVICE, 0x2,
>> +			  hdr->subclass_code | hdr->baseclass_code << 8);
>> +	dw_pcie_write_dbi(pci, base, PCI_CACHE_LINE_SIZE, 0x1,
>> +			  hdr->cache_line_size);
>> +	dw_pcie_write_dbi(pci, base, PCI_SUBSYSTEM_VENDOR_ID, 0x2,
>> +			  hdr->subsys_vendor_id);
>> +	dw_pcie_write_dbi(pci, base, PCI_SUBSYSTEM_ID, 0x2, hdr->subsys_id);
>> +	dw_pcie_write_dbi(pci, base, PCI_INTERRUPT_PIN, 0x1,
>> +			  hdr->interrupt_pin);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
>> +				  dma_addr_t cpu_addr,
>> +				  enum dw_pcie_as_type as_type)
>> +{
>> +	int ret;
>> +	u32 free_win;
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	free_win = find_first_zero_bit(&ep->ib_window_map,
>> +				       sizeof(ep->ib_window_map));
>> +	if (free_win >= ep->num_ib_windows) {
>> +		dev_err(pci->dev, "no free inbound window\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = dw_pcie_prog_inbound_atu(pci, free_win, bar, cpu_addr,
>> +				       as_type);
>> +	if (ret < 0) {
>> +		dev_err(pci->dev, "Failed to program IB window\n");
>> +		return ret;
>> +	}
>> +
>> +	ep->bar_to_atu[bar] = free_win;
>> +	set_bit(free_win, &ep->ib_window_map);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
>> +				   u64 pci_addr, size_t size)
>> +{
>> +	u32 free_win;
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	free_win = find_first_zero_bit(&ep->ob_window_map,
>> +				       sizeof(ep->ob_window_map));
>> +	if (free_win >= ep->num_ob_windows) {
>> +		dev_err(pci->dev, "no free outbound window\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
>> +				  phys_addr, pci_addr, size);
>> +
>> +	set_bit(free_win, &ep->ob_window_map);
>> +	ep->outbound_addr[free_win] = phys_addr;
>> +
>> +	return 0;
>> +}
>> +
>> +static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 atu_index = ep->bar_to_atu[bar];
>> +
>> +	dw_pcie_ep_reset_bar(pci, bar);
>> +
>> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
>> +	clear_bit(atu_index, &ep->ib_window_map);
>> +}
>> +
>> +static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
>> +			      dma_addr_t bar_phys, size_t size, int flags)
>> +{
>> +	int ret;
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	enum dw_pcie_as_type as_type;
>> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>> +
>> +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>> +		as_type = DW_PCIE_AS_MEM;
>> +	else
>> +		as_type = DW_PCIE_AS_IO;
>> +
>> +	ret = dw_pcie_ep_inbound_atu(ep, bar, bar_phys, as_type);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, size - 1);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>> +			      u32 *atu_index)
>> +{
>> +	u32 index;
>> +
>> +	for (index = 0; index < ep->num_ob_windows; index++) {
>> +		if (ep->outbound_addr[index] != addr)
>> +			continue;
>> +		*atu_index = index;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
>> +{
>> +	int ret;
>> +	u32 atu_index;
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	ret = dw_pcie_find_index(ep, addr, &atu_index);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
>> +	clear_bit(atu_index, &ep->ob_window_map);
>> +}
>> +
>> +static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
>> +			       u64 pci_addr, size_t size)
>> +{
>> +	int ret;
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	ret = dw_pcie_ep_outbound_atu(ep, addr, pci_addr, size);
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to enable address\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_get_msi(struct pci_epc *epc)
>> +{
>> +	int val;
>> +	u32 lower_addr;
>> +	u32 upper_addr;
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	val = dw_pcie_read_dbi(pci, pci->dbi_base, MSI_MESSAGE_CONTROL, 0x2);
>> +	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
>> +
>> +	lower_addr = dw_pcie_read_dbi(pci, pci->dbi_base, MSI_MESSAGE_ADDR_L32,
>> +				      0x4);
>> +	upper_addr = dw_pcie_read_dbi(pci, pci->dbi_base, MSI_MESSAGE_ADDR_U32,
>> +				      0x4);
>> +
>> +	if (!(lower_addr || upper_addr))
>> +		return -EINVAL;
>> +
>> +	return val;
>> +}
>> +
>> +static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
>> +{
>> +	int val;
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	val = (encode_int << MSI_CAP_MMC_SHIFT);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base, MSI_MESSAGE_CONTROL, 0x2, val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_raise_irq(struct pci_epc *epc,
>> +				enum pci_epc_irq_type type, u8 interrupt_num)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +
>> +	if (!ep->ops->raise_irq)
>> +		return -EINVAL;
>> +
>> +	return ep->ops->raise_irq(ep, type, interrupt_num);
>> +}
>> +
>> +static void dw_pcie_ep_stop(struct pci_epc *epc)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	if (!pci->ops->stop_link)
>> +		return;
>> +
>> +	pci->ops->stop_link(pci);
>> +}
>> +
>> +static int dw_pcie_ep_start(struct pci_epc *epc)
>> +{
>> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	if (!pci->ops->start_link)
>> +		return -EINVAL;
>> +
>> +	return pci->ops->start_link(pci);
>> +}
>> +
>> +static const struct pci_epc_ops epc_ops = {
>> +	.write_header		= dw_pcie_ep_write_header,
>> +	.set_bar		= dw_pcie_ep_set_bar,
>> +	.clear_bar		= dw_pcie_ep_clear_bar,
>> +	.map_addr		= dw_pcie_ep_map_addr,
>> +	.unmap_addr		= dw_pcie_ep_unmap_addr,
>> +	.set_msi		= dw_pcie_ep_set_msi,
>> +	.get_msi		= dw_pcie_ep_get_msi,
>> +	.raise_irq		= dw_pcie_ep_raise_irq,
>> +	.start			= dw_pcie_ep_start,
>> +	.stop			= dw_pcie_ep_stop,
>> +};
>> +
>> +void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>> +{
>> +	struct pci_epc *epc = ep->epc;
>> +
>> +	pci_epc_mem_exit(epc);
>> +}
>> +
>> +int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>> +{
>> +	int ret;
>> +	void *addr;
>> +	enum pci_barno bar;
>> +	struct pci_epc *epc;
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct device *dev = pci->dev;
>> +	struct device_node *np = dev->of_node;
>> +
>> +	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to read *num-ib-windows* property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to read *num-ob-windows* property\n");
>> +		return ret;
>> +	}
>> +
>> +	addr = devm_kzalloc(dev, sizeof(phys_addr_t) * ep->num_ob_windows,
>> +			    GFP_KERNEL);
>> +	if (!addr)
>> +		return -ENOMEM;
>> +	ep->outbound_addr = addr;
>> +
>> +	for (bar = BAR_0; bar <= BAR_5; bar++)
>> +		dw_pcie_ep_reset_bar(pci, bar);
>> +
>> +	if (ep->ops->ep_init)
>> +		ep->ops->ep_init(ep);
>> +
>> +	epc = devm_pci_epc_create(dev, &epc_ops);
>> +	if (IS_ERR(epc)) {
>> +		dev_err(dev, "failed to create epc device\n");
>> +		return PTR_ERR(epc);
>> +	}
>> +
>> +	ret = of_property_read_u8(np, "max-functions", &epc->max_functions);
>> +	if (ret < 0)
>> +		epc->max_functions = 1;
>> +
>> +	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to initialize address space\n");
>> +		return ret;
>> +	}
>> +
>> +	ep->epc = epc;
>> +	epc_set_drvdata(epc, ep);
>> +	dw_pcie_setup(pci);
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
>> index 686945d..49b28c8 100644
>> --- a/drivers/pci/dwc/pcie-designware.c
>> +++ b/drivers/pci/dwc/pcie-designware.c
>> @@ -173,6 +173,57 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>>  	dev_err(pci->dev, "iATU is not being enabled\n");
>>  }
>>  
>> +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>> +			     u64 cpu_addr, enum dw_pcie_as_type as_type)
>> +{
>> +	int type;
>> +	void __iomem *base = pci->dbi_base;
>> +
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
>> +			  PCIE_ATU_REGION_INBOUND | index);
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
>> +			  lower_32_bits(cpu_addr));
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
>> +			  upper_32_bits(cpu_addr));
>> +
>> +	switch (as_type) {
>> +	case DW_PCIE_AS_MEM:
>> +		type = PCIE_ATU_TYPE_MEM;
>> +		break;
>> +	case DW_PCIE_AS_IO:
>> +		type = PCIE_ATU_TYPE_IO;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4, PCIE_ATU_ENABLE |
>> +			  PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
>> +	return 0;
>> +}
>> +
> 
> This Atu programming is for PCI Cores <= 4.70. Please follow the same approach as:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/dwc/pcie-designware.c?h=pci/host-designware#n95

Okay. But *iatu_unroll_enabled* is being set in "if (!pp->ops->rd_other_conf)".
This ops is specific to RC. I think we should have some other mechanism to
detect if iatu is required or not.

Thanks
Kishon
