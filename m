From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 15 May 2014 17:16:01 -0400 (EDT)
Subject: [RFC PATCH 06/10] usb: xhci: Add Tegra XHCI host-controller driver
In-Reply-To: <CAL1qeaHm7U2NVDeVZS-Tiz5ntkk4c13RR_1ws9MTYGGoGCOB5A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1405151709100.887-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 May 2014, Andrew Bresticker wrote:

> > This does not feel appropriate at all: Rather than creating a child device,
> > you should have a specific driver that hooks into functions exported
> > by the xhci core. See Documentation/driver-model/design-patterns.txt
> 
> This is how DWC3, currently the only in-tree non-PCI XHCI host driver,
> is structured - see drivers/usb/dwc3/host.c.  The recently proposed
> Armada XHCI driver [1] just adds clock support and a hook in
> xhci-plat's probe() to do the platform-specific initialization.
> Tegra's XHCI driver initialization is quite a bit more complicated,
> mainly due to the need for external firmware and specific ordering
> (e.g. firmware messages should only be enabled after the HCD is
> created).  I could do away with the xhci-plat sub-device and just
> create a Tegra hc_driver, but it seems silly to have three XHCI
> platform drivers structured in three different ways.  USB folks, do
> you have an opinion on how this should be done?

Felipe and I have differing opinions.  I prefer not to create an extra 
device level, and he does (that's why the non-PCI EHCI drivers don't do 
it and the dwc3 driver does).  I consider Felipe's approach to be an 
example of the "Midlayer Mistake" anti-pattern from the LWN 
article mentioned earlier in this thread -- I don't know what he thinks 
about my approach.

Anyway, unless I'm totally mistaken, you wouldn't end up with three
platform drivers structured in three different ways.  Either way, your
new driver would be structured like one of the existing two.

Alan Stern
