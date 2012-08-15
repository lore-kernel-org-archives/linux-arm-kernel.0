From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 15 Aug 2012 08:49:02 +0200
Subject: [PATCH v3 05/10] resource: add PCI configuration space support
In-Reply-To: <CAErSpo4Efy-Dt67rktzNiYfZfOTSu=pmYtyGd3tR-zZQ3jDGtA@mail.gmail.com>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
 <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6LYpkC5wop53S1r1z3ov4+w4soqrQARzbbouVs1trzUg@mail.gmail.com>
 <20120814180142.GA9430@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Efy-Dt67rktzNiYfZfOTSu=pmYtyGd3tR-zZQ3jDGtA@mail.gmail.com>
Message-ID: <20120815064902.GB15665@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 02:44:24PM -0700, Bjorn Helgaas wrote:
> On Tue, Aug 14, 2012 at 11:01 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Tue, Aug 14, 2012 at 10:38:08AM -0700, Bjorn Helgaas wrote:
> >> On Mon, Aug 13, 2012 at 10:55 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > On Mon, Aug 13, 2012 at 10:00:45PM -0700, Bjorn Helgaas wrote:
> >> >> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> >> >> <thierry.reding@avionic-design.de> wrote:
> >> >> > This commit adds a new flag that allows marking resources as PCI
> >> >> > configuration space.
> >> >> >
> >> >> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >> >> > ---
> >> >> > Changes in v3:
> >> >> > - new patch
> >> >> >
> >> >> >  include/linux/ioport.h | 2 +-
> >> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> >> >> > index 589e0e7..3314843 100644
> >> >> > --- a/include/linux/ioport.h
> >> >> > +++ b/include/linux/ioport.h
> >> >> > @@ -102,7 +102,7 @@ struct resource {
> >> >> >
> >> >> >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> >> >> >  #define IORESOURCE_PCI_FIXED           (1<<4)  /* Do not move resource */
> >> >> > -
> >> >> > +#define IORESOURCE_PCI_CS              (1<<5)  /* PCI configuration space */
> >> >>
> >> >> What is the purpose of this?  It seems that you are marking regions
> >> >> that we call MMCONFIG on x86, or ECAM-type regions in the language of
> >> >> the PCIe spec.  I see that you set it in several places, but I don't
> >> >> see anything that ever looks for it.  Do you have plans to use it in
> >> >> the future?  If it really does correspond to MMCONFIG/ECAM, we should
> >> >> handle those regions consistently across all architectures.
> >> >
> >> > The purpose is ultimately to obtain the MMCONFIG/ECAM resources assigned
> >> > to a PCI host controller. I've used this in the of_pci_parse_ranges()
> >> > and in the static board setup code to mark ranges as such. Perhaps
> >> > IORESOURCE_ECAM or IORESOURCE_MMCONFIG might have been better names. I
> >> > also just noticed that I'm not using this anywhere, but the plan was to
> >> > eventually use it with platform_get_resource(). However that doesn't
> >> > seem to work either because the lower bits of the flags aren't use for
> >> > comparison in that function.
> >> >
> >> > Any other ideas how that could be handled? Basically what I need is a
> >> > way to mark a resource as an MMCONFIG/ECAM range so that it can be used
> >> > to program the PCI host controller accordingly. I don't know how these
> >> > are assigned on x86. I was under the impression that the MMCONFIG/ECAM
> >> > space was accessed through a single single address/data register pair.
> >>
> >> The legacy config access mechanism (CF8h/CFCh registers described in
> >> PCI 3.0 spec sec 3.2.2.3.2) is a single address/data pair, but this is
> >> mostly x86-specific.  The ECAM mechanism (described in the PCIe 3.0
> >> spec sec 7.2.2) is not a single address/data pair; instead, each byte
> >> of config space is directly mapped into the host's MMIO space.
> >>
> >> Here's what we do on x86 (omitting some historical grunge that
> >> complicates things):
> >>
> >>   - Discover the host bridge via a PNP0A08 device in the ACPI namespace.
> >>   - Discover the bus number range behind the bridge using a _CRS
> >> method in the PNP0A08 device.
> >>   - Discover the ECAM space for those buses via a _CBA method in the
> >> PNP0A08 device.
> >>   - Tell the config accessors (struct pci_ops) that the ECAM space for
> >> buses A-B is at address X.
> >>   - Enumerate the devices behind the host bridge by calling
> >> pci_scan_root_bus(), passing the config accessors.
> >>
> >> It sounds like you want a way to parse the resources at one point,
> >> saving them and marking the ECAM region, then at a later point, look
> >> up the ECAM from a saved list.  We don't do that on x86 because the
> >> config accessors keep an internal list of the ECAM area for each bus.
> >>
> >> We do of course want to put this ECAM space in the IORESOURCE_MEM tree
> >> because it consumes address space and we have to make sure we don't
> >> put anything else on top of it.  But we don't have any reason to
> >> describe the MMIO -> config space function in that tree.  From the
> >> point of view of the rest of the system, it's just MMIO space that's
> >> consumed by the PCI host bridge, just like any other device-specific
> >> MMIO area.
> >
> > What I currently do is pass the ECAM space as a resource to the PCI host
> > bridge platform device. Regular and extended configuration spaces are
> > given by the third and fourth resources, respectively. If I understand
> > correctly, you're saying that nothing beyond that needs to be encoded.
> > In other words it is enough for the PCI host bridge driver to know where
> > to take the data from.
> 
> Yes, I think so.
> 
> I'd like to someday make ECAM support generic, since it's specified by
> the PCIe spec.  The spec doesn't differentiate between PCI
> configuration space (offsets 0-0xff) and PCI Express *extended*
> configuration space (offsets 0x100-0xfff).  But it sounds like Tegra
> might have a memory-mapped configuration mechanism that is similar to
> ECAM but with a different address map, since you mention two resources
> (third and fourth).  That's not a problem, since you're doing a
> Tegra-specific solution right now anyway, but something to keep in the
> back of your mind if we ever do make a generic ECAM solution.

