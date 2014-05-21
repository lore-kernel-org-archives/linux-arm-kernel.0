From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 20 May 2014 23:20:07 -0600
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <20140516095333.GE12341@arm.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4972763.mtuLYh6sDH@wuerfel> <20140515153430.GM27594@arm.com>
 <11787153.NWVGbVfAPV@wuerfel> <20140516095333.GE12341@arm.com>
Message-ID: <20140521052007.GA14888@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:53:33AM +0100, Will Deacon wrote:

> > Correct. Assume a PCI device uses PIO and DMA. It sends a DMA to main memory
> > and lets the CPU know about the data using a level (IntA as opposed to MSI)
> > interrupt. The CPU performs an outl() operation to an I/O port to let the
> > hardware know it has received the IRQ and the response of the outl() is
> > guaranteed to flush the DMA transaction: by the time the outl() completes
> > we know that the data in memory is valid because it is strongly ordered
> > relative to the DMA.

Keep in mind that the IntA message itself is going to flush the DMA,
no sane host bridge implementation should process the IntA until all
prior DMA writes are completed, just like MSI.

Also, legacy non-MSI interrupts are always sharable, so the ISR must
always start with a read of a device specific status reguster, which
will also flush any DMA writes.

The simplest common scenario to show synchronous outl is this:

void pci_isr()
{
   if (inl(status_reg) & INT_PENDING)
      outl(ACK_INT,status_reg);
}

Where the outl is not expected to complete at the CPU until the device
has lowered the level triggered interrupt line.

If outl is not synchronous then a spurious interrupt will be caused.

When converting a driver to MMIO you'd often have to do this:

void pci_isr()
{
   if (readl(status_reg) & INT_PENDING) {
      writel(ACK_INT,status_reg);
      readl(status_reg); // Synchronizing read, flushes write.
   }
}

Which is one of the software visible impacts of io vs mmio.

> Hmm, when you say `guaranteed to flush the DMA transaction', is that a PCI
> requirement? If so, whether or not that DMA data is then visible to the CPU
> is really specific to the host-controller implementation. It could easily be
> buffered somewhere between the host controller and memory, for example.

PCI has the producer/consumer ordering model as part of the
driving concept in the spec. Basically it wants to see the ordering
model preserved right to the driver code itself.

Realistically, way back, archs that couldn't do the synchronous IO
(like my old MIPS design) had to convert their drivers to MMIO and run
that way. It never worked 100% properly, or made sense to try an use an
async outl, even though some systems provided it :)

Jason
