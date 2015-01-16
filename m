From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 10:23:11 +0100
Subject: [PATCH 11/28] PCI: Introduce pci_host_bridge_ops to setup host
 bridge
In-Reply-To: <1421372666-12288-12-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-12-git-send-email-wangyijing@huawei.com>
Message-ID: <1443278.UW4hQ0rXtr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 09:44:09 Yijing Wang wrote:
> @@ -2064,7 +2073,7 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, u32 db,
>  {
>         struct pci_host_bridge *host;
>  
> -       host = pci_create_host_bridge(parent, db, resources, sysdata);
> +       host = pci_create_host_bridge(parent, db, resources, sysdata, NULL);
>         if (!host)
>                 return NULL;
>  
> 

Same comment as for patch 10: If we leave this out of the pci_create_host_bridge
argument but set it later, ?e interface becomes simpler for callers that
don't have custom pci_host_bridge_ops.

This would break your phb_prepare() callback, but I assume a host driver
can just make a direct function call before entering pci_create_host_bridge
for this. Let me know if I'm missing something here.

	Arnd
