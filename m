From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 9 Jan 2018 16:14:36 -0600
Subject: [PATCH v2 3/7] PCI: aardvark: set host and device to the same
 MAX payload size
In-Reply-To: <20180109163918.5e46c1a1@windsurf.lan>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
 <20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <20180109163918.5e46c1a1@windsurf.lan>
Message-ID: <20180109221436.GE31640@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Lorenzo, who maintains this area now]

On Tue, Jan 09, 2018 at 04:39:18PM +0100, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> On Thu, 5 Oct 2017 12:31:02 -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 28, 2017 at 02:58:34PM +0200, Thomas Petazzoni wrote:
> > > From: Victor Gu <xigu@marvell.com>
> > > 
> > > Since the Aardvark does not implement a PCIe root bus,   
> > 
> > What exactly do you mean by "does not implement a PCIe root bus"?  I
> > assume there is still a hierarchy of PCI buses, and I assume the
> > hierarchy has a top-most ("root") bus.
> > 
> > Maybe there's no Root Port?  There are other systems that don't have
> > Root Ports, and we've made changes to accommodate that, e.g.,
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=1b8a6079015f
> 
> I'm trying to get back (finally) to this topic. Unfortunately, your
> branch has been rebased, and this commit no longer exists. Do you have
> an updated pointer about what you suggest to use for systems that don't
> have Root Ports ?

Sorry, about that; here's the upstream commit, FWIW:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ee8bdfb6568d

If the OS sees no Root Port (I haven't seen the full lspci or kernel
enumeration log, so I don't know what the topology actually is), I
assume you probably have some Endpoints that have valid Link
Capabilities, Control, and Status registers.  Those refer to the
downstream end of the Link, and the Root Port would normally have
corresponding registers that refer to the upstream end.

The lack of the Root Port means we can't do any management of those
top-level Links, so no ASPM, no MPS, no link width/speed management,
etc.

I see that advk_pcie_probe() calls pcie_bus_configure_settings() like
all other drivers, and ideally we would try to make that work just
like it does on other platforms.  The code is:

  pci_scan_root_bus_bridge(bridge);
  bus = bridge->bus;
  list_for_each_entry(child, &bus->children, node)
    pcie_bus_configure_settings(child);

This MPS setting is all strictly in the PCIe domain (it's not in the
Aardvark domain and shouldn't have any Aardvark dependencies), so I
would expect the core code to just work, modulo some possible
confusion if it expects to find a Root Port but doesn't.

Can you collect "lspci -vv" output and details about what currently
goes wrong?  Then we'd have something more concrete to talk about.

Bjorn
