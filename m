From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Feb 2014 11:12:21 +0100
Subject: [PATCH 1/3] PCI: designware: add legacy PCI interrupt mapping
In-Reply-To: <000101cf3452$f203ed60$d60bc820$%han@samsung.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <CAJ+vNU2Ea+hHZxcOBXfBEFtryJEzU+axCHRW2rOM8JedWROyTQ@mail.gmail.com>
 <000101cf3452$f203ed60$d60bc820$%han@samsung.com>
Message-ID: <201402281112.21998.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 28, 2014 at 08:01:46 AM, Jingoo Han wrote:
> On Friday, February 28, 2014 1:25 PM, Tim Harvey wrote:
> > On Thu, Feb 27, 2014 at 6:00 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > > On Friday, February 28, 2014 10:20 AM, Tim Harvey wrote:
> > >> The IMX6 maps INTA/B/C/D to ARM GIC IRQ 155/154/153/152 respectively.
> > >> This allows a PCIe-to-PCI bridge to function properly.
> > >> 
> > >> The irq field of the pcie_host struct is expanded to 4 interrupts to
> > >> allow for INTA/B/C/D and the IMX6 PCIe host driver will populate them
> > >> all from devicetree.  I'm not clear if the Exynos driver has this
> > >> capability so it places the same interrupt in all 4 slots.
> > > 
> > > (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I, Mohit KUMAR
> > > DCG)
> > > 
> > > In the case of Exynos,
> > > 'INTA/B/C/D' are mapped to only one interrupt (<0 20 0>).
> > > Thus, the current code works properly on Exynos platform.
> > > 
> > > There are three interrupts for Exynos PCIe; INTx, MSI, PHY Link,
> > > respectively as below.
> > > 
> > > ./arch/arm/boot/dts/exynos5440.dtsi
> > > 
> > >         interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> > > 
> > > <0 20 0>: PCIe RC0 pulse interrupt,
> > > 
> > >              INTA, INTB, INTC and INTD, etc
> > > 
> > > <0 21 0>: PCIe RC0 level interrupt,
> > > 
> > >              MSI, etc
> > > 
> > > <0 22 0>: PCIe RC0 special interrupt,
> > > 
> > >              PHY Link related interrupts, etc
> > > 
> > > Of course, legacy INTx is handled as message only.
> > > 
> > > Mohit, Kishon,
> > > How about the other SoCs? INTx is mapped to single interrupt
> > > such as Exynos, or separate interrupts such as i.MX6?
> > 
> > Jingoo,
> > 
> > Ok - so at least the I.MX6 and Exynos, which both use the designware
> > IP need different IRQ mappings.  It seems to me then that the map_irq
> > should be moved out of drivers/pci/host/pcie-designware.c and into the
> > SoC specific host controller drivers (pci-imx.c and pci-exynos.c).  If
> > that becomes the consensus I can submit a patch that does that.
> 
> (+CC Arnd Bergmann)
> 
> If you want to split dw_pcie_map_irq(), the following would be better.
> 
> ./drivers/pci/host/pcie-designware.c
> static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> {
> 	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> 
> 	if (pp->ops->writel_rc)
> 		return pp->ops->map_irq(pp, pin);
> 	else
> 		return pp->irq;
> }
> 
> ./drivers/pci/host/pci-imx6.c
> static int imx6_pcie_map_irq(struct pcie_port *pp, u8 pin)
> {
> 	.....
> }
> 
> Also, please add additional 'irq[4]' variable to 'struct imx6_pcie',
> instead of 'struct pcie_port'. Other SoCs does not use four separate
> INTx, as far as I know.

I agree with this.
