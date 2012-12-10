From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Dec 2012 12:18:43 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121210200350.0f930e27@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121210184439.GA4687@obsidianresearch.com>
 <20121210200350.0f930e27@skate>
Message-ID: <20121210191843.GB17336@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 08:03:50PM +0100, Thomas Petazzoni wrote:

> > 00:00.0 Host bridge: SOC software emulated host bridge
> > 00:01.1 PCI bridge: SOC software emulated PCI-E root port 1
> > 00:01.2 PCI bridge: SOC software emulated PCI-E root port 2
> > 00:02.0 Ethernet device..
> > 
> > With a tree like:
> >   00:00.0 -> 0:01.1
> >           -> 0:01.2 -> 00:02.0
> > 
> > Discovery is started from 00:00.0 and flows through all the ports in
> > one pass.
> 
> Hum, ok, this makes sense. I have no idea at the moment how to achieve
> that, but I'll try to have a look. Do you have pointers to code doing
> this?

I haven't studied the Linux code specifically for this, but a quick
perusal through the header file isn't showing up any existing support.

You'd have to confer with the PCI maintainers what they want, but a
possible way to start would be to fake the configuration query
results. This is already being done via a fixup to make the root port
report as a host bridge.

> > It sounds like the concept of a PCI-E bridge with internal
> > configuration could be generalized for more types of hardware that the
> > Marvell case. Pretty much all socs will have a similar design, a
> > number of PCI-E ports, a collection of address decoding/routing
> > windows and some registers to control them, someplace...
> 
> Indeed. But for example, in Marvell's case, the address decoding
> windows mechanism is not specific to PCIe, it is also used for other
> devices, so the management of those decoding windows cannot be entirely
> left to the PCIe driver.

Yes, though you might want to think about having the window numbers
assigned staticly (for PCI-E and everything else) in device tree
rather than all the dynamic code. It would be simpler to just run
through the configuration that device tree has..

The window stuff is causing me problems today, I'm looking at an
option to have to kernel not program any windows. The kernel destroys
the settings from the bootloader, which are more correct than what it
puts in - in practice this means my kexec flow doesn't work since I
can't re-enter the bootload because the kernel unmapped it.

Jason
