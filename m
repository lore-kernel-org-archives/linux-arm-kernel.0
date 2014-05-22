From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 May 2014 18:55:06 -0600
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on
 designware core driver
In-Reply-To: <537D37AA.5030303@ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <6048322.x3M3sdDEWO@wuerfel> <5374FD24.8000806@ti.com>
 <22200719.Jb5jnJylJH@wuerfel>
 <20140515183919.GC11650@obsidianresearch.com>
 <53751DDF.40304@ti.com>
 <20140515205210.GB14722@obsidianresearch.com>
 <3E54258959B69E4282D79E01AB1F32B704742133@DFLE11.ent.ti.com>
 <20140520170221.GA5130@obsidianresearch.com>
 <537D37AA.5030303@ti.com>
Message-ID: <20140522005506.GB17244@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 07:32:58PM -0400, Murali Karicheri wrote:

> >Not quite, it first scans the network checking the Maximum Payload Size
> >Supported (MPSS) for each device, and chooses the highest supported by
> >all as the MPS for all.

> Why highest? It should be lowest so that all on the bus can handle
> it??

Right, that is what 'chooses the highest supported by all' means.

> >PCI-E requires that an end point support all packets up to the MPS, so
> >if your bridge can't generate a 512 byte read response packet, then it
> >must not advertise a MPSS greater than 256 bytes.

> What is MPSS? Is it the payload size in a message TLP? I read the
> PCIe spec and find MRSS is the maxumum read request size. So memory
> reads completion data size is limited to this size, right? So for
> DMA from EP to RC can't be greater than what RC publishes.  Not sure
> how they are related?

MPSS is the maximum packet size supported for send or receive, it is
the absolute max capability of the port:

		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 unlimited
MPSS                      ^^^^^^^^^^^^^^^^^^^^^^^

MPS is then the largest packet the port will send or receive.

MRSS is the largest read the port will request.

		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
MPS                   ^^^^^^^^^^^^^^^^^^^^^^^
MRSS                                          ^^^^^^^^^^^^^^^^^^^^


It is a little confusing what MRSS > MPS means exactly, but at a
minimum if MRSS > MPS then the responding port must segment the read
reply into MPS sized TLPs.

> I have checked that root port is advertising 256 bytes for mrrs and
> 128 bytes for mps in the config space. So keystone pcie bridge is
> doing as expected.

What is the MPSS?

> In Keystone case, what I see is after  adding
> pcie_bus_configure_settings() with pci=pcie_bus_safe,
> I get following log.
> 
> [    1.988851] pcie_bus_configure_settings, config 1
> [    1.988860] pcie_bus_configure_set
> [    1.988879] pcieport 0000:00:00.0: Max Payload Size set to  256/
> 256 (was  128), Max Read Rq  512
> [    1.988887] pcie_bus_configure_set
> [    1.988921] pci 0000:01:00.0: Max Payload Size set to  256/ 256
> (was  128), Max Read Rq  512
> [    1.988928] pcie_bus_configure_set
> [    1.988961] pci 0000:01:00.1: Max Payload Size set to  256/ 256
> (was  128), Max Read Rq  512
> 
> So it is not limiting MRRS to 256 bytes.

Right, pcie_bus_safe is the option that doesn't really change
too much, it is assuming the firmware set everything up properly.

> With pci=pcie_bus_perf
> 
> [    1.985777] pcie_bus_configure_settings, config 2
> [    1.985783] pcie_bus_configure_set
> [    1.985810] pcieport 0000:00:00.0: Max Payload Size set to  256/
> 256 (was  128), Max Read Rq  256
> [    1.985818] pcie_bus_configure_set
> [    1.985875] pci 0000:01:00.0: Max Payload Size set to  256/ 256
> (was  128), Max Read Rq  256
> [    1.985882] pcie_bus_configure_set
> [    1.985939] pci 0000:01:00.1: Max Payload Size set to  256/ 256
> (was  128), Max Read Rq  256
> 
> Is this log what you expect?

Yes, that matches what the code seems to do.

> If MRSS is clamped to lowest, then this would work with out a quirk,
> and has to be unconditional (all cases, safe, performance etc).

Well, except in this is working around a defect in Keystone. There are
going to be potential problems no matter which route you take because
some drivers do blindly alter the MRRS, and when the core ARM code
starts calling pcie_bus_configure_settings() it will alter the MRRS as
well.

So, the quirk solution is only going to work in some cases.

Adding pci=pcie_bus_perf to the command line in the DTS as a work
around for the defect might be the most comprehensive option?

> I would like to go with the quirk approach until this discussion
> concludes the next step to fix this issue. May be someone can take
> owner ship of this change at PCI core level?

Well, the core code isn't wrong, it just isn't designed to address this
sort of HW defect.

Regards,
Jason
