From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Dec 2012 22:20:03 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211172916.2668a5be@pyramind.ukuu.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121211173819.6f2cf32b@skate>
 <20121211172916.2668a5be@pyramind.ukuu.org.uk>
Message-ID: <201212112220.04597.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 December 2012, Alan Cox wrote:
> The "no I/O space" case really applies to things like the S/390 mainframe
> which simply have no such concept on the system or the devices. In the
> ARM case the bus has an I/O space and the bridge glues the processors
> simpler model to the bridge model.

While we are getting slightly offtopic, s390 is actually gaining PCI support
now: https://patchwork.kernel.org/patch/1740231/ For all I can tell, they
would theoretically support an I/O space, but none of the supported
add-on cards use it, so the kernel implementation doesn't need to bother.

One architecture that never has an I/O space is the arch/um, but that is
special in a lot of ways, e.g. since it also never has MMIO.

On ARM, we have platforms that fall into four categories:

1. Full PCI or PCMCIA or ISA support with directly mapped I/O space

2. No PCI or PCMCIA or ISA support, and consequently no I/O space

3. PCI support but no I/O space because of limitations or bugs in
   the PCI hardware implementation.

4. ISA-style I/O space that is not offsettable (CONFIG_NO_IOPORT)
   but still has inb/outb accessors.

For cases 2 and 3, we can undefine the __io() macro, which leads to
intentional build errors someone tries to build code that uses the
inb/outb accessors. One missing piece that I have been working on
in the past and been meaning to pick up again is a patch set to
globally rename CONFIG_NO_IOPORT to the more appropriate
CONFIG_NO_IOPORT_MAP, and introduce a new CONFIG_NO_IOPORT that
signifies whether inb/outb are supported or not, rather than whether
you can access the I/O ports through ioport_map() and ioread/iowrite.

	Arnd
