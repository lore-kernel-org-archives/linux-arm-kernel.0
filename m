From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 26 Apr 2016 12:00:04 -0500
Subject: [PATCH v2 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
In-Reply-To: <20160426104208.150cbbd0@free-electrons.com>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160425154611.3e7e9dc9@free-electrons.com>
 <20160425172846.GB1759@localhost>
 <20160426104208.150cbbd0@free-electrons.com>
Message-ID: <20160426170004.GA27803@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 10:42:08AM +0200, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> On Mon, 25 Apr 2016 12:28:46 -0500, Bjorn Helgaas wrote:
> 
> > How about if you just shuffle those bits around into
> > an armada8k_add_pcie_port() and an armada8k_pcie_establish_link(), and
> > we'll call that good for now?
> 
> I just sent a v3 which implements this.
> 
> However, to be honest, after looking at the other drivers, I found the
> XYZ_add_pcie_port() function to not be very useful: it simply
> continues the work done by the probe function, and there is really no
> reason to split the remaining work of the probe() in a separate
> function. The XYZ_add_pcie_port() is called only one time for each
> probe() call, so having a separate function is somewhat useless. In
> addition, the separation of work between probe() and
> XYZ_add_pcie_port() is not very consistent accross drivers. In
> pci-imx6, XYZ_add_pcie_port() only sets up the interrupt handler and
> calls dw_pcie_host_init(). In pci-dra7xx, XYZ_add_pcie_port() sets up
> the interrupt, maps some registers and calls dw_pcie_host_init().
> 
> So my v3 implements what you suggested, and creates a
> armada8k_add_pcie_port() to make it consistent with the other drivers,
> but long term, I'm not sure this particular function is really useful.

I agree completely with everything you said.  I would be thrilled if
somebody were to make this more sensible, as long as we did it to
*all* the drivers, not just one.

I think things started out fairly simple, then diverged over time as
we added clocks, PHYs, MSI, etc.  It looks like we're going to have
more divergence for power management, suspend, hotplug, modules, etc.

Bjorn
