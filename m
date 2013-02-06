From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Feb 2013 11:39:49 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <51129F6B.1050709@wwwdotorg.org>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <2776630.gp5gC9tvLk@wuerfel>
 <20130131180249.GA30869@obsidianresearch.com>
 <201301312046.22560.arnd@arndb.de>
 <20130131224459.GA11846@obsidianresearch.com>
 <20130206175128.1b64196d@skate>
 <20130206170903.GA28198@obsidianresearch.com>
 <20130206181852.4eca53e3@skate>
 <20130206175019.GA24248@obsidianresearch.com>
 <51129F6B.1050709@wwwdotorg.org>
Message-ID: <20130206183949.GA7055@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 11:22:35AM -0700, Stephen Warren wrote:

> > No.. PCI end devices are required to decode all 32 bits of address,
> > less the bits requires for their allocation. So a device with 64 bytes
> > of IO will match bits 31:6 and then use bits 5:0 for the internal
> > register.
> 
> Didn't Arnd say (earlier this thread) that PCI devices using IO BARs
> were probably fairly legacy and hence might be buggy and might not obey
> that rule? Now, I'd guess it's safe within the first 64k of IO space
> though, so perhaps he was only talking about IO BAR bases >= 64k being
> dubious? That would imply a device might only use bits 15:6 for matching
> the BAR base and 5:0 for the internal register for a 64-byte BAR.

Right, that is what I was referring to when I said:

> - Some devices are broken because x86 only uses the low 64k.

Fortunately on PCI-E IO TLPs will be fully routed before they are sent
down a link, so downstream of a PCI-E link we will never see aliasing
of the low 16 bits.

This means if you do bridge to legacy PCI, and you do use devices that
don't decode the upper 16 bits that it will still work OK, because the
low 16 bits on the legacy PCI bus will still be unique in each device
on that bus.

That doesn't save you from weird legacy ISA stuff, or stuff that
doesn't respect the BARs, or other crazyness..

My personal hope would be that nobody using a PCI-E ARM SOC ever has
to deal with anything to do with IO space ;)

Jason
