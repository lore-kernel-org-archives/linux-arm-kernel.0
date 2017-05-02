From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 May 2017 21:36:41 +0200
Subject: [RFC/RFT PATCH 03/18] PCI: Introduce pci_scan_root_bus_bridge()
In-Reply-To: <20170502171501.GA5545@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-4-lorenzo.pieralisi@arm.com>
 <CAK8P3a0HmrrYBP5em1s4VOY4Tb6=bwOrDDN6K8rPp8OEXtpMtA@mail.gmail.com>
 <20170502171501.GA5545@red-moon>
Message-ID: <CAK8P3a1dbopDOXot-brx+xfZeBbUZUfYf1Urs2T3UNwXyg8Mnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 2, 2017 at 7:15 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Apr 28, 2017 at 02:28:38PM +0200, Arnd Bergmann wrote:
>> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>
>> Good idea, yes. To avoid growing the number of interfaces too
>> much, should we change the existing users of pci_register_host_bridge
>> in host drivers over to this entry point, and make the other one
>> local to probe.c then?
>
> Yes, the problem is that there are drivers (ie pcie-iproc.c) that
> require the struct pci_bus (created by pci_register_host_bridge())
> to fiddle with it to check link status and THEN scan the bus (so
> the pci_register_host_bridge() call can't be embedded in the scan
> interface - the driver requires struct pci_bus for pci_ops to work
> before scanning the bus itself).
>
> I will see how I can accommodate this change because you definitely
> have a point.

The obvious answer for that particular problem would be a link_check()
callback in the bridge operations. I think that would also fit in well with
the dw_pcie driver that has some private infrastructure for it. I don't
know if that callback is sufficient to solve all related problems though.

       Arnd
