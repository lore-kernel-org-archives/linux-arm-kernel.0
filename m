From: dja@axtens.net (Daniel Axtens)
Date: Thu, 26 Mar 2015 16:19:40 +1100
Subject: [PATCH v8 19/30] powerpc/pci: Use pci_scan_host_bridge() for
 simplicity
In-Reply-To: <55135E16.6060909@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
 <1427168064-8657-20-git-send-email-wangyijing@huawei.com>
 <1427241523.2685.18.camel@axtens.net> <551266DE.3030609@huawei.com>
 <1427321631.2575.3.camel@axtens.net> <55135E16.6060909@huawei.com>
Message-ID: <1427347180.2575.91.camel@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yijing,

Pulled.

I'm now getting build errors:

/scratch/dja/linux-patches/arch/powerpc/kernel/pci-common.c: In function 'pcibios_scan_phb':
/scratch/dja/linux-patches/arch/powerpc/kernel/pci-common.c:1638:14: error: 'bus' undeclared (first use in this function)
/scratch/dja/linux-patches/arch/powerpc/kernel/pci-common.c:1638:14: note: each undeclared identifier is reported only once for each function it appears in

That relates to your changes to pcibios_scan_phb:
-       struct pci_bus *bus;
+       struct pci_host_bridge *host;
clashing with line 1638:
	hose->bus = bus;
which occurs later in the same unction.

If I fix that, I'll get more errors with lines in that function that
still reference hose instead of host.

As well as line 1638, there's still big chunks of the function that
reference hose, for example:

	/* Get some IO space for the new PHB */
	pcibios_setup_phb_io_space(hose);

	/* Wire up PHB bus resources */
	pcibios_setup_phb_resources(hose, &resources);

	hose->busn.start = hose->first_busno;
	hose->busn.end	 = hose->last_busno;
	hose->busn.flags = IORESOURCE_BUS;
	pci_add_resource(&resources, &hose->busn);

	pci_host_ops.pci_ops = hose->ops;


Basically, the changes in PowerPC need to be quite a bit more through
just to get the changes to build.

I'm keen to work on simplifying PCI code in PowerPC, but at this point,
it will need a lot more work before it's ready to go in.

Regards,
Daniel


On Thu, 2015-03-26 at 09:17 +0800, Yijing Wang wrote:
> On 2015/3/26 6:13, Daniel Axtens wrote:
> > Hi Yijing,
> > 
> > I wasn't quite sure I understood your comments, so I was trying to apply
> > your patch series and test it, but patch 3 doesn't apply cleanly to
> > 4.0-rc5 or master. Can you respin the series?
> 
> Hi Daniel,
>    Could you pull the series from Bjorn's git tree ? The URL is
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/enumeration-yw8
> 
> Thanks!
> Yijing.
> 
> > 
> > Thanks,
> > Daniel
> > 
> > 
> >> Hi Daniel, thanks for your review and comments. We want to make a generic pci_host_bridge,
> >> which would hold the common host information, for example, pci domain is common info for
> >> pci host bridge, this series saved domain in pci_host_bridge, then we no need to
> >> extract out domain by pci_bus->sysdata by platform specific pci_domain_nr().
> >> Also we store the sysdata in pci_host_bridge, and pci_bus_to_host() is the platform
> >> interface, I think use the common interface would be better.
> >>
> >>>> +
> >>>> +	/* Get probe mode and perform scan */
> >>>> +	if (hose->dn && ppc_md.pci_probe_mode)
> >>>> +		mode = ppc_md.pci_probe_mode(bus);
> >>>> +
> >>>> +	pr_debug("    probe mode: %d\n", mode);
> >>>> +	if (mode == PCI_PROBE_DEVTREE)
> >>>> +		of_scan_bus(hose->dn, bus);
> >>>> +
> >>>> +	if (mode == PCI_PROBE_NORMAL) {
> >>>> +		pci_bus_update_busn_res_end(bus, 255);
> >>>> +		hose->last_busno = pci_scan_child_bus(bus);
> >>>> +		pci_bus_update_busn_res_end(bus, hose->last_busno);
> >>>> +	}
> >>>> +
> >>>> +	return pci_bus_child_max_busnr(bus);
> >>>> +}
> >>>> +
> >>> I'm having trouble convincing myself that this patch covers every
> >>> variation within our PCI implementations. In particular, there's a
> >>> stanza in of_scan_pci_bridge in kernel/pci_of_scan.c that's almost
> >>> identical to this function. Does that implementation need to be cleaned
> >>> up and replaced with this function too?
> >>>
> >>
> >> This is a pci_host_bridge_ops hook function, which would be called in
> >> PCI core, and after applied this series, we only need to call pci_scan_host_bridge()
> >> to scan pci devices, and this function is also extracted from the pcibios_scan_phb(),
> >> it's not the redundant code.
> >>
> >>>
> >>>> @@ -1641,9 +1655,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
> >>>>  		ppc_md.pcibios_fixup_phb(hose);
> >>>>  
> >>>>  	/* Configure PCI Express settings */
> >>>> -	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> >>>> +	if (host->bus && !pci_has_flag(PCI_PROBE_ONLY)) {
> >>>>  		struct pci_bus *child;
> >>>> -		list_for_each_entry(child, &bus->children, node)
> >>>> +		list_for_each_entry(child, &host->bus->children, node)
> >>>>  			pcie_bus_configure_settings(child);
> >>>>  	}
> >>>>  }
> >>> Two things: Firstly, the function uses hose throughout, not host.
> >>> Secondly, you're not deleting the bus variable: what's the purpose of
> >>> this change?
> >>
> >> host is the common pci_host_bridge which is created by PCI core for pci host bridge driver,
> >> the hose is the platform data used in powerpc. The purpose of the patch/series is to simplify
> >> pci enumeration interface, and try to reduce the weak functions which were used to setup pci bus/devices
> >> during PCI enumeration.
> >>
> >>>
> >>> Regards,
> >>> Daniel
> >>>
> >>
> >>
> > 
> 
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 860 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150326/3ab45471/attachment.sig>
