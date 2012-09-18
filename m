From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 18 Sep 2012 20:53:22 +0200
Subject: [PATCH 2/2] ARM: pci: Allow passing per-controller private data
In-Reply-To: <CAErSpo591Ybuf95nU-O38=PrqtuJHWkWcce+5Owbc8YAprAUBw@mail.gmail.com>
References: <1347657078-32230-1-git-send-email-thierry.reding@avionic-design.de>
 <1347657078-32230-3-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo754W2TKr46V5FKwX43eusoOVjxkAWJ=kkB0BvRt_bJBw@mail.gmail.com>
 <20120918183428.GC29360@avionic-0098.mockup.avionic-design.de>
 <CAErSpo591Ybuf95nU-O38=PrqtuJHWkWcce+5Owbc8YAprAUBw@mail.gmail.com>
Message-ID: <20120918185322.GE29360@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 12:38:53PM -0600, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2012 at 12:34 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Tue, Sep 18, 2012 at 11:21:21AM -0600, Bjorn Helgaas wrote:
> >> On Fri, Sep 14, 2012 at 3:11 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > In order to allow drivers to specify private data for each controller,
> >> > this commit adds a private_data field to the struct hw_pci. This field
> >> > is an array of nr_controllers pointers that will be used to initialize
> >> > the private_data field of the corresponding controller's pci_sys_data
> >> > structure.
> >>
> >> I guess you aren't changing the design here because struct hw_pci
> >> already includes "nr_controllers," but having nr_controllers and a
> >> private_data[] array sounds like something that might make it hard to
> >> hot-add a host bridge after boot.
> >
> > What I do in the Tegra PCIe driver is to pass each of the root ports to
> > pci_common_init() individually because they can be enabled or disabled
> > by device tree data. I suppose to some degree you can consider that hot-
> > adding. Not that Tegra is likely to ever need to support that. I don't
> > know how likely it is for any ARM platform to ever need support for hot-
> > adding a host bridge.
> >
> > Eventually I think it would be advantageous for this to be generalized
> > further such that PCI initialization can be shared across architectures.
> > That's probably not an easy task so I was going to start by making
> > incremental changes that enable the Tegra code to work and, if time
> > allows, help further with subsequent improvements.
> >
> > It also seems that parts of the PCI core aren't ready yet for hot-adding
> > host bridges. One thing I came across while working on the Tegra code is
> > that MSI setup and teardown needs to be done by the arch_setup_msi_irq()
> > and arch_teardown_msi_irq() respectively, which are expected to be
> > builtin. That was also the last issue that keeps the Tegra PCIe driver
> > from being built as a module. I think that will also make it impossible
> > to hot-add host bridges. On x86 this seems to be handled by platform
> > code, but on Tegra for example MSI setup and teardown is tightly coupled
> > to the PCIe controller. That was one of the things I thought I could
> > take a look at eventually, but getting Tegra support cleaned up is
> > higher priority right now.
> 
> The PCI core doesn't support hot-add of host bridges yet, but there's
> a lot of work in that area right now, which is why it's on my mind :)
> I'm not suggesting you change anything here; just keep it in the back
> of your mind for the future.  Thanks for the arch_setup_msi_irq() tip;
> I'll look into that.

I think it wouldn't even be that hard to implement. When I last looked
at this it seemed like a simple registration mechanism in the core
should work. That is the core would keep a list of registered host
bridges, each of which would implement setup_msi() and teardown_msi()
operations. Then, whenever an MSI is requested, the core would look up
the corresponding host bridge and call the associated setup_msi()
callback. Perhaps these could go into struct pci_ops. It already has
pointers for configuration space access, which is also controller-
specific.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120918/185827fa/attachment.sig>
