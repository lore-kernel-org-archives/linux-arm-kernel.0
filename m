From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Dec 2012 17:03:38 +0100
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <201212111043.50627.arnd@arndb.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de>
Message-ID: <20121211170338.4859ddf0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 11 Dec 2012 10:43:49 +0000, Arnd Bergmann wrote:
> On Friday 07 December 2012, Thomas Petazzoni wrote:
> > The pcim_*() functions are used by the libata-sff subsystem, and this
> > subsystem is used for many SATA drivers on ARM platforms that do not
> > necessarily have I/O ports.
> 
> I think this one is wrong as the CONFIG_HAS_IOPORT does not refer to the
> presence of PIO ports but to whether or not they provide an ioport_map
> function. If there is no ioport_map(), devm_pci_iomap will fail to link
> as far as I can tell.

The problem is that on ARCH_MULTI_V7, ARCH_VEXPRESS is forcefully
enabled. And ARCH_VEXPRESS selects NO_IOPORT.. so you don't have the
pcim_*() functions, and therefore libata-sff.c (needed for many SATA
drivers) will not build. How do you solve this?

I'm not sure which devm_pci_iomap() you're referring to since my patch
makes only the pcim_iomap_table(), pcim_iomap(), pcim_iounmap(),
pcim_iomap_regions(), pcim_iomap_regions_request_all() and
pcim_iounmap_regions() available under CONFIG_PCI instead of CONFIG_PCI
&& CONFIG_HAS_IOPORT.

So maybe you were referring to pcim_iomap(). I haven't checked in
details, but I guess it builds because ioport_map() is implemented in
arch/arm/mm/iomap.c.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
