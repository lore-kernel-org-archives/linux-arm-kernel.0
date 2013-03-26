From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 22:41:23 +0100
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <20130326211403.GA5198@obsidianresearch.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303261707.41563.arnd@arndb.de> <20130326181754.33b89559@skate>
 <201303261838.23246.arnd@arndb.de> <20130326214613.30fbdddf@skate>
 <20130326211403.GA5198@obsidianresearch.com>
Message-ID: <20130326224123.2526124b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 26 Mar 2013 15:14:03 -0600, Jason Gunthorpe wrote:
> On Tue, Mar 26, 2013 at 09:46:13PM +0100, Thomas Petazzoni wrote:
> 
> > To me, the topology of the hardware is really that a single device
> > provides two features: the main interrupt controller and the MSI
> > interrupt controller. But I will adapt to whatever DT binding you
> > propose.
> 
> No.. the HW is a single device that provides an interrupt on register
> write capability, so it ideally should be a single DT node..

No, here you're only talking about the interrupt on register write
capability (used for doorbells), but the interrupt controller is also
used for all other devices. Not only IPIs and MSIs are handled by this
piece of code.

> The need to distinguish MSI vs IPI vs other usage is completely a side
> effect of how Linux's IRQ and PCI layers are hooked together today.

Yes. And since I live in today's world, I try to adapt somewhat to
it :-)

> > > I still wonder if the real solution shouldn't instead be to make the
> > > irq domain code MSI aware. For instance, you don't really need a
> > > cell to describe an interrupt because the interrupt number is
> 
> Some kind of generic way for an irq chip driver to say 'here, I can
> provide some MSI interrupts' and then for the PCI layer to say 'irq
> layer, find me a driver that can provision a MSI with XXX properties' ?
> 
> This need to stack an irq chip under a MSI is not something I think
> the kernel has had to support before, so new common code is probably
> needed...
> 
> The interrupt chip should not need to know what the ultimate consumer
> of the interrupt capability will be, it just needs to tell the
> consumer 'write D to physical address A and irq I will trigger'.

I honestly don't see much difference between what you're saying here
and what the proposed code is doing. The IRQ driver says "hay, I
provide two IRQ domains, one is named mpic, one is named msi". And then
all the regular devices have interrupt-parent = <&mpic> to say "I use
legacy interrupts from that controller", and the PCIe controller has
msi-parent = <&msi> to say "I use MSI interrupt from that controller".

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