Something that's kept me wondering is why there actually need to be two
separate regions. Since the extended configuration space is a superset
of the regular configuration space it should be possible to access the
regular registers via the extended configuration space as well.

Stephen: Could you try to find out whether the regular configuration
space translation can just be omitted if we already set up the one for
the extended configuration space? In tegra_pcie_setup_translations(),
BAR 0 is setup for regular configuration space (which requires a 16 MiB
region), while BAR 1 is setup for the extended configuration space
(requiring a full 256 MiB region). However, if I understand correctly,
each of the registers that can be accessed via the BAR 0 translation can
also be accessed via the BAR 1 translation. That seems like we're
wasting the 16 MiB set aside for the BAR 0 mapping.

> > I'll have to see what this means for the DT binding. There are other
> > issues that I need to think about, like for example how to pass the ECAM
> > space from the PCI host controller to each of the two bridges via the
> > ranges property. This no longer makes sense in the current form, as the
> > ECAM covers the configuration spaces for devices of both bridges and
> > cannot really be split among them.
> 
> We have the same situation on x86.  Part of the historical grunge that
> I omitted is that there's a static ACPI table (MCFG) that can tell you
> the ECAM range for a bus number range.  Often that bus number range
> includes several host bridges.  On x86, we have a single set of ECAM
> config accessors (see pci_mmcfg), and they maintain a list of "bus
> number -> ECAM addr" mappings internally, independent of which host
> bridge leads to the buses.

That's very similar to how things work on Tegra. Configuration space
accesses to the host bridges are done via their respective memory-mapped
register spaces. All other accesses use either the BAR 0 or BAR 1
translations as I described above. These translations however are unique
and only a single set of accessors are provided.

Given that and what I said in the other mail about the implementation of
ECAM on Tegra any CS range we pass to the host bridges via the DT ranges
property is actually wrong.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120815/c7b07907/attachment.sig>
