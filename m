From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 10:18:59 +0100
Subject: [PATCH 10/28] PCI: Save sysdata in pci_host_bridge drvdata
In-Reply-To: <1421372666-12288-11-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-11-git-send-email-wangyijing@huawei.com>
Message-ID: <18973877.BYCS6vtzoq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 09:44:08 Yijing Wang wrote:
> @@ -2066,11 +2064,11 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, u32 db,
>  {
>         struct pci_host_bridge *host;
>  
> -       host = pci_create_host_bridge(parent, db, resources);
> +       host = pci_create_host_bridge(parent, db, resources, sysdata);
>         if (!host)
>                 return NULL;
>  
> -       return __pci_scan_root_bus(host, ops, sysdata);
> +       return __pci_scan_root_bus(host, ops);
>  }
>  EXPORT_SYMBOL(pci_scan_root_bus);
> 

How about keeping the sysdata out of the pci_create_host_bridge interface, and
refactoring it so that the call sequence becomes

	host = pci_create_host_bridge(parent, db, resources);
	host->sysdata = sysdata;
	__pci_scan_root_bus(host, ops);

This way, we can make sysdata completely option. I assume that more of the
fields we have in sysdata today can get moved into pci_host_bridge
over time, so a host bridge driver can just assign those members individually
between pci_create_host_bridge and __pci_scan_root_bus.

	Arnd
