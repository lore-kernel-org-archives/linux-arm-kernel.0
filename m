From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 17 Jun 2016 18:36:12 -0500
Subject: [PATCH] PCI: mvebu: Don't try to add an MBus window that already
 exists
In-Reply-To: <20160603093042.26e325d1@free-electrons.com>
References: <20160602125247.17566-1-sr@denx.de>
 <20160602151818.0989ee50@free-electrons.com>
 <57511C4E.5040501@denx.de>
 <20160603093042.26e325d1@free-electrons.com>
Message-ID: <20160617233612.GC21200@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 09:30:42AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 3 Jun 2016 07:57:34 +0200, Stefan Roese wrote:
> 
> > > The pci-mvebu driver deletes the MBus windows for a given PCI device
> > > when invalid memory base/limits are set in the emulated PCI bridge.
> > > Shouldn't this happen over a rescan?  
> > 
> > I'm not sure what *should* happen upon rescan. But testing shows, that
> > no MBus window is removed upon rescan. I just tested what happens,
> > if the PCI devices are "removed" via sysfs. And this also does not
> > delete any of the MBus windows.
> 
> Then maybe that's a question for the PCI folks. Is it normal that when
> a PCI device gets removed, the configuration of the PCI bridge does not
> get adjusted accordingly?

I'm not sure I completely understand the question.

When a PCI device is removed, I don't think we touch any upstream
devices.  The device is gone; there's no reason to change any bridge
windows leading to it.

When we rescan, we should try to assign resources to BARs of any new
devices we find.  Theoretically that could involve configuring windows
of upstream bridges, but I don't think we actually do that, because
we'd have to be careful not to break any active devices, and I don't
think we're smart enough for that.

Bjorn
