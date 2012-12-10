From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 19:05:52 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50C62161.9080708@wwwdotorg.org>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org>
Message-ID: <20121210190552.74acbe5a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Warren,

On Mon, 10 Dec 2012 10:52:33 -0700, Stephen Warren wrote:

> Mainly as background:
> 
> I /think/ Tegra has a similar HW setup (but perhaps not identical)
> (based on a very brief reading of your emails and brief knowledge of
> this aspect of the Tegra HW).
> 
> On Tegra, there is a 1GB physical address window that the PCIe
> controller serves. The controller has 2 or 3 ports, each a separate PCIe
> domain I believe. There are registers in the PCIe controller which route
> accessed made to the 1GB physical window to the various child ports and
> transaction types.

On Marvell SoCs, this is even more flexible: you have 20 configurable
address decoding windows. For each of them, you can configure the base
address, size, and target device (i.e PCIe port x.y, NAND, or some
other devices). And since we have up to 10 PCIe interfaces, we really
don't want to over-allocate hundreds of MB of physical address space for
each device, since most of them need only a few dozens of KB.

> IIRC, the bindings Thierry came up with for the Tegra PCIe controller
> statically describe the setup of those mappings (e.g. it could assign a
> 256MB physical address region to port 1, and a 768MB physical address
> region to port 2 perhaps?).
> 
> It sounds like Jason is advocating a much more dynamic approach on the
> Marvell HW. Perhaps this is related to whether the n host ports driven
> by the controller are separate PCIe domains (as I believe they are or
> can be on Tegra) or not.

The code I'm proposing for the Marvell PCIe is already dynamic it
doesn't describe the addresses in the DT, but instead dynamically
allocates address decoding windows according to the number of PCIe
devices that are found.

However, I haven't found yet how to get, during the ARM pcibios
initialization, the memory size needed for each device, so that I could
size the address decoding windows correctly instead of over-allocating
them (currently I allocate SZ_64MB for each window, even for my e1000e
PCIe card that needs only SZ_32K of PCI memory space).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
