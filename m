From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Tue, 7 Mar 2017 11:10:09 +0000
Subject: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
In-Reply-To: <58BE42B2.20305@ti.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com> <58BE42B2.20305@ti.com>
Message-ID: <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Kishon,

?s 5:18 AM de 3/7/2017, Kishon Vijay Abraham I escreveu:
> Hi Joao,
> 
> On Friday 17 February 2017 10:50 PM, Joao Pinto wrote:
>> ?s 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
>>> Add endpoint mode support to designware driver. This uses the
>>> EP Core layer introduced recently to add endpoint mode support.
>>> *Any* function driver can now use this designware device
>>> in order to achieve the EP functionality.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/pci/dwc/Kconfig              |    5 +
>>>  drivers/pci/dwc/Makefile             |    1 +
>>>  drivers/pci/dwc/pcie-designware-ep.c |  342 ++++++++++++++++++++++++++++++++++
>>>  drivers/pci/dwc/pcie-designware.c    |   51 +++++
>>>  drivers/pci/dwc/pcie-designware.h    |   72 +++++++
>>>  5 files changed, 471 insertions(+)
>>>  create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
>>>
> 
> <snip>
> 
>>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
>>> index 686945d..49b28c8 100644
>>> --- a/drivers/pci/dwc/pcie-designware.c
>>> +++ b/drivers/pci/dwc/pcie-designware.c
>>> @@ -173,6 +173,57 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>>>  	dev_err(pci->dev, "iATU is not being enabled\n");
>>>  }
>>>  
>>> +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>>> +			     u64 cpu_addr, enum dw_pcie_as_type as_type)
>>> +{
>>> +	int type;
>>> +	void __iomem *base = pci->dbi_base;
>>> +
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
>>> +			  PCIE_ATU_REGION_INBOUND | index);
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
>>> +			  lower_32_bits(cpu_addr));
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
>>> +			  upper_32_bits(cpu_addr));
>>> +
>>> +	switch (as_type) {
>>> +	case DW_PCIE_AS_MEM:
>>> +		type = PCIE_ATU_TYPE_MEM;
>>> +		break;
>>> +	case DW_PCIE_AS_IO:
>>> +		type = PCIE_ATU_TYPE_IO;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4, PCIE_ATU_ENABLE |
>>> +			  PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
>>> +	return 0;
>>> +}
>>> +
>>
>> This Atu programming is for PCI Cores <= 4.70. Please follow the same approach as:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_cgit_linux_kernel_git_helgaas_pci.git_tree_drivers_pci_dwc_pcie-2Ddesignware.c-3Fh-3Dpci_host-2Ddesignware-23n95&d=DwID-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=MqqHFJBR0jj9ZQILcUJEd-CQkTihuOSf69e-XxZJvRs&s=fY5N7Mt9iszsAI04DPm-cSC6cSE5P2axHUFQ9GOx-2A&e= 
> 
> Can you provide PCIE_GET_ATU_INB_UNR_REG_OFFSET (similar to
> PCIE_GET_ATU_OUTB_UNR_REG_OFFSET)?

Yes of course, I will send you the definition soon.

Thanks,
Joao

> 
> Thanks
> Kishon
> 
