From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 17 Jul 2016 10:39:01 +0100 (BST)
Subject: [PATCH v0 06/10] arm: orion5x: Add DT-based support for Netgear
 WNR854T
In-Reply-To: <4290281.AD5Bhg23o6@wuerfel>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-7-git-send-email-jm@lentin.co.uk>
 <4290281.AD5Bhg23o6@wuerfel>
Message-ID: <alpine.DEB.2.11.1607170959090.19980@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Jul 2016, Arnd Bergmann wrote:

> On Saturday, July 16, 2016 3:29:04 PM CEST Jamie Lentin wrote:
>> +
>> +#define WNR854T_PCI_SLOT0_OFFS	7
>> +#define WNR854T_PCI_SLOT0_IRQ_PIN	4
>> +
>> +static void __init wnr854t_pci_preinit(void)
>> +{
>> +	int pin;
>> +
>> +	/*
>> +	 * Configure PCI GPIO IRQ pins
>> +	 */
>> +	pin = WNR854T_PCI_SLOT0_IRQ_PIN;
>> +	if (gpio_request(pin, "PCI Int") == 0) {
>> +		if (gpio_direction_input(pin) == 0) {
>> +			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
>> +		} else {
>> +			pr_err("wnr854t_pci_preinit failed to set_irq_type pin %d\n",
>> +				pin);
>> +			gpio_free(pin);
>> +		}
>> +	} else {
>> +		pr_err("wnr854t_pci_preinit failed to request gpio %d\n", pin);
>> +	}
>> +}
>> +
>> +static int __init wnr854t_pci_map_irq(const struct pci_dev *dev, u8 slot,
>> +	u8 pin)
>> +{
>> +	int irq;
>> +
>> +	/*
>> +	 * Check for devices with hard-wired IRQs.
>> +	 */
>> +	irq = orion5x_pci_map_irq(dev, slot, pin);
>> +	if (irq != -1)
>> +		return irq;
>> +
>> +	/*
>> +	 * PCI IRQs are connected via GPIOs
>> +	 */
>> +	switch (slot - WNR854T_PCI_SLOT0_OFFS) {
>> +	case 0:
>> +		return gpio_to_irq(WNR854T_PCI_SLOT0_IRQ_PIN);
>> +	default:
>> +		return -1;
>> +	}
>> +}
>
> The other patches all appear good to me, but I find this one suspicious.
>
> Why are you not using the device tree for probing PCI? Is there anything
> missing in drivers/pci/host/pci-mvebu.c, or do you just need help
> describing it in DT?

Unlike the other SoC's supported by pci-mvebu.c, orion5x has one PCI port 
as well as a PCIe port. Given no other orion5x boards seem to use 
pci-mvebu, I'm assuming there's work to be done before the PCI port can be 
used via. pci-mvebu.c

This is something I can look into if there aren't patches out there, but 
wanted to get the rest into a reasonable state first.

>
> 	Arnd
>

-- 
Jamie Lentin
