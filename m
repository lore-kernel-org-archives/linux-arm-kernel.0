From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 7 Feb 2013 17:29:34 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130207181418.3753b007@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com> <20130207153750.0fef1192@skate>
 <20130207155117.GA19666@arm.com> <20130207171904.70270598@skate>
 <20130207174040.3a345770@skate> <20130207165347.GA31995@arm.com>
 <20130207181418.3753b007@skate>
Message-ID: <20130207172934.GA2811@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 05:14:18PM +0000, Thomas Petazzoni wrote:
> Dear Andrew Murray,
> 
> On Thu, 7 Feb 2013 16:53:47 +0000, Andrew Murray wrote:
> 
> > > So in fact the problem is indeed that the subnodes pcie0,0 and pcie1,0
> > > are seen as corresponding to the PCI-to-PCI bridges.
> > 
> > I would suggest changing the interrupt-mask to match any bus number. (Don't
> > forget that the secondary bus number of each of your emulated bridges will
> > vary depending on how many devices are detected underneath each root port,
> > assuming you don't try and partition bus numbers or use domains between ports).
> 
> I don't think this would work. Currently, the interrupt-map associates
> the interrupts with the PCI-to-PCI bridges, i.e devices 00:01, 00:02,
> 00:03, 00:04, 00:05, etc.
> 
> The real PCIe devices themselves are at 01:00, 02:00, 03:00, 04:00,
> 05:00. Each of them sit on a different bus, at devfn = 0.
> 
> So if I ignore the bus number, how could the PCI code find what is the
> matching interrupt?

Apologies if I've missed information about your hardware in the other
discussion (I've tried to keep up) - does your hardware raise a single host
interrupt for each pin regardless to which bridge they come in on - or do you
separate A,B,C,D host interrupts for each bridge?

If you have only 4 interrupt sources for legacy interrupts then you shouldn't
need to care which bus/device/function they were generated on (of_pci_map_irq
takes care of this for you).

During enumeration an interrupt number should be assigned to each requesting
device which reflects the pin (after swizzling) which will arrive at the host
bridges. That interrupt number should be shared across all devices that
requested the same pin (after swizzling) - i.e. shared interrupts. So all you
need to do is map A,B,C,D interrupts with the interrupt they come into the 
CPU.

Andrew Murray
> 
> Thanks,
> 
> Thomas
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
