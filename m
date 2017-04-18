From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 19 Apr 2017 08:43:36 +1000
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
In-Reply-To: <20170418154937.GA1006@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
 <1491917983.7236.9.camel@kernel.crashing.org>
 <20170412112022.GY17774@n2100.armlinux.org.uk>
 <20170418154937.GA1006@red-moon>
Message-ID: <1492555416.25766.97.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-18 at 16:49 +0100, Lorenzo Pieralisi wrote:
> I can do that yes, which already means I have to know if eg microblaze
> (drivers/pci/host/pcie-xilinx.c) can provide a mapping with nonposted
> writes semantics, otherwise it is a dead-end.
> 
> Another option would be going back to what v1 did, namely, to implement
> a pci_remap_cfgspace() interface (it is the _nopost() suffix that stirred
> debate - nobody would object to having a default pci_remap_cfgspace()
> implementation that defaults to ioremap_nocache(), I know Bjorn does not
> like it to be PCI specific, just adding an option on the table to make
> progress).

Well, it boils down again to the fact that a mapping attribute isn't
sufficient.

Let's say I'm microblaze and I can't do non-posted mapping. Then the
Host Bridge driver needs to *know* that so it can implement a different
workaround, such as reading back from some bridge register after every
config write which ensures the previous write reached its destination
for example, or whatever other IP specific mechanism.

Cheers,
Ben.
