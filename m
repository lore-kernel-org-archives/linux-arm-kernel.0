From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Jan 2015 10:52:06 +0100
Subject: [PATCH 10/28] PCI: Save sysdata in pci_host_bridge drvdata
In-Reply-To: <54BC7632.1080003@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <18973877.BYCS6vtzoq@wuerfel> <54BC7632.1080003@huawei.com>
Message-ID: <20928659.d8sezC2Vk4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 January 2015 11:12:50 Yijing Wang wrote:
> On 2015/1/16 17:18, Arnd Bergmann wrote:
> > On Friday 16 January 2015 09:44:08 Yijing Wang wrote:
> >> @@ -2066,11 +2064,11 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, u32 db,
> >>  {
> >>         struct pci_host_bridge *host;
> >>  
> >> -       host = pci_create_host_bridge(parent, db, resources);
> >> +       host = pci_create_host_bridge(parent, db, resources, sysdata);
> >>         if (!host)
> >>                 return NULL;
> >>  
> >> -       return __pci_scan_root_bus(host, ops, sysdata);
> >> +       return __pci_scan_root_bus(host, ops);
> >>  }
> >>  EXPORT_SYMBOL(pci_scan_root_bus);
> >>
> > 
> > How about keeping the sysdata out of the pci_create_host_bridge interface, and
> > refactoring it so that the call sequence becomes
> > 
> >       host = pci_create_host_bridge(parent, db, resources);
> >       host->sysdata = sysdata;
> >       __pci_scan_root_bus(host, ops);
> > 
> > This way, we can make sysdata completely option. I assume that more of the
> > fields we have in sysdata today can get moved into pci_host_bridge
> > over time, so a host bridge driver can just assign those members individually
> > between pci_create_host_bridge and __pci_scan_root_bus.
> 
> I put the sysdata in pci_host_bridge, because some platforms x86/ia64
> need to call pcibios_root_bridge_prepare() before pci_host_bridge registration
> in pci_create_host_bridge(), and pcibios_root_bridge_prepare() need the companion
> acpi device pointer which is stored in sysdata.
> 
> I like you idea, but I haven't find a better way yet.

Ok, fair enough. We can always try to find ways for getting rid of
pcibios_root_bridge_prepare() later, though I suspect as soon as we
have the callback, it will get used for other things as well ;-)

	Arnd
