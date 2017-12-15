From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 15 Dec 2017 14:14:34 -0600
Subject: [PATCH v3 3/8] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
In-Reply-To: <CANCKTBvFhHb57JdG01aiSypBAcUeLzY3Dhuh5xP-_F5k_NcAhA@mail.gmail.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-4-git-send-email-jim2101024@gmail.com>
 <20171212221642.GB95453@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvtqNWZYXpLdUnEWwA2=14XhJ6adR5muOAYubY_1SxZWw@mail.gmail.com>
 <20171214225133.GM30595@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvFhHb57JdG01aiSypBAcUeLzY3Dhuh5xP-_F5k_NcAhA@mail.gmail.com>
Message-ID: <20171215201434.GY30595@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 02:53:57PM -0500, Jim Quinlan wrote:
> On Thu, Dec 14, 2017 at 5:51 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Dec 13, 2017 at 06:53:53PM -0500, Jim Quinlan wrote:
> >> On Tue, Dec 12, 2017 at 5:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > On Tue, Nov 14, 2017 at 05:12:07PM -0500, Jim Quinlan wrote:
> >> >> This commit adds the basic Broadcom STB PCIe controller.  Missing is
> >> >> the ability to process MSI and also handle dma-ranges for inbound
> >> >> memory accesses.  These two functionalities are added in subsequent
> >> >> commits.
> >> >>
> >> >> The PCIe block contains an MDIO interface.  This is a local interface
> >> >> only accessible by the PCIe controller.  It cannot be used or shared
> >> >> by any other HW.  As such, the small amount of code for this
> >> >> controller is included in this driver as there is little upside to put
> >> >> it elsewhere.
> >> ...
> >
> >> >> +static bool brcm_pcie_valid_device(struct brcm_pcie *pcie, struct pci_bus *bus,
> >> >> +                                int dev)
> >> >> +{
> >> >> +     if (pci_is_root_bus(bus)) {
> >> >> +             if (dev > 0)
> >> >> +                     return false;
> >> >> +     } else {
> >> >> +             /* If there is no link, then there is no device */
> >> >> +             if (!brcm_pcie_link_up(pcie))
> >> >> +                     return false;
> >> >
> >> > This is racy, since the link can go down after you check but before
> >> > you do the config access.  I assume your hardware can deal with a
> >> > config access that targets a link that is down?
> >>
> >> Yes, that can happen but there is really nothing that can be done if
> >> the link goes down in that vulnerability window.  What do you suggest
> >> doing?
> >
> > Most hardware drops writes and returns ~0 on reads if the link is
> > down.  I assume your hardware does something similar, and that should
> > be enough.  You shouldn't have to check whether the link is up.
> Unfortunately our HW is quite unforgiving and effects a synchronous or
> asynchronous abort when doing a config access when the link or power
> has gone down on the EP.  I will open a discussion with the PCIe HW
> folks regarding why our controller does not behave like "most
> hardware".  Thanks, Jim

I mentioned in the other thread [1] that I think the best way to
handle this is to figure out how to deal with the abort cleanly.
Using a test like *_pcie_link_up() to try to avoid it is a 99%
solution that means we'll see rare failures that are very difficult to
reproduce and debug.

> > The hardware might report errors, e.g., via AER, if the link is down.
> > And we might not not handle those nicely.  If we have issues there, we
> > should find out and fix them.

[1] https://lkml.kernel.org/r/20171214225821.GN30595 at bhelgaas-glaptop.roam.corp.google.com
