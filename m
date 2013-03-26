From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 26 Mar 2013 15:14:03 -0600
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <20130326214613.30fbdddf@skate>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303261707.41563.arnd@arndb.de> <20130326181754.33b89559@skate>
 <201303261838.23246.arnd@arndb.de> <20130326214613.30fbdddf@skate>
Message-ID: <20130326211403.GA5198@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 09:46:13PM +0100, Thomas Petazzoni wrote:

> To me, the topology of the hardware is really that a single device
> provides two features: the main interrupt controller and the MSI
> interrupt controller. But I will adapt to whatever DT binding you
> propose.

No.. the HW is a single device that provides an interrupt on register
write capability, so it ideally should be a single DT node..

The need to distinguish MSI vs IPI vs other usage is completely a side
effect of how Linux's IRQ and PCI layers are hooked together today.

> > I still wonder if the real solution shouldn't instead be to make the
> > irq domain code MSI aware. For instance, you don't really need a
> > cell to describe an interrupt because the interrupt number is

Some kind of generic way for an irq chip driver to say 'here, I can
provide some MSI interrupts' and then for the PCI layer to say 'irq
layer, find me a driver that can provision a MSI with XXX properties' ?

This need to stack an irq chip under a MSI is not something I think
the kernel has had to support before, so new common code is probably
needed...

The interrupt chip should not need to know what the ultimate consumer
of the interrupt capability will be, it just needs to tell the
consumer 'write D to physical address A and irq I will trigger'.

Jason
