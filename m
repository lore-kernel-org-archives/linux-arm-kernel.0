From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jul 2014 08:32:37 +0200
Subject: [PATCH v8 3/9] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <20140708224529.GB4980@e106497-lin.cambridge.arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <20140708212951.GA4555@google.com>
 <20140708224529.GB4980@e106497-lin.cambridge.arm.com>
Message-ID: <201407090832.37918.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 July 2014, Liviu Dudau wrote:
> > Maybe that assumption is guaranteed by OF, but it doesn't hold for ACPI;
> > ACPI can describe several I/O port apertures for a single bridge, each
> > associated with a different CPU physical memory region.
> 
> That is actually a good catch, I've completely missed the fact that
> io_range->pci_addr could be non-zero.

Hmm, that's what I thought in my initial review, but you convinced me
that it's actually correct later on, and I still believe it is. Maybe
now you got confused by your own code?

Please have another look, I think your code in pci_host_bridge_of_get_ranges
sufficiently handles the registration to the PCI code with the correct
io_offset. The only thing that we might want to add is to record the
PCI address along with the bridge->io_base: For the host driver to
set up the mapping window correctly, you either need both of them, or
you assume they are already set up.

	Arnd
