From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 15:30:25 +0100
Subject: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <5693D0AE.4020306@codeaurora.org>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <20160111153949.GA2366@red-moon> <5693D0AE.4020306@codeaurora.org>
Message-ID: <4945809.OlUZI8D7JL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 January 2016 10:56:30 Sinan Kaya wrote:
> 
> #_dmesg_|_grep_resource
> [    2.945762] pci_bus 0000:00: root bus resource [io  0x0000-0xefff window] (bus address [0x1000-0xffff])
> [    3.652201] pci_bus 0002:00: root bus resource [io  0xf000-0x1dfff window] (bus address [0x1000-0xffff])
> [    6.546716] pci_bus 0006:00: root bus resource [io  0x1e000-0x2cfff window] (bus address [0x1000-0xffff])
> / #

This is bad. We normally want to stay out of the first 0x1000 bytes of the Linux space,
to prevent drivers from poking into the ISA registers.

We can have one of the buses be the "primary" bus that has its first 0x1000 bytes of
I/O space mapped into the respective Linux addresses, but mapping the second 0x1000
bytes into the reserved space is the worst possible outcome here, as legacy ISA
drivers will now poke at random other devices that are intentionally moved to
high addresses to stay of of that range.
 
> Since we are talking about what ACPI dictates vs. what kernel does. Here is something that got me 
> while testing.
> 
> Somebody sneaked in a 0x10003 upper limit on PCI addresses for some reason below. There is nothing magic
> about 0x10003 and I'm wonding why we have this limit.

I/O ports are at aligned addresses, the highest 4-byte address you can access
is 0xfffc with the default 0x10000 port limit per bus. This limit is generally
seen as sufficient because that is what x86 has. Most PCI devices have no I/O ports
at all, and the ones that have them have only a couple of bytes of address space
in it.

	Arnd
