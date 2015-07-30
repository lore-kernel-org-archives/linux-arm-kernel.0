From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 30 Jul 2015 16:50:55 +0000
Subject: [PATCH v6] PCI: Store PCIe bus address in struct of_pci_range
In-Reply-To: <20150730161447.GG9640@google.com>
References: <1438010223-124422-1-git-send-email-gabriele.paoloni@huawei.com>
 <20150729172053.GE31170@google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6F350@lhreml503-mbs>
 <CAL_JsqKs11-sXQTdBD+ZjbVYFWUHBARTW9q5MF1hCXUhZ+nWLQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6F94A@lhreml503-mbs>
 <20150730161447.GG9640@google.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D6FB3B@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-
> owner at vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Thursday, July 30, 2015 5:15 PM
> To: Gabriele Paoloni
> Cc: Rob Herring; arnd at arndb.de; lorenzo.pieralisi at arm.com; Wangzhou (B);
> robh+dt at kernel.org; james.morse at arm.com; Liviu.Dudau at arm.com; linux-
> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> qiuzhenfa; Liguozhu (Kenneth)
> Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
> of_pci_range
> 
> On Thu, Jul 30, 2015 at 01:52:13PM +0000, Gabriele Paoloni wrote:
> >
> >
> > > -----Original Message-----
> > > From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-
> > > owner at vger.kernel.org] On Behalf Of Rob Herring
> > > Sent: Thursday, July 30, 2015 2:43 PM
> > > To: Gabriele Paoloni
> > > Cc: Bjorn Helgaas; arnd at arndb.de; lorenzo.pieralisi at arm.com;
> Wangzhou
> > > (B); robh+dt at kernel.org; james.morse at arm.com; Liviu.Dudau at arm.com;
> > > linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > > devicetree at vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> > > qiuzhenfa; Liguozhu (Kenneth)
> > > Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
> > > of_pci_range
> > >
> > > On Wed, Jul 29, 2015 at 2:44 PM, Gabriele Paoloni
> > > <gabriele.paoloni@huawei.com> wrote:
> > > > Hi Bjorn
> > > >
> > > > Many Thanks for your reply
> > > >
> > > > I have commented back inline with resolutions from my side.
> > > >
> > > > If you're ok with them I'll send it out a new version in the
> > > appropriate patchset
> > > >
> > > > Cheers
> > > >
> > > > Gab
> > > >
> > > >> -----Original Message-----
> > > >> From: Bjorn Helgaas [mailto:bhelgaas at google.com]
> > > >> Sent: Wednesday, July 29, 2015 6:21 PM
> > > >> To: Gabriele Paoloni
> > > >> Cc: arnd at arndb.de; lorenzo.pieralisi at arm.com; Wangzhou (B);
> > > >> robh+dt at kernel.org; james.morse at arm.com; Liviu.Dudau at arm.com;
> linux-
> > > >> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > > >> devicetree at vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> > > >> qiuzhenfa; Liguozhu (Kenneth)
> > > >> Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct
> > > >> of_pci_range
> > > >>
> > > >> Hi Gabriele,
> > > >>
> > > >> As far as I can tell, this is not specific to PCIe, so please
> use
> > > "PCI"
> > > >> in
> > > >> the subject as a generic term that includes both PCI and PCIe.
> > > >
> > > > sure agreed
> > > >
> > > >>
> > > >> On Mon, Jul 27, 2015 at 11:17:03PM +0800, Gabriele Paoloni wrote:
> > > >> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> > > >> >
> > > >> >     This patch is needed port PCIe designware to new DT
> parsing
> > > API
> > > >> >     As discussed in
> > > >> >     http://lists.infradead.org/pipermail/linux-arm-
> kernel/2015-
> > > >> January/317743.html
> > > >> >     in designware we have a problem as the PCI addresses in
> the
> > > PCIe
> > > >> controller
> > > >> >     address space are required in order to perform correct HW
> > > >> operation.
> > > >> >
> > > >> >     In order to solve this problem commit f4c55c5a3 "PCI:
> > > designware:
> > > >> >     Program ATU with untranslated address" added code to read
> the
> > > >> PCIe
> > > >>
> > > >> Conventional reference is 12-char SHA1, like this:
> > > >>
> > > >>   f4c55c5a3f7f ("PCI: designware: Program ATU with untranslated
> > > >> address")
> > > >
> > > > Agreed, will change this
> > > >
> > > >>
> > > >> >     controller start address directly from the DT ranges.
> > > >> >
> > > >> >     In the new DT parsing API
> of_pci_get_host_bridge_resources()
> > > >> hides the
> > > >> >     DT parser from the host controller drivers, so it is not
> > > possible
> > > >> >     for drivers to parse values directly from the DT.
> > > >> >
> > > >> >     In http://www.spinics.net/lists/linux-pci/msg42540.html we
> > > >> already tried
> > > >> >     to use the new DT parsing API but there is a bug
> (obviously)
> > > in
> > > >> setting
> > > >> >     the <*>_mod_base addresses
> > > >> >     Applying this patch we can easily set "<*>_mod_base = win-
> > > >> >__res.start"
> > > >>
> > > >> By itself, this patch adds something.  It would help me
> understand
> > > it
> > > >> if
> > > >> the *user* of this new something were in the same patch series.
> > > >
> > > > the user is: "[PATCH v5 2/5] PCI: designware: Add ARM64 support"
> > > > I will ask Zhou Wang to include this patch in his patchset
> > > >
> > > >
> > > >>
> > > >> >     This patch adds a new field in "struct of_pci_range" to
> store
> > > the
> > > >> >     pci bus start address; it fills the field in
> > > >> of_pci_range_parser_one();
> > > >> >     in of_pci_get_host_bridge_resources() it retrieves the
> > > resource
> > > >> entry
> > > >> >     after it is created and added to the resource list and
> uses
> > > >> >     entry->__res.start to store the pci controller address
> > > >>
> > > >> struct of_pci_range is starting to get confusing to non-OF folks
> > > like
> > > >> me.
> > > >> It now contains:
> > > >>
> > > >>   u32 pci_space;
> > > >>   u64 pci_addr;
> > > >>   u64 cpu_addr;
> > > >>   u64 bus_addr;
> > > >>
> > > >> Can you explain what all these things mean, and maybe even add
> one-
> > > line
> > > >> comments to the structure?
> > > >
> > > > sure I can add comments inline in the code
> > > >
> > > >>
> > > >> pci_space: The only uses I see are to determine whether to print
> > > >> "Prefetch".  I don't see any real functionality that uses this.
> > > >
> > > > Looking at the code I agree. it's seems to be used only in
> powerpc
> > > > and microblaze to print out.
> > > > However from my understanding pci_space is the phys.hi field of
> the
> > > > ranges property: it defines the properties of the address space
> > > associated
> > > > to the PCI address. if you're curious you can find a nice and
> quick
> > > to read
> > > > "guide" in http://devicetree.org/MPC5200:PCI
> > > >
> > > >>
> > > >> pci_addr: I assume this is a PCI bus address, like what you
> would
> > > see
> > > >> if
> > > >> you put an analyzer on the bus/link.  This address could go in a
> BAR.
> > > >
> > > > Yes, this is the PCI start address of the range: phys.mid +
> phys.low
> > > in the
> > > > guide mentioned above
> > > >
> > > >>
> > > >> cpu_addr: I assume this is a CPU physical address, like what you
> > > would
> > > >> see
> > > >> in /proc/iomem and what you would pass to ioremap().
> > > >
> > > > Yes correct
> > > >
> > > >>
> > > >> bus_addr: ?
> > > >>
> > > >
> > > > According to the guide above, this is the address into which the
> > > pci_address
> > > > get translated to and that is passed to the root complex. Between
> the
> > > root
> > > > complex and the CPU there can be intermediate translation layers:
> see
> > > that to
> > > > get pci_address we call "of_translate_address"; this will apply
> all
> > > the
> > > > translation layers (ranges in the DT) that it finds till it comes
> to
> > > the root
> > > > node of the DT (thus retrieving the CPU address).
> > > > Now said that, for designware we need the first translated PCI
> > > address, that we call
> > >
> > > I think you mean "translated CPU address." The flow of addresses
> looks
> > > like this:
> > >
> > > CPU -> CPU bus address -> bus fabric address decoding -> bus
> address
> > > -> DW PCI -> PCI address
> > >
> > > This is quite common that an IP block does not see the full address.
> > > It is unusual that the IP block needs to know its full address on
> the
> > > slave side. It is quite common for the master side and the kernel
> > > deals with that all the time with DMA mapping
> > >
> > > > here bus_addr after Rob Herring suggested the name...honestly I
> > > cannot think of a
> > > > different name
> > >
> > > Thinking about this some more, is this really a translation versus
> > > just a stripping of high bits? Does the DW IP have less than 32-
> bits
> > > address? If so, we could express differently and just mask the CPU
> > > address within the driver instead.
> >
> > I don?t think we should rely on [CPU] addresses...what if the
> intermediate
> > translation layer changes the lower significant bits of the "bus
> address"
> > to translate into a cpu address?
> 
> Is it really a possiblity that the lower bits could be changed?

I've checked all the current deignware users DTs except "pci-layerscape" 
that I could not find:
spear1310.dtsi
spear1340.dtsi
dra7.dtsi
imx6qdl.dtsi
imx6sx.dtsi
keystone.dtsi
exynos5440.dtsi

None of them modifies the lower bits. To be more precise the only guy
that provides another translation layer is "dra7.dtsi":
axi0
http://lxr.free-electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L207

axi1
http://lxr.free-electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L241

For this case masking the top 4bits (bits28 to 31) should make the job.

Speaking in general terms so far I've always seen linear mappings
that differ by bitmask offset, however linear does not mean that you 
cannot affect the lower bits: e.g. <0x0> to <0x0 + size> can map to
<0x0000cafe to 0x0000cafe + size>, but I guess that for HW design reasons
it is much easier to remap directly using a bitmask...but I was not sure
and I didn't think about the problems that can arise with ACPI.

If you think the bitmask is Ok then I can directly define it in
designware and we can drop this patch.

Thanks
Gab
 
> 
> I think we're talking about MMIO here, and a bridge has an MMIO
> window.  A window is a range of CPU physical addresses that the
> bridge forwards to PCI.  The PCI core assumes that a CPU physical
> address range is linearly mapped to PCI bus addresses, i.e., if the
> window base is X and maps to PCI address Y, then as long as X+n is
> inside the window, it must map to Y+n.
> 
> That means the low-order bits (the ones that are the offset into the
> window) cannot change.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
