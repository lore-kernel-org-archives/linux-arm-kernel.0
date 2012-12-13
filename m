From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 13 Dec 2012 10:40:32 -0700
Subject: [RFC v1 08/16] arm: mvebu: the core PCIe driver
In-Reply-To: <201212131458.55020.arnd@arndb.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121212165833.6a35a6ec@skate>
 <20121212215138.GC11530@obsidianresearch.com>
 <201212131458.55020.arnd@arndb.de>
Message-ID: <20121213174032.GB14619@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 02:58:54PM +0000, Arnd Bergmann wrote:

> > Note that the Kirkwood/Orion stuff doesn't really do this right. It
> > just assigns a single interrupt to the port, which is the PEX
> > interrupt cause summary interrupt and provides no possibility to
> > access INTA/B/C/D which will break if you ever try to use a
> > multi-function device or a PCI bridge. It also doesn't monitor the
> > other PEX interrupt statuses to machine check when things go wrong on
> > the bus.
> 
> If the IntA to IntD lines are all on the same host interrupt, you
> might only need one line above and make the map-mask all zeroes.

Well, no that is where the existing stuff goes wrong..

Each of the four INTx's on each port need a dedicated linux interrupt
vector. Sharing interrupts is bad. The chip has dedicated cause and
mask bits so there is no reason to share.

To do this the pex driver has to allocate 4 irq descs per port, setup
a generic irq chip for the driver, use irq_set_chained_handler on the
summary interrupt in the main cause register and then decode the INTx
bits in the chained handler function. This is very straightforward and
very much worth doing.

Since this makes the entire interrupt mapping completely internal
to the driver there is no real need for the DT properties. The driver
just needs to hook the PCIe core to ensure it gets called when irq
translation happens across the root port bridge. This is very similar
to how an IOAPIC works in x86 land.

With PCIe there is no possible board specific variation of
interrupts. INTx messages are always in-band, and they are always
captured by the PEX's interrupt cause register. With no variation
there is no need to configure it in DT.

Jason
