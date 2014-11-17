From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Nov 2014 11:08:34 +0100
Subject: [RFC PATCH 01/16] PCI: Enhance pci_scan_root_bus() to support
 default IO/MEM resources
In-Reply-To: <1416219710-26088-2-git-send-email-wangyijing@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-2-git-send-email-wangyijing@huawei.com>
Message-ID: <2732970.7HG94QvVBv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 November 2014 18:21:35 Yijing Wang wrote:
> -       list_for_each_entry(window, resources, list)
> -               if (window->res->flags & IORESOURCE_BUS) {
> -                       found = true;
> -                       break;
> -               }
> +       if (!resources) {
> +               pci_add_resource(&default_res, &ioport_resource);
> +               pci_add_resource(&default_res, &iomem_resource);
> +               pci_add_resource(&default_res, &busn_resource);
> +       } else {
> 

Isn't it almost always wrong to do this? You are adding all of the
I/O ports and memory to the host bridge, which will prevent you from
adding another host bridge, and the iomem_resource normally
includes a lot of addresses that are not accessible by the PCI host.

	Arnd
