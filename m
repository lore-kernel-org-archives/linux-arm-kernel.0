From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Dec 2012 11:44:39 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50C62161.9080708@wwwdotorg.org>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
Message-ID: <20121210184439.GA4687@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 10:52:33AM -0700, Stephen Warren wrote:
 
> On Tegra, there is a 1GB physical address window that the PCIe
> controller serves. The controller has 2 or 3 ports, each a separate PCIe
> domain I believe. There are registers in the PCIe controller which route
> accessed made to the 1GB physical window to the various child ports and
> transaction types.

Fundamentally this is similar to what Marvell did, the routing
registers are functionally identical to PCI-E bridges, but don't use
PCI-E standard configuration.

Look at how Intel models their PCI-E and you can see the same
functional elements:

00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family DRAM Controller (rev 09)
00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 1 (rev b4)
00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b4)
00:1c.6 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 7 (rev b4)
00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b4)

1c.x are *physical* PCI-E ports, while 00 represents the internal ring
bus. All of the above devices are on the CPU SOC.

The address decoding windows of the physical ports are configured via
standard PCI-E bridge configuration space accesses and control which
addresses from the internal ring bus go out the port, as well as which
bus number range the port handles. This the same function as the
address decoding windows, just expressed via a standard register
layout instead of as a SOC specific feature.

By providing actual PCI configuration space to control all this it is
automatically compatible with standard PCI configuration code.

The mistake these SOCs are making is not using standard PCI modeling
to describe their PCI functional blocks :|

What you'd want to see is the same arrangement as Intel:

00:00.0 Host bridge: SOC software emulated host bridge
00:01.1 PCI bridge: SOC software emulated PCI-E root port 1
00:01.2 PCI bridge: SOC software emulated PCI-E root port 2
00:02.0 Ethernet device..

With a tree like:
  00:00.0 -> 0:01.1
          -> 0:01.2 -> 00:02.0

Discovery is started from 00:00.0 and flows through all the ports in
one pass.

It is already the case we pretty much have a software emulated root
port, at least on Marvell the config space returned for the PCI-E port
is useless/wrong when in root port mode.

> IIRC, the bindings Thierry came up with for the Tegra PCIe controller
> statically describe the setup of those mappings (e.g. it could assign a
> 256MB physical address region to port 1, and a 768MB physical address
> region to port 2 perhaps?).

If you can't do full dynamic configuration, then I think at least the
allocation size per port needs to be in device tree.
 
> It sounds like Jason is advocating a much more dynamic approach on the
> Marvell HW. Perhaps this is related to whether the n host ports driven
> by the controller are separate PCIe domains (as I believe they are or
> can be on Tegra) or not.

Any system with multiple pci-e ports and non-PCI-E configuration
registers can be modeled like this.

It sounds like the concept of a PCI-E bridge with internal
configuration could be generalized for more types of hardware that the
Marvell case. Pretty much all socs will have a similar design, a
number of PCI-E ports, a collection of address decoding/routing
windows and some registers to control them, someplace...

Also note that a 'PCI domain' is a Linux concept, it refers to a PCI
bus tree that has bus numbers that can overlap with other busses in
the system. You only need this concept if you have more than 255 PCI
busses, and have a way to route configuration cycles to a specific
physical ports. It is generally much more understandable to just
assign unique PCI-E bus numbers to every bus and forgo domains..

Jason
