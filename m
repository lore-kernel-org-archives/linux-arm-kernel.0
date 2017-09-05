From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 5 Sep 2017 10:25:19 -0400
Subject: [PATCH V2] usb: host: xhci-plat: allow sysdev to inherit from ACPI
In-Reply-To: <20170905141658.GA30341@kroah.com>
References: <1504619849-4567-1-git-send-email-awallis@codeaurora.org>
 <20170905141658.GA30341@kroah.com>
Message-ID: <a3e40fb9-8411-5de3-7c15-19d91ff98aaa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/5/2017 10:16 AM, Greg Kroah-Hartman wrote:
> On Tue, Sep 05, 2017 at 09:57:29AM -0400, Adam Wallis wrote:
>> Currently, xhci_plat is not set up properly when the parent device is an
>> ACPI node. The conditions that xhci_plat_probe should satisfy are
>>
>> 1. xhci_plat comes from firmware
>> 2. xhci_plat is child of a device from firmware (dwc3-plat)
>> 3. xhci_plat is grandchild of a pci device (dwc3-pci)
>>
>> Case 2 is covered when the child is an OF node (by checking
>> sysdev->parent->of_node), however, an ACPI parent will return NULL in
>> the of_node check and will thus not result in sysdev being set to
>> sysdev->parent
>>
>> [   17.591549] xhci-hcd: probe of xhci-hcd.6.auto failed with error -5
>>
>> This change adds a check for ACPI to completely allow for condition 2.
>> This is done by first checking if the parent node is of type ACPI (e.g.,
>> dwc3-plat) and set sysdev to sysdev->parent if either of the two
>> following conditions are met:
>>
>> 1: If fwnode is empty (in the case that platform_device_add_properties
>> was not called on the allocated platform device)
>> 2: fwnode exists but is not of type ACPI (this would happen if
>> platform_device_add_properties was called on the allocated device.
>> Instead of type FWNODE_ACPI, you would end up with FWNODE_PDATA)
>>
>> Cc: stable at vger.kernel.org #4.12.x
>> Cc: stable at vger.kernel.org #4.13.x
> 
> What bug is this fixing that needs to go into the stable kernel trees?
> Is this a regression, or a new feature for those versions?
> 
Greg

The following patch

4c39d4b949d36f usb: xhci: use bus->sysdev for DMA configuration

provided an incomplete check for all firmware nodes (only checked for PCI and OF
case, but not the ACPI case). This bug affects the 4.12 and 4.13 kernels.

Adam

> thanks,
> 
> greg k-h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
