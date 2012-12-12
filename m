From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Dec 2012 17:04:17 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121210191843.GB17336@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121210184439.GA4687@obsidianresearch.com>
 <20121210200350.0f930e27@skate>
 <20121210191843.GB17336@obsidianresearch.com>
Message-ID: <20121212170417.0bff22e6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Mon, 10 Dec 2012 12:18:43 -0700, Jason Gunthorpe wrote:

> I haven't studied the Linux code specifically for this, but a quick
> perusal through the header file isn't showing up any existing support.
> 
> You'd have to confer with the PCI maintainers what they want, but a
> possible way to start would be to fake the configuration query
> results. This is already being done via a fixup to make the root port
> report as a host bridge.

So I should implement fake PCI configuration read/write operations, and
emulate a PCIe bridge? Sounds complicated...

> > Indeed. But for example, in Marvell's case, the address decoding
> > windows mechanism is not specific to PCIe, it is also used for other
> > devices, so the management of those decoding windows cannot be
> > entirely left to the PCIe driver.
> 
> Yes, though you might want to think about having the window numbers
> assigned staticly (for PCI-E and everything else) in device tree

Definitely not. We have a maximum of 20 address decoding windows, for
all devices. We have 10 PCIe interfaces, each might require 2 windows:
one for I/O BARs, one for memory BARs, that would make 20 windows, not
leaving any windows for other devices. Ditto for the size: if we create
10 windows for the 10 memory BARs of the 10 PCIe interfaces, with a
size of 128 MB, we "consume" 1.2 GB of physical address space, which we
definitely don't want to do. Older Marvell SoCs (Kirkwood) were doing a
static allocation of address decoding windows because there were only 2
PCIe interfaces. But now that there are 10 of them, this is clearly not
possible.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
