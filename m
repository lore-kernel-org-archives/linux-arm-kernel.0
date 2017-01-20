From: roger.pau@citrix.com (Roger Pau =?iso-8859-1?Q?Monn=E9?=)
Date: Fri, 20 Jan 2017 14:24:26 +0000
Subject: [Xen-devel] [RFC] Device memory mappings for Dom0 on ARM64 ACPI
 systems
In-Reply-To: <a40dda2b-e6f3-3222-9b56-9208d96ce5d0@arm.com>
References: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
 <20170118110243.ctqpperggim5k7dw@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701181058110.10192@sstabellini-ThinkPad-X260>
 <20c89f12-cb0c-1145-99d0-320b2080b503@arm.com>
 <20170119154129.7dnjzvq23jop7oye@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701191002330.10192@sstabellini-ThinkPad-X260>
 <94e89cb4-f40c-585e-b3e8-d9f8f58b53d9@arm.com>
 <20170120110114.2ajkmmhxhhbc6acl@dhcp-3-221.uk.xensource.com>
 <a40dda2b-e6f3-3222-9b56-9208d96ce5d0@arm.com>
Message-ID: <20170120142426.eqs2n23ugrz2f6v5@dhcp-3-221.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 02:10:33PM +0100, Julien Grall wrote:
> Hi Royger,
> 
> On 20/01/2017 12:01, Roger Pau Monn? wrote:
> > On Thu, Jan 19, 2017 at 09:14:03PM +0100, Julien Grall wrote:
> In case of ARM, Xen does not use any PCI devices (no PCI UART) itself so
> scanning before hand is not necessary. If possible, I would prefer to have
> the scanning in one place rather than spreading in different place depending
> on the segments (we do have multiple segment on ARM).

AFAIK on ARM you could do the scan inside of the implementation of
PHYSDEVOP_pci_mmcfg_reserved hypercall, and that would be enough in order to
discover the devices.

> > 
> > > Also, you are assuming that the MCFG will describe the host controller. This
> > > is the case only when host controller available at boot. So you may miss
> > > some here.
> > 
> > Yes, I know, that's why we need the hypercall. The information in the MCFG
> > table might be incomplete, and the hardware domain would have to fetch extra
> > ECAM information from the _SEG method of host bridge devices in the ACPI
> > namespace.
> > 
> > > Furthermore, on ARM we have other static tables (such as GTDT) contain MMIO
> > > region to map.
> > > 
> > > Lastly, all devices are not PCI and you may have platform devices. The
> > > platform devices will only be described in the ASL. Just in case, those
> > > regions are not necessarily described in UEFI memory map.
> > 
> > Will those devices work properly in such scenario? (ie: are they behind the
> > SMMU?)
> 
> Platform devices might or might not be behind of the SMMU. It will depend if
> the device is DMA-capable and often whether the implementer decided to have
> an SMMU.
> 
> Today, there is no SMMU support (it is by-passed) for ACPI so we haven't yet
> encountered the problem. We have an item to investigate the work to be done
> here.

Why would you need the SMMU for ACPI?

> Some thoughts, each device will be associated to one of multiple StreamID
> (ID to configure the SMMU). I guess we could find this from the static table
> IORT, need to check.
> 
> Also, some of the platform device will have MSIs, I suspect the number of
> MSIs will be either hardcoded or found in the ASL. So we would need to have
> a new hypercall to advertise those.
> 
> > 
> > > So you need DOM0 to tell the list of regions.
> > 
> > Yes, I agree that we need such hypercall ATM, although I think that we might be
> > able to get rid of it in the long term if we are able to parse the AML tables
> > from Xen.
> 
> Are you suggesting to bring a full AML parser in Xen? If so, it will be much
> bigger than Xen ARM itself. I would need a strong use case to accept a such
> thing.

It could be placed in the init section, and get rid of it after boot. Also, I
find it hard to believe that an AML parser is bigger than the whole Xen on ARM.
The OpenBSD folks have a DSDT parser in ~4000 lines of code [0], and that's
probably way more than what Xen actually needs.

Roger.

[0] https://github.com/openbsd/src/blob/master/sys/dev/acpi/dsdt.c
