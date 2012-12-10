From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Dec 2012 10:52:33 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121207233317.GB4304@obsidianresearch.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
Message-ID: <50C62161.9080708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2012 04:33 PM, Jason Gunthorpe wrote:
> On Fri, Dec 07, 2012 at 11:04:23PM +0100, Thomas Petazzoni wrote:
> 
>>  * The most annoying problem is that when the hw_pci->setup()
>>    operation is called, we don't know the size of the memory and I/O
>>    regions that each PCI device will need. And on Marvell SoCs, for
>>    each PCI device, we have to set up an address decoding window that
>>    associates a portion of the physical address space with a given
> 
> I think a sane way to address this is to model the SOC as the root of
> the PCI-E and then model each of the ports as a non-compliant PCI-E
> bridge. The internal memory windows functionally map exactly to a
> PCI-E bridge memory window - just with annoyingly different register
> settings.

Mainly as background:

I /think/ Tegra has a similar HW setup (but perhaps not identical)
(based on a very brief reading of your emails and brief knowledge of
this aspect of the Tegra HW).

On Tegra, there is a 1GB physical address window that the PCIe
controller serves. The controller has 2 or 3 ports, each a separate PCIe
domain I believe. There are registers in the PCIe controller which route
accessed made to the 1GB physical window to the various child ports and
transaction types.

IIRC, the bindings Thierry came up with for the Tegra PCIe controller
statically describe the setup of those mappings (e.g. it could assign a
256MB physical address region to port 1, and a 768MB physical address
region to port 2 perhaps?).

It sounds like Jason is advocating a much more dynamic approach on the
Marvell HW. Perhaps this is related to whether the n host ports driven
by the controller are separate PCIe domains (as I believe they are or
can be on Tegra) or not.
