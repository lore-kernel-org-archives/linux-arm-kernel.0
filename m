From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Feb 2013 19:02:53 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130206175019.GA24248@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <2776630.gp5gC9tvLk@wuerfel>
 <20130131180249.GA30869@obsidianresearch.com>
 <201301312046.22560.arnd@arndb.de>
 <20130131224459.GA11846@obsidianresearch.com>
 <20130206175128.1b64196d@skate>
 <20130206170903.GA28198@obsidianresearch.com>
 <20130206181852.4eca53e3@skate>
 <20130206175019.GA24248@obsidianresearch.com>
Message-ID: <20130206190253.6583de6a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 6 Feb 2013 10:50:19 -0700, Jason Gunthorpe wrote:

> No.. PCI end devices are required to decode all 32 bits of address,
> less the bits requires for their allocation. So a device with 64 bytes
> of IO will match bits 31:6 and then use bits 5:0 for the internal
> register.
> 
> So a full 32 bit address is technically fine, according to the spec,
> however:
>  - The 32 bit decode is an optional feature on bridges
>  - Some devices are broken because x86 only uses the low 64k.

Thanks again for the great explanation, it is now clear to me.

> So for best compatibility it is ideal to put everything in the low
> 64k.
> 
> However, IO space really should not be used by anything except very
> legacy devices, so if the MMU business is a hassle for some reason I'd
> just go with the 64k aligned method.

Me too :-)

It's what is done on Kirkwood since a long time, and apparently hasn't
caused any trouble so far.

> > Why would you need to adjust the length? If Linux allocates a 2 MB
> > resource on a 1 MB boundary, we simply increase the start address to
> > the next 2 MB boundary, and that's it. Why would the length need to
> > change?
> 
> Well, lets say 3MB is the example. A 3mb region needs to fit inside a
> 4mb MBUS window. If you align the start to 4mb then the pci-e core
> needs to know that it can't use the extra 1mb covered by the mbus
> window. mbus windows must not overlap.

Grumble, grumble, you're right. I now understand. Need to think of it,
because the current pcibios_window_alignment() thing only allows to
adjust the start address if I'm correct. But I'll have a more detailed
look. Or maybe Russell can comment on this specific topic?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
