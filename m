From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 13:02:46 -0700
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <513A3F4F.2090501@firmworks.com>
References: <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
Message-ID: <20130308200245.GC29435@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:

> >> http://www.spinics.net/lists/arm-kernel/msg228749.html
> 
> The example in that posting looks messed up to me.
> 
> 1) It has "reg = <0x0800 0 0 0 0>", but 0x0800 0 0  is not a valid
> address in the address space defined by its parent - because the form of
> the parent's ranges property indicates that it's a PCI-style address
> form.  0x0800 0 0 lacks the top bits that indicate non-relocatable and
> the type (I/O, memory, etc).

You need to review the OF PCI bindings to make sense of this.  The
subnodes are PCI devices. Those PCI devices show up in the
configuration space (ie lspci). They are the PCI root port bridges.

The reg value follows the OF PCI spec and has the configuration
address of the bridge. For the first port's bridge this address in
lspci format is 00:01.0 which encodes to <0x800 0 0>

The Linux OF PCI core uses the reg value in this format to match the
OF node in the DT to the PCI device node as it does PCI discovery.

> 2) The "@0,0" and "@1,0" suffixes do not correspond to the reg values
> <0x0800 0 0 0 0> and <0x1000 0 0 0 0> using any rule that I know.

@0,1,0 (bus,device,fn) could be more appropriate, but that is
cosmetic?

Jason
