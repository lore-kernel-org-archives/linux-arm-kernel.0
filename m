From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 10 Dec 2012 12:07:53 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121210195935.1b8a7797@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org> <20121210190552.74acbe5a@skate>
 <50C626E4.1010808@wwwdotorg.org> <20121210195935.1b8a7797@skate>
Message-ID: <20121210190753.GA17336@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 07:59:35PM +0100, Thomas Petazzoni wrote:

> That said, I suppose that what you're thinking of are PCIe bridges, is
> that correct? So those would allow to connect multiple PCIe devices on
> a single PCIe interface (for example PCIe 3.0 listed above). In that
> case, I suppose my address decoding window would have to have a size
> greater than or equal to the sum of the size of all BARs of the PCIe
> devices found on the downstream bus. Lior, could you confirm or infirm
> my statement?

You are correct, the SOC decoding window would have to match the
bridge configuration of the PCI-e bridge the port is hooked up to, and
the bridge configuration will extend across all the BARs of its
children devices. Note there are special alignment considerations for
PCI-E bridge windows - the Linux code handles all this though.

To support PCIe bridges you also will need to allocate a bus number
resource range to each port, along with the two memory and one IO
resource ranges. That should be in device tree too .. The current
Marvell drivers don't do this and the kernel complains:

pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]

Bus number ranges should be disjoint so we can avoid domains.

Jason
