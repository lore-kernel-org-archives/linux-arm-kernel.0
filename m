From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 20:03:50 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121210184439.GA4687@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
 <20121210184439.GA4687@obsidianresearch.com>
Message-ID: <20121210200350.0f930e27@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Mon, 10 Dec 2012 11:44:39 -0700, Jason Gunthorpe wrote:

> Fundamentally this is similar to what Marvell did, the routing
> registers are functionally identical to PCI-E bridges, but don't use
> PCI-E standard configuration.
> 
> Look at how Intel models their PCI-E and you can see the same
> functional elements:
> 
> 00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family DRAM Controller (rev 09)
> 00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 1 (rev b4)
> 00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 5 (rev b4)
> 00:1c.6 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 7 (rev b4)
> 00:1c.7 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 8 (rev b4)
> 
> 1c.x are *physical* PCI-E ports, while 00 represents the internal ring
> bus. All of the above devices are on the CPU SOC.
> 
> The address decoding windows of the physical ports are configured via
> standard PCI-E bridge configuration space accesses and control which
> addresses from the internal ring bus go out the port, as well as which
> bus number range the port handles. This the same function as the
> address decoding windows, just expressed via a standard register
> layout instead of as a SOC specific feature.
> 
> By providing actual PCI configuration space to control all this it is
> automatically compatible with standard PCI configuration code.
> 
> The mistake these SOCs are making is not using standard PCI modeling
> to describe their PCI functional blocks :|
> 
> What you'd want to see is the same arrangement as Intel:
> 
> 00:00.0 Host bridge: SOC software emulated host bridge
> 00:01.1 PCI bridge: SOC software emulated PCI-E root port 1
> 00:01.2 PCI bridge: SOC software emulated PCI-E root port 2
> 00:02.0 Ethernet device..
> 
> With a tree like:
>   00:00.0 -> 0:01.1
>           -> 0:01.2 -> 00:02.0
> 
> Discovery is started from 00:00.0 and flows through all the ports in
> one pass.

Hum, ok, this makes sense. I have no idea at the moment how to achieve
that, but I'll try to have a look. Do you have pointers to code doing
this?

> It sounds like the concept of a PCI-E bridge with internal
> configuration could be generalized for more types of hardware that the
> Marvell case. Pretty much all socs will have a similar design, a
> number of PCI-E ports, a collection of address decoding/routing
> windows and some registers to control them, someplace...

Indeed. But for example, in Marvell's case, the address decoding
windows mechanism is not specific to PCIe, it is also used for other
devices, so the management of those decoding windows cannot be entirely
left to the PCIe driver.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
