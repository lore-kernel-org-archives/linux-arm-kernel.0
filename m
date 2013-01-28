From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Jan 2013 15:16:52 -0700
Subject: [PATCH v2 08/27] pci: implement an emulated PCI-to-PCI bridge
In-Reply-To: <5106F668.60605@wwwdotorg.org>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130128193516.GB17722@obsidianresearch.com>
 <20130128203947.07332698@skate>
 <20130128195501.GD17722@obsidianresearch.com>
 <5106F668.60605@wwwdotorg.org>
Message-ID: <20130128221652.GB21446@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 03:06:32PM -0700, Stephen Warren wrote:
> On 01/28/2013 12:55 PM, Jason Gunthorpe wrote:
> > On Mon, Jan 28, 2013 at 08:39:47PM +0100, Thomas Petazzoni wrote:
> > 
> >>> In the Marvell case, this capability can be constructed by pulling
> >>> data from the the Express End Point capability of the PCI-E port:
> >>
> >> I am not sure what you mean by "pulling". Do you mean that I should get
> >> informations from the real PCIe interface, from within the emulated
> >> PCI-to-PCI bridge implementation? This would unfortunately not be
> >> really nice, because until now, the PCI-to-PCI bridge emulation is
> >> clearly separated from the Marvell PCIe driver itself. Of course, it
> >> could register a hook or something like that, so that the emulated
> >> PCI-to-PCI bridge could potentially call back into the Marvell PCIe
> >> driver.
> > 
> > Yes, a callback would be needed to the main driver and IIRC the driver
> > can read/write the end port link info config regsiters via MMIO. They
> > probably need a bit of massaging to be in root port format, but
> > otherwise it should be straightforward..
> > 
> >> I'll have to dig a little bit more about this capability to see how it
> >> works exactly.
> > 
> > All ports have registers to report and control the link, but the root
> > port and end port versions are a bit different, so the goal is to read
> > the end port formatted registers and map them into the root port
> > format so that userspace can properly see the link state and
> > configuration.
> 
> Isn't the thing being emulated here a host bridge, which "contains" the
> PCIe root ports underneath, which in turn "contain" the PCIe devices
> underneath? At least on Tegra, there is no host bridge device that
> exposes PCIe config registers, but the PCIe root ports do exist and do
> expose PCIe config registers...

Patch #7 create a SW emulated host bridge, which tegra and marvell
lack in HW.

Patch #8 creates a SW emulated root port bridge, which tegra has
properly in HW, while Marvell doesn't.

Basically, on the Marvell chips, the PCI config space of the PCI
complex is useless when used as a root complex - the config space is
only usable when the device is configured as an end port.

Jason
