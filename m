From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Jun 2017 16:44:26 +0200
Subject: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170602135619.GA10491@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
 <CAK8P3a1ULYxkopxJ8-vZpFs_uPP2gu5TsRWjCKUOW+0QRombLw@mail.gmail.com>
 <20170602114956.GA20004@red-moon>
 <CAK8P3a0DRFxz_yjCeFZJ8Zukuy8gi9hPbWEfp29TaF2TMjrnTQ@mail.gmail.com>
 <20170602135619.GA10491@red-moon>
Message-ID: <CAK8P3a3Qf_DDU09XVXBm+Y3d+n5He-2cnqqYTtg6_yiKE07jkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 2, 2017 at 3:56 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Jun 02, 2017 at 03:12:48PM +0200, Arnd Bergmann wrote:
>> > I am almost done refactoring this series and this is the last review to
>> > address. What you suggest above makes sense but:
>> >
>> > 1) it means patching ALL dw_pcie_host_init() callers and allocate the
>> >    host bridge there, not sure it simplifies, certainly it complicates
>> >    the error handling path (given that the host bridge memory is
>> >    probably the only memory that is allocated with kzalloc instead of
>> >    devm interface so it needs unwinding)
>> >
>> > 2) I noticed that allocating the host bridge in the caller complicates
>> >    error handling, in particular code in the mainline (ie tegra and
>> >    ftpci100) using pci_alloc_host_bridge() needs already patching since it
>> >    may leak memory if PCI host bridge drivers probing fails.
>> >
>> > I can implement (1) and (2) but I wanted to ask first to understand if
>> > that's the direction we want to take.
>>
>> Good question. Maybe we should add a devm_pci_alloc_host_bridge()
>> instead? Would that solve these problems without creating bigger ones?
>
> It would be yet another PCI core call (ie unfortunately we still need
> pci_alloc_host_bridge() for bridges with no parent device eg bios32) but
> I think that's the only option we have if we do not want to clutter the
> host bridges error paths with host bridge free calls.
>
> Implementing it should be relatively simple by reshuffling functions.
>
> Thoughts ?

I think adding this one would be fairly harmless because it has a clear
purpose and can easily be mixed with the rest of the API.

In one of the earlier drafts, we discussed just letting the user call an
initialization function to set the members and otherwise using kmalloc()
themselves. We decided on this one to save an extra function call in
each driver, but in retrospect, it would have saved us the discussion
now.

If we end up adding a devm_pci_alloc_host_bridge (or maybe
pcim_alloc_host_bridge), we also need to decide what part of the
cleanup would happen during the unwinding, besides the kfree().

        Arnd
