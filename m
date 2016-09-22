From: sriram.dash@nxp.com (Sriram Dash)
Date: Thu, 22 Sep 2016 05:02:17 +0000
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20042182.GcPMJken6Z@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3596831.dckG5peiyF@wuerfel>
 <DB5PR0401MB1925CDF6CBD45ACBEE95D152F5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
 <20042182.GcPMJken6Z@wuerfel>
Message-ID: <DB5PR0401MB1925E5980009DD23FA9C7D50F5C90@DB5PR0401MB1925.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Arnd Bergmann [mailto:arnd at arndb.de]
>On Wednesday, September 21, 2016 11:43:59 AM CEST Sriram Dash wrote:
>> >From: Arnd Bergmann [mailto:arnd at arndb.de] On Wednesday, September
>> >21, 2016 11:06:47 AM CEST Sriram Dash wrote:
>>
>> ==============================================================
>> From 8b0dea1513e9e73a11dcfa802ddc71cca11d66f8 Mon Sep 17 00:00:00 2001
>> From: Sriram Dash <sriram.dash@nxp.com>
>> Date: Wed, 21 Sep 2016 11:39:30 +0530
>> Subject: [PATCH] usb: xhci: Fix the patch inherit dma configuration
>> from  parent dev
>>
>> Fixes the patch https://patchwork.kernel.org/patch/9319527/
>> ("usb: dwc3: host: inherit dma configuration from parent dev").
>>
>> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
>> ---
>>  drivers/usb/host/xhci-mem.c | 12 ++++++------
>>  drivers/usb/host/xhci.c     | 20 ++++++++++----------
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index 6afe323..79608df 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>
>All the changes you did to this file seem fine, I completely missed that part.
>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c index
>> 01d96c9..9a1ff09 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c

Yes. Some sanity is required over this patch.

>> @@ -231,7 +231,7 @@ static int xhci_free_msi(struct xhci_hcd *xhci)
>> static int xhci_setup_msi(struct xhci_hcd *xhci)  {
>>  	int ret;
>> -	struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
>> +	struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
>>
>>  	ret = pci_enable_msi(pdev);
>>  	if (ret) {
>
>This one is interesting as I stumbled over some code comment mentioning that for
>dwc3-pci, we don't support MSI. I think with this change, we /can/ actually support
>MSI, but this could be a separate patch and we'd have to test it on dwc3-pci
>hardware. Same for most of this file.
>
>> @@ -745,7 +745,7 @@ void xhci_shutdown(struct usb_hcd *hcd)
>>  	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>>
>>  	if (xhci->quirks & XHCI_SPURIOUS_REBOOT)
>> -		usb_disable_xhci_ports(to_pci_dev(hcd->self.controller));
>> +		usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
>>
>>  	spin_lock_irq(&xhci->lock);
>>  	xhci_halt(xhci);
>
>This seems obviously correct, but I don't yet see why it currently works. We
>probably don't call this function on dwc3.
>
>>  #ifdef CONFIG_PM
>> @@ -3605,7 +3605,7 @@ void xhci_free_dev(struct usb_hcd *hcd, struct
>usb_device *udev)
>>  	 * if no devices remain.
>>  	 */
>>  	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>> -		pm_runtime_put_noidle(hcd->self.controller);
>> +		pm_runtime_put_noidle(hcd->self.sysdev);
>>  #endif
>>
>>  	ret = xhci_check_args(hcd, udev, NULL, 0, true, __func__);
>
>I suspect this one is wrong, based on what Felipe explained earlier:
>the power management should propagate down from the child to the parent
>device.
>
>Someone who understands this better than I do should look at it.
>
>> @@ -3745,7 +3745,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct
>usb_device *udev)
>>  	 * suspend if there is a device attached.
>>  	 */
>>  	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>> -		pm_runtime_get_noresume(hcd->self.controller);
>> +		pm_runtime_get_noresume(hcd->self.sysdev);
>>  #endif
>>
>>
>
>Same here.
>
>> @@ -4834,7 +4834,7 @@ int xhci_get_frame(struct usb_hcd *hcd)  int
>> xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)  {
>>  	struct xhci_hcd		*xhci;
>> -	struct device		*dev = hcd->self.controller;
>> +	struct device		*dev = hcd->self.sysdev;
>>  	int			retval;
>
>
>This one calls
>
>        get_quirks(dev, xhci);
>
>not sure whether this should be called with self.controller or self.sysdev, we should
>audit every one of the callers here to be sure:
>
>drivers/usb/host/xhci-mtk.c:    return xhci_gen_setup(hcd, xhci_mtk_quirks);
>drivers/usb/host/xhci-pci.c:    retval = xhci_gen_setup(hcd, xhci_pci_quirks);
>drivers/usb/host/xhci-plat.c:   return xhci_gen_setup(hcd, xhci_plat_quirks);
>drivers/usb/host/xhci-rcar.c:    * xhci_gen_setup().
>drivers/usb/host/xhci-tegra.c:  return xhci_gen_setup(hcd, tegra_xhci_quirks);
>
>	Arnd
