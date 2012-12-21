From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 21 Dec 2012 15:03:26 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB91AE43324D@BGMAIL01.nvidia.com>
References: <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
 <C79B248886DD134989C8FF6B096A91AB91AE43324D@BGMAIL01.nvidia.com>
Message-ID: <20121221140326.GA9729@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jay, can you please wrap your mails at something around 78 characters
per line? Anything longer becomes very hard to read and quote.

On Fri, Dec 21, 2012 at 07:08:39PM +0530, Jay Agarwal wrote:
> Thierry,
> 
> Are you doing below BARs programing for config space or extended config
> space? pcie->cfg & comments indicates config and fpci_bar = 0xfe0... &
> size indicates extended config.

The programming is for extended configuration space. Using only the
extended configuration space mapping works fine even when not accessing
the extended registers so we can save one BAR by just not using the
regular configuration space mapping.

On a side note, the Tegra TRM says that there are actually 8 BARs, while
both upstream and downstream kernel code says that there are only 5. Can
you find out which one is true? It would also be nice to get some better
documentation for the PCIe controller as the latest versions that are
available don't even have the register offsets for the individual
registers.

> Also make sure you add up 0x10000000(according to your below impl.) to
> pcie->cs/pcie->extcs in pcie_read(write)_conf api so that type1 addresses
> will actually be mapped to 0xfe1... fpci address.

I don't understand. If I map the 40-bit FPCI address 0xfe10000000 to AXI
address 0xa0000000 and then map that to a virtual address that I can
read from or write to, why would I need to add an offset of 0x10000000
again?

Also Stephen found out that the host bridge does not appear on bus 0,
only the root ports do. It would still be nice to access the root ports'
configuration space through a proper mapping instead of the extra window
but if the host bridge isn't even visible on that bus, then we can just
as well stick with the per-root port windows. That way we also save an
additional 256 MiB of physical address space.

Thierry

