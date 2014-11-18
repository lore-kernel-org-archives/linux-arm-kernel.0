From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 18 Nov 2014 15:44:23 +0800
Subject: [RFC PATCH 01/16] PCI: Enhance pci_scan_root_bus() to support
 default IO/MEM resources
In-Reply-To: <2732970.7HG94QvVBv@wuerfel>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-2-git-send-email-wangyijing@huawei.com>
 <2732970.7HG94QvVBv@wuerfel>
Message-ID: <546AF8D7.9010103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/17 18:08, Arnd Bergmann wrote:
> On Monday 17 November 2014 18:21:35 Yijing Wang wrote:
>> -       list_for_each_entry(window, resources, list)
>> -               if (window->res->flags & IORESOURCE_BUS) {
>> -                       found = true;
>> -                       break;
>> -               }
>> +       if (!resources) {
>> +               pci_add_resource(&default_res, &ioport_resource);
>> +               pci_add_resource(&default_res, &iomem_resource);
>> +               pci_add_resource(&default_res, &busn_resource);
>> +       } else {
>>
> 
> Isn't it almost always wrong to do this? You are adding all of the
> I/O ports and memory to the host bridge, which will prevent you from
> adding another host bridge, and the iomem_resource normally
> includes a lot of addresses that are not accessible by the PCI host.

Hi Arnd, pci host bridge windows are the ranges allow child devices to setup
from. Add all of IO/MEM here just a limit to child devices, no request for these
resources, so it won't hurt another host bridge. Some platforms have no dts or ACPI
report host bridge resources, in this case, we directly assign ioport/iomem_resources
as the root resources of PCI devices.

Thanks!
Yijing.

> 
> 	Arnd
> 
> .
> 


-- 
Thanks!
Yijing
