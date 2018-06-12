From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 12 Jun 2018 10:06:34 -0700
Subject: [PATCH 2/6] PCI: iproc: Add INTx support with better modeling
In-Reply-To: <3ecc33ebe3db1f010f5c8938dfb87677@codeaurora.org>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
 <3ecc33ebe3db1f010f5c8938dfb87677@codeaurora.org>
Message-ID: <89adfced-75d6-9ad2-0a39-1fbdf9a33cb0@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/12/2018 1:52 AM, poza at codeaurora.org wrote:
> On 2018-05-30 03:28, Ray Jui wrote:
>> Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
>> modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
>> INTD share the same interrupt line connected to the GIC in the system,
>> while the status of each INTx can be obtained through the INTX CSR
>> register
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>> ?drivers/pci/host/pcie-iproc-platform.c |? 2 +
>> ?drivers/pci/host/pcie-iproc.c????????? | 95 
>> +++++++++++++++++++++++++++++++++-
>> ?drivers/pci/host/pcie-iproc.h????????? |? 6 +++
>> ?3 files changed, 101 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc-platform.c
>> b/drivers/pci/host/pcie-iproc-platform.c
>> index e764a2a..7a51e6c 100644
>> --- a/drivers/pci/host/pcie-iproc-platform.c
>> +++ b/drivers/pci/host/pcie-iproc-platform.c
>> @@ -70,6 +70,8 @@ static int iproc_pcie_pltfm_probe(struct
>> platform_device *pdev)
>> ???? }
>> ???? pcie->base_addr = reg.start;
>>
>> +??? pcie->irq = platform_get_irq(pdev, 0);
>> +
>> ???? if (of_property_read_bool(np, "brcm,pcie-ob")) {
>> ???????? u32 val;
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c 
>> b/drivers/pci/host/pcie-iproc.c
>> index 14f374d..0bd2c14 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -14,6 +14,7 @@
>> ?#include <linux/delay.h>
>> ?#include <linux/interrupt.h>
>> ?#include <linux/irqchip/arm-gic-v3.h>
>> +#include <linux/irqchip/chained_irq.h>
>> ?#include <linux/platform_device.h>
>> ?#include <linux/of_address.h>
>> ?#include <linux/of_pci.h>
>> @@ -264,6 +265,7 @@ enum iproc_pcie_reg {
>>
>> ???? /* enable INTx */
>> ???? IPROC_PCIE_INTX_EN,
>> +??? IPROC_PCIE_INTX_CSR,
>>
>> ???? /* outbound address mapping */
>> ???? IPROC_PCIE_OARR0,
>> @@ -305,6 +307,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
>> ???? [IPROC_PCIE_CFG_ADDR]??????? = 0x1f8,
>> ???? [IPROC_PCIE_CFG_DATA]??????? = 0x1fc,
>> ???? [IPROC_PCIE_INTX_EN]??????? = 0x330,
>> +??? [IPROC_PCIE_INTX_CSR]??????? = 0x334,
>> ???? [IPROC_PCIE_LINK_STATUS]??? = 0xf0c,
>> ?};
>>
>> @@ -316,6 +319,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
>> ???? [IPROC_PCIE_CFG_ADDR]??????? = 0x1f8,
>> ???? [IPROC_PCIE_CFG_DATA]??????? = 0x1fc,
>> ???? [IPROC_PCIE_INTX_EN]??????? = 0x330,
>> +??? [IPROC_PCIE_INTX_CSR]??????? = 0x334,
>> ???? [IPROC_PCIE_OARR0]??????? = 0xd20,
>> ???? [IPROC_PCIE_OMAP0]??????? = 0xd40,
>> ???? [IPROC_PCIE_OARR1]??????? = 0xd28,
>> @@ -332,6 +336,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>> ???? [IPROC_PCIE_CFG_ADDR]??????? = 0x1f8,
>> ???? [IPROC_PCIE_CFG_DATA]??????? = 0x1fc,
>> ???? [IPROC_PCIE_INTX_EN]??????? = 0x330,
>> +??? [IPROC_PCIE_INTX_CSR]??????? = 0x334,
>> ???? [IPROC_PCIE_OARR0]??????? = 0xd20,
>> ???? [IPROC_PCIE_OMAP0]??????? = 0xd40,
>> ???? [IPROC_PCIE_OARR1]??????? = 0xd28,
>> @@ -782,9 +787,90 @@ static int iproc_pcie_check_link(struct 
>> iproc_pcie *pcie)
>> ???? return link_is_active ? 0 : -ENODEV;
>> ?}
>>
>> -static void iproc_pcie_enable(struct iproc_pcie *pcie)
>> +static int iproc_pcie_intx_map(struct irq_domain *domain, unsigned 
>> int irq,
>> +?????????????????? irq_hw_number_t hwirq)
>> ?{
>> +??? irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>> +??? irq_set_chip_data(irq, domain->host_data);
>> +
>> +??? return 0;
>> +}
>> +
>> +static const struct irq_domain_ops intx_domain_ops = {
>> +??? .map = iproc_pcie_intx_map,
>> +};
>> +
>> +static void iproc_pcie_isr(struct irq_desc *desc)
>> +{
>> +??? struct irq_chip *chip = irq_desc_get_chip(desc);
>> +??? struct iproc_pcie *pcie;
>> +??? struct device *dev;
>> +??? unsigned long status;
>> +??? u32 bit, virq;
>> +
>> +??? chained_irq_enter(chip, desc);
>> +??? pcie = irq_desc_get_handler_data(desc);
>> +??? dev = pcie->dev;
>> +
>> +??? /* go through INTx A, B, C, D until all interrupts are handled */
>> +??? while ((status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR) &
>> +??????? SYS_RC_INTX_MASK) != 0) {
>> +??????? for_each_set_bit(bit, &status, PCI_NUM_INTX) {
>> +??????????? virq = irq_find_mapping(pcie->irq_domain, bit + 1);
>> +??????????? if (virq)
>> +??????????????? generic_handle_irq(virq);
>> +??????????? else
>> +??????????????? dev_err(dev, "unexpected INTx%u\n", bit);
>> +??????? }
>> +??? }
>> +
> 
> Are these level or edge interrupts ? although I see DT says: IRQ_TYPE_NONE

DT entries should be fixed to trigger on level HIGH like Florian and I 
discussed on the mailing list yesterday. It looks like you are missing a 
lot of discussions on the mailing list. Could you please help to make 
sure you read all the existing discussions when commenting on a patch?

> do you not need to clear interrupt status bits in IPROC_PCIE_INTX_CSR ?
> 

RO