> 
> 
> 
> > -----Original Message-----
> 
> > From: Thierry Reding [mailto:thierry.reding at avionic-design.de]
> 
> > Sent: Thursday, December 20, 2012 9:03 PM
> 
> > To: Stephen Warren
> 
> > Cc: Jason Gunthorpe; Jay Agarwal; Thomas Petazzoni; Andrew Lunn; Jason
> 
> > Cooper; Gregory Clement; linux-arm-kernel at lists.infradead.org
> 
> > Subject: Re: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
> 
> >
> 
> > * PGP Signed by an unknown key
> 
> >
> 
> > On Tue, Dec 18, 2012 at 10:03:38AM -0700, Stephen Warren wrote:
> 
> > > On 12/17/2012 07:51 PM, Jason Gunthorpe wrote:
> 
> > > > [trimmed the cc list]
> 
> > > >
> 
> > > > On Mon, Dec 17, 2012 at 07:10:59PM -0700, Stephen Warren wrote:
> 
> > > >
> 
> > > >>> What I'll do next is add some caching of written values, so that
> 
> > > >>> reading them back actually yields something correct. After that
> 
> > > >>> I'll post what I have so that others can look at it or even reuse
> 
> > > >>> it.
> 
> > > >>
> 
> > > >> Some internal discussion implies this shouldn't be required; here's
> 
> > > >> what they said:
> 
> > > >
> 
> > > > Looking at the driver, it says:
> 
> > > >
> 
> > > > + * 0x80000000 - 0x80003fff - PCI controller registers
> 
> > > > + * 0x80004000 - 0x80103fff - PCI configuration space
> 
> > > > + * 0x80104000 - 0x80203fff - PCI extended configuration space
> 
> > > >
> 
> > > > And the bridge config regions are at:
> 
> > > >
> 
> > > > +#define RP0_OFFSET     0x0000
> 
> > > > +#define RP1_OFFSET     0x1000
> 
> > > >
> 
> > > > And from the first checkin, config space accesses have been split
> 
> > > > into three designations:
> 
> > > >  bridge #0 - 0x80000000 + 0
> 
> > > >  bridge #1 - 0x80000000 + 0x1000
> 
> > > >  Every other bus - 0x80104000 + [equation]
> 
> > > >
> 
> > > > And based on Thierry's results it looks like once the bridge
> 
> > > > subordinate bus numbers are setup (via their lower mappings) then
> 
> > > > the 'every other bus' mapping starts working as expected.
> 
> > > >
> 
> > > > So.. is there a register to be set that lets the bridge
> 
> > > > configuration be accessed through the [0x80004000 - 0x80103fff] region
> 
> > as bus 0?
> 
> > > > Presumably a non-PCI device number register?
> 
> > >
> 
> > > It looks like some PCI host controller registers do need to be set up
> 
> > > (so far the information is related to "type 0" vs. "type 1"
> 
> > > configuration accesses, although I'm not familiar with what that means).
> 
> >
> 
> > So I've been spending some time implementing this along with some of the
> 
> > things that Stephen and I discussed on IRC. However, each time I try to
> 
> > access the type 0 configuration space through the special mapping that
> 
> > Stephen dug up I get the following "imprecise external abort" oops:
> 
> >
> 
> > [    3.482802] tegra-pcie 80003000.pcie-controller: PCI host bridge to bus
> 
> > 0000:00
> 
> > [    3.490107] pci_bus 0000:00: root bus resource [io  0x82000000-0x8200ffff]
> 
> > [    3.517456] pci_bus 0000:00: root bus resource [mem 0xb0000000-
> 
> > 0xb7ffffff]
> 
> > [    3.530644] pci_bus 0000:00: root bus resource [mem 0xb8000000-0xbfffffff
> 
> > pref]
> 
> > [    3.554191] pci_bus 0000:00: root bus resource [bus 00-ff]
> 
> > [    3.559693] Unhandled fault: imprecise external abort (0x406) at
> 
> > 0x00034384
> 
> > [    3.559702] tegra-pcie 80003000.pcie-controller: AXI response decoding
> 
> > error, signature: 00000001
> 
> > [    3.559708] tegra-pcie 80003000.pcie-controller:   FPCI address: fe00000000
> 
> > [    3.582435] Internal error: : 406 [#1] PREEMPT SMP ARM
> 
> > [    3.587560] Modules linked in:
> 
> > [    3.590616] CPU: 1    Not tainted  (3.7.0-next-20121219-00103-gb307de6-
> 
> > dirty #42)
> 
> > [    3.591125] usb 1-1.1: new high-speed USB device number 3 using tegra-
> 
> > ehci
> 
> > [    3.604944] PC is at tegra_pcie_read_conf+0x60/0xd4
> 
> > [    3.609823] LR is at ioremap_page_range+0xec/0x19c
> 
> > [    3.614605] pc : [<c0025034>]    lr : [<c01dfcec>]    psr: a0000093
> 
> > [    3.614605] sp : da645d08  ip : 90000000  fp : c06a8bf4
> 
> > [    3.626063] r10: 00000000  r9 : da645de0  r8 : dae89400
> 
> > [    3.631274] r7 : 00000000  r6 : 00000000  r5 : 00000004  r4 : 00000000
> 
> > [    3.637790] r3 : ffffffff  r2 : 00000000  r1 : e0823000  r0 : e0822000
> 
> > [    3.644309] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment
> 
> > kernel
> 
> > [    3.651696] Control: 10c5387d  Table: 1a6f404a  DAC: 00000015
> 
> > [    3.657437] Process kworker/u:3 (pid: 55, stack limit = 0xda644238)
> 
> >
> 
> > I beefed up the interrupt service routine a bit to output the full FPCI address
> 
> > that the decoding error occurred and it always is the one configured for the
> 
> > type 0 configuration space mapping. I assume that the "Internal error" is due
> 
> > to the "imprecise external abort", but it would be good if somebody could
> 
> > confirm that.
> 
> >
> 
> > Basically I have modified tegra_pcie_setup_translations() to have this:
> 
> >
> 
> >              /* Bar 0: type 0 configuration space */
> 
> >              fpci_bar = 0xfe000000;
> 
> >              size = resource_size(pcie->cfg[0]);
> 
> >              axi_address = pcie->cfg[0]->start;
> 
> >              afi_writel(pcie, axi_address, AFI_AXI_BAR0_START);
> 
> >              afi_writel(pcie, size >> 12, AFI_AXI_BAR0_SZ);
> 
> >              afi_writel(pcie, fpci_bar, AFI_FPCI_BAR0);
> 
> >
> 
> >              /* Bar 1: type 1 configuration space */
> 
> >              fpci_bar = 0xfe100000;
> 
> >              size = resource_size(pcie->cfg[1]);
> 
> >              axi_address = pcie->cfg[1]->start;
> 
> >              afi_writel(pcie, axi_address, AFI_AXI_BAR1_START);
> 
> >              afi_writel(pcie, size >> 12, AFI_AXI_BAR1_SZ);
> 
> >              afi_writel(pcie, fpci_bar, AFI_FPCI_BAR1);
> 
> >
> 
> > Where pcie->cfg[0] and pcie->cfg[1] are parsed from the following device
> 
> > tree snippet:
> 
> >
> 
> >              reg = <0x80003000 0x00000800   /* PADS registers */
> 
> >                     0x80003800 0x00000200   /* AFI registers */
> 
> >                     0x90000000 0x10000000   /* type 0 configuration space */
> 
> >                     0xa0000000 0x10000000>; /* type 1 configuration space */
> 
> >
> 
> > The complete code can be found in my tegra/next branch[0]. Beware that I
> 
> > haven't cleaned up that branch in a while, so anything but looking at the end
> 
> > result is not very recommended =). The branch contains patches
> 
> > (untested) to make Harmony and TrimSlice initialize the PCIe from the
> 
> > device tree, so anyone inclined to give this a spin should be able to do so. If
> 
> > you want to try out the software emulated host bridge, you can just
> 
> > uncomment the "#define EMULATE_HOST_BRIDGE 1" at the top of
> 
> > arch/arm/mach-tegra/pcie.c.
> 
> >
> 
> > Stephen: Do you think you could dig some more, try to find out what the
> 
> > deal is with these "imprecise external aborts"? Perhaps something else
> 
> > needs to be done in order to activate the type 0 mapping? Also, while
> 
> > looking through some old downstream code from the Vibrante area I saw a
> 
> > HyperTransport document mentioned that contains these mappings. It is
> 
> > referred to as the "AFI IAS" (section 3.2.4 is mentioned specifically).
> 
> > Any chance I could take a look at it?
> 
> >
> 
> > Thierry
> 
> >
> 
> > [0]: git://gitorious.org/thierryreding/linux.git
> 
> >
> 
> > * Unknown Key
> 
> > * 0x7F3EB3A1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121221/128ffcdf/attachment.sig>
