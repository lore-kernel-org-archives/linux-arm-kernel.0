From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Dec 2012 17:34:50 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions
 in CONFIG_HAS_IOPORT
In-Reply-To: <20121211171610.01c2de16@pyramind.ukuu.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de>
 <20121211162647.GS14363@n2100.arm.linux.org.uk>
 <20121211171610.01c2de16@pyramind.ukuu.org.uk>
Message-ID: <20121211173450.GW14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 05:16:10PM +0000, Alan Cox wrote:
> > Correct.  If HAS_IOPORT is not selected then we are potentially missing
> > the dependent functions (because the platform has no IOPORT support) _or_
> > it does have ISA/PCI IO spaces _but_ they're not mappable via the
> > ioport_map() mechanism due to some non-linearity involved in the
> > translation.
> > 
> > To make that second point clear, that's platforms where:
> > 
> > 	ioport_map(addr + 4) != ioport_map(addr) + 4.
> 
> For inb/inw and friends this shouldn't matter.

Exactly, and you wouldn't be using inb/inw with ioport_map().

The problem comes when you end up trying to deal with stuff which
uses ioread{8,16} on ioport_map() cookies where it's assumed that
adding N to the cookie is the same as adding N to the port address.

Thankfully those platforms aren't going to be a part of the single
zImage project...
