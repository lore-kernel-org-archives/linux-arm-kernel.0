From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 13 Mar 2013 16:22:01 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <5140E85A.3040900@firmworks.com>
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
Message-ID: <20130313222201.GA27252@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote:

> port hardware used the common programming model, with real config
> headers and stuff, 3/2 would be good because you could use existing
> drivers.  But since you need a special root-port driver anyway, why go
> to the trouble of emulating non-existent addressing?

Yes, I'm sorry, I've tried not to explore the complexity behind this
reasoning here.. Those discussions went on for a long time and I'm
tired of rehashing them :)

It isn't existing drivers that are valuable, it is the entire common
PCI infrastructure for dealing with discovery and address assignment
that is has value.

The common infrastructure can only allocate addresses within fixed
regions assigned to each PCI domain - and it divides those addreses
regions between ports in the root complex via the standard PCI-E root
port bridge memory windows.

Now, the largest SOC has 10 of the PCI-E ports in it, with 32 bit
addressing. It is essential that a small region of address space be
set aside for PCI-E use, and thus it is critical that resource
assignment be done across all ports, drawing on a common pool of
address space.

Thus two choices:
 1) Keep the PCI core the same and let the host bridge driver
    provide the missing configuration elements of the root
    complex
 2) Upgrade the PCI common core to deal with dynamic cross
    domain resource allocation, including hot plug.

Based on discussion/analysis #1 was chosen. Lots of reasons.

>From that choice flows the DT bindings, which are now required to
model the PCI bus 0.

Does that help explain the rational?

Cheers,
Jason
