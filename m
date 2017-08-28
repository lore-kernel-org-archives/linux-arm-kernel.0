From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 28 Aug 2017 11:31:36 -0400
Subject: [PATCH] usb: dwc3: Initialize DMA ops/mask for xhci-hcd
In-Reply-To: <d0e84021-15c0-4a34-323c-66dba67942ab@ti.com>
References: <1503684135-24207-1-git-send-email-awallis@codeaurora.org>
 <d0e84021-15c0-4a34-323c-66dba67942ab@ti.com>
Message-ID: <6fd85414-baee-046c-1831-e38898da5924@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/25/2017 7:03 PM, Grygorii Strashko wrote:
> 
> 
> On 08/25/2017 01:02 PM, Adam Wallis wrote:
>> The dma ops from the parent DWC device are not getting passed to the
>> child xhci-hcd device. This patch makes use of
>> platform_device_register_full to set the DMA ops. For the DT/OF case,
>> dma_ops were still null after the the device register, so
>> of_dma_configure is called in only the OF case.
>>
>> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> 
> Hm. There were set of fixes in this area recently which actually removed
> settings you are going to restore

The set of fixes works for DWC if it is a child device, but in my testing, those
DMA settings do not get propagated to the created xHCI-hcd child device (which
is instantiated in dwc3_host_init). I see the same behavior with ACPI and
Device-Tree/OF boot.

> 
> 4c39d4b usb: xhci: use bus->sysdev for DMA configuration
> 
> d64ff40 usb: dwc3: use bus->sysdev for DMA configuration
> 
>> ---
>> ? drivers/usb/dwc3/host.c | 39 +++++++++++++++++----------------------
>> ? 1 file changed, 17 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index 76f0b0d..662e9e2 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -16,6 +16,7 @@
>> ?? */
>> ? ? #include <linux/platform_device.h>
>> +#include <linux/of_platform.h>
>> ? ? #include "core.h"
>> ? @@ -56,6 +57,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>> ? {
>> ????? struct property_entry??? props[3];
>> ????? struct platform_device??? *xhci;
>> +??? struct platform_device_info dwc_plat_info = {};
>> ????? int??????????? ret, irq;
>> ????? struct resource??????? *res;
>> ????? struct platform_device??? *dwc3_pdev = to_platform_device(dwc->dev);
>> @@ -79,22 +81,22 @@ int dwc3_host_init(struct dwc3 *dwc)
>> ????? dwc->xhci_resources[1].flags = res->flags;
>> ????? dwc->xhci_resources[1].name = res->name;
>> ? -??? xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
>> -??? if (!xhci) {
>> -??????? dev_err(dwc->dev, "couldn't allocate xHCI device\n");
>> -??????? return -ENOMEM;
>> -??? }
>> +??? dwc_plat_info.name = "xhci-hcd";
>> +??? dwc_plat_info.parent = dwc->dev;
>> +??? dwc_plat_info.res = dwc->xhci_resources;
>> +??? dwc_plat_info.num_res = DWC3_XHCI_RESOURCES_NUM;
>> +??? dwc_plat_info.fwnode = dwc->dev->fwnode;
>> +??? dwc_plat_info.dma_mask = *dwc->dev->dma_mask;
>> ? -??? xhci->dev.parent??? = dwc->dev;
>> +??? xhci = platform_device_register_full(&dwc_plat_info);
>> +??? if (IS_ERR(xhci)) {
>> +??????? dev_err(dwc->dev, "failed to register xHCI device\n");
>> +??????? return PTR_ERR(xhci);
>> +??? }
>> ? ????? dwc->xhci = xhci;
>> -
>> -??? ret = platform_device_add_resources(xhci, dwc->xhci_resources,
>> -??????????????????????? DWC3_XHCI_RESOURCES_NUM);
>> -??? if (ret) {
>> -??????? dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
>> -??????? goto err1;
>> -??? }
>> +??? if (dwc->dev->of_node)
>> +??????? of_dma_configure(&xhci->dev, dwc->dev->of_node);
>> ? ????? memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>> ? @@ -117,7 +119,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>> ????????? ret = platform_device_add_properties(xhci, props);
>> ????????? if (ret) {
>> ????????????? dev_err(dwc->dev, "failed to add properties to xHCI\n");
>> -??????????? goto err1;
>> +??????????? goto err;
>> ????????? }
>> ????? }
>> ? @@ -126,19 +128,12 @@ int dwc3_host_init(struct dwc3 *dwc)
>> ????? phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
>> ??????????????? dev_name(dwc->dev));
>> ? -??? ret = platform_device_add(xhci);
>> -??? if (ret) {
>> -??????? dev_err(dwc->dev, "failed to register xHCI device\n");
>> -??????? goto err2;
>> -??? }
>> -
>> ????? return 0;
>> -err2:
>> +err:
>> ????? phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
>> ??????????????? dev_name(dwc->dev));
>> ????? phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
>> ??????????????? dev_name(dwc->dev));
>> -err1:
>> ????? platform_device_put(xhci);
>> ????? return ret;
>> ? }
>>
> 


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
