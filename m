From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Feb 2015 16:33:44 +0000
Subject: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
In-Reply-To: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150202163344.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 02:51:23PM +0000, Marc Zyngier wrote:
>  void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>  {
> -	dev_dbg(&dev->dev, "assigning IRQ %02d\n", irq);
> -	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
> +	struct irq_data *d;
> +
> +	d = irq_get_irq_data(irq);
> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> +	while (d->parent_data)
> +		d = d->parent_data;
> +#endif
> +	dev_dbg(&dev->dev, "assigning IRQ %02ld\n", d->hwirq);
> +	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, d->hwirq);

I'm really not convinced about this being the correct thing to do.

Let's take an older ARM system, such as a Footbridge based system with a
PCI southbridge.

Such a system has IRQs 0-15 as the PCI southbridge ISA interrupts.  Then
there are four PCI interrupts provided by the on-board Footbridge.

Right now, PCI devices are programmed with the OS specific interrupt
number - eg:

00:06.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80 [Master])
        Flags: medium devsel, IRQ 14
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00

00:06.2 IDE interface: Contaq Microsystems 82c693 (prog-if 00 [])
        Flags: medium devsel, IRQ 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 02 00 00

00:06.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])
        Flags: medium devsel, IRQ 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00

00:07.0 Mass storage controller: Integrated Technology Express, Inc. IT/ITE8212
Dual channel ATA RAID controller (rev 13)
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 24
30: 00 00 02 04 80 00 00 00 00 00 00 00 18 01 08 08

00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
        Flags: bus master, medium devsel, latency 32, IRQ 22
30: 00 00 06 04 dc 00 00 00 00 00 00 00 16 01 0a 0a

00:09.0 VGA compatible controller: S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX] (rev 16) (prog-if 00 [VGA controller])
        Flags: medium devsel, IRQ 21
30: 00 00 00 0c 00 00 00 00 00 00 00 00 15 01 00 00

What your change would mean is that the IRQs currently being programmed
>= 16 would be programmed into with numbers with 16 removed from them.
This means that legacy stuff (eg on the Southbridge which really do signal
via the ISA IRQ controller) end up using the same number range as those
which take PCI specific IRQs.

This surely is not sane.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
