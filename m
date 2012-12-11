From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Dec 2012 16:26:47 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions
 in CONFIG_HAS_IOPORT
In-Reply-To: <201212111043.50627.arnd@arndb.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de>
Message-ID: <20121211162647.GS14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 10:43:49AM +0000, Arnd Bergmann wrote:
> On Friday 07 December 2012, Thomas Petazzoni wrote:
> > The pcim_*() functions are used by the libata-sff subsystem, and this
> > subsystem is used for many SATA drivers on ARM platforms that do not
> > necessarily have I/O ports.
> 
> I think this one is wrong as the CONFIG_HAS_IOPORT does not refer to the
> presence of PIO ports but to whether or not they provide an ioport_map
> function. If there is no ioport_map(), devm_pci_iomap will fail to link
> as far as I can tell.

Correct.  If HAS_IOPORT is not selected then we are potentially missing
the dependent functions (because the platform has no IOPORT support) _or_
it does have ISA/PCI IO spaces _but_ they're not mappable via the
ioport_map() mechanism due to some non-linearity involved in the
translation.

To make that second point clear, that's platforms where:

	ioport_map(addr + 4) != ioport_map(addr) + 4.
