From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 15 May 2014 14:52:10 -0600
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on
 designware core driver
In-Reply-To: <53751DDF.40304@ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <6048322.x3M3sdDEWO@wuerfel> <5374FD24.8000806@ti.com>
 <22200719.Jb5jnJylJH@wuerfel>
 <20140515183919.GC11650@obsidianresearch.com>
 <53751DDF.40304@ti.com>
Message-ID: <20140515205210.GB14722@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 04:04:47PM -0400, Murali Karicheri wrote:

> Jason What you mean by "The PCI core handles setting the maximum
> read request size already" I see there is function pcie_write_mrrs()
> in the drivers/pci/probe.c that reads the mps using pcie_get_mps()
> and then set mrrs to mps. But this function is called only from
> pcie_bus_configure_set() that is called by
> pcie_bus_configure_settings()

Right, that is the common code that correctly sets the MRRS that you
should be using instead of quirks.

> None of them gets called on ARM platform.

Hmm, a cursory glance tells me the same as well.

That seems to be the root problem here, ARM needs to do the PCIE
setup just as much as any other arch.

So, I would prefer to see you fix ARM common code to call
pcie_bus_configure_settings() properly, that seems very simple and is
obviously needed for any PCI-E host driver on ARM.

Thoughts? Arnd? Bjorn?

Jason
