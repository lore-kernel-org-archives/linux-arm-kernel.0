From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 4 Dec 2017 08:37:15 -0500
Subject: [PATCH v3] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <82fc73c9-96d5-adc5-e2d1-d777ed861119@linux.intel.com>
References: <1512143059-25674-1-git-send-email-awallis@codeaurora.org>
 <1512271374.17567.164.camel@mhfsdcap03>
 <82fc73c9-96d5-adc5-e2d1-d777ed861119@linux.intel.com>
Message-ID: <06b11224-b2fc-3b6a-0007-e6da4ce7622a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/2017 3:57 AM, Mathias Nyman wrote:
> On 03.12.2017 05:22, Chunfeng Yun wrote:
>> On Fri, 2017-12-01 at 10:44 -0500, Adam Wallis wrote:
>>> The xHCI driver currently has the IMOD set to 160, which
>>> translates to an IMOD interval of 40,000ns (160 * 250)ns
>>>
>>> Commit 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
>>> introduced a QUIRK for the MTK platform to adjust this interval to 20,
>>> which translates to an IMOD interval of 5,000ns (20 * 250)ns. This is
>>> due to the fact that the MTK controller IMOD interval is 8 times
>>> as much as defined in xHCI spec.
>>>
>>> Instead of adding more quirk bits for additional platforms, this patch
>>> introduces the ability for vendors to set the IMOD_INTERVAL as is
>>> optimal for their platform. By using device_property_read_u32() on
>>> "imod-interval", the IMOD INTERVAL can be specified in nano seconds. If
>>> no interval is specified, the default of 40,000ns (IMOD=160) will be
>>> used.
>>>
>>> No bounds checking has been implemented due to the fact that a vendor
>>> may have violated the spec and would need to specify a value outside of
>>> the max 8,000 IRQs/second limit specified in the xHCI spec.
>>>
>>> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
>>> ---
>>> changes from v2:
>>> ?? * Added PCI default value [Mathias]
>>> ?? * Removed xhci-mtk.h from xhci-plat.c [Chunfeng Yun]
>>> ?? * Removed MTK quirk from xhci-plat and moved logic to xhci-mtk [Chunfeng]
>>> ?? * Updated bindings Documentation to use proper units [Rob Herring]
>>> ?? * Added imod-interval description and example to MTK binding documentation
>>> changes from v1:
>>> ?? * Removed device_property_read_u32() per suggestion from greg k-h
>>> ?? * Used ER_IRQ_INTERVAL_MASK in place of (u16) cast
>>>
>>> ? Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 2 ++
>>> ? Documentation/devicetree/bindings/usb/usb-xhci.txt????????? | 1 +
>>> ? drivers/usb/host/xhci-mtk.c???????????????????????????????? | 9 +++++++++
>>> ? drivers/usb/host/xhci-pci.c???????????????????????????????? | 3 +++
>>> ? drivers/usb/host/xhci-plat.c??????????????????????????????? | 4 ++++
>>> ? drivers/usb/host/xhci.c???????????????????????????????????? | 7 ++-----
>>> ? drivers/usb/host/xhci.h???????????????????????????????????? | 2 ++
>>> ? 7 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
>>> b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
>>> index 3059596..45bbf18 100644
>>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
>>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
>>> @@ -46,6 +46,7 @@ Optional properties:
>>> ?? - pinctrl-names : a pinctrl state named "default" must be defined
>>> ?? - pinctrl-0 : pin control group
>>> ????? See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>> + - imod-interval: Default interval is 5000ns
>> I think, as Rob suggested before, recommend to have a unit suffix
>> appended to the property name.
>> s/imod-interval/imod-interval-ns
>> ?
>>> ? ? Example:
>>> ? usb30: usb at 11270000 {
>>> @@ -66,6 +67,7 @@ usb30: usb at 11270000 {
>>> ????? usb3-lpm-capable;
>>> ????? mediatek,syscon-wakeup = <&pericfg>;
>>> ????? mediatek,wakeup-src = <1>;
>>> +??? imod-interval = <10000>;
>>> ? };
>>> ? ? 2nd: dual-role mode with xHCI driver
>>> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt
>>> b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>>> index ae6e484..89b68f1 100644
>>> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
>>> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>>> @@ -29,6 +29,7 @@ Optional properties:
>>> ??? - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
>>> ??? - usb3-lpm-capable: determines if platform is USB3 LPM capable
>>> ??? - quirk-broken-port-ped: set if the controller has broken port disable
>>> mechanism
>>> +? - imod-interval: Default interval is 40000ns
>>> ? ? Example:
>>> ????? usb at f0931000 {
>>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
>>> index b62a1d2..278ea3b 100644
>>> --- a/drivers/usb/host/xhci-mtk.c
>>> +++ b/drivers/usb/host/xhci-mtk.c
>>> @@ -674,6 +674,15 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>>> ? ????? xhci = hcd_to_xhci(hcd);
>>> ????? xhci->main_hcd = hcd;
>>> +
>>> +??? /*
>>> +???? * imod_interval is the interrupt modulation value in nanoseconds.
>>> +???? * The increment interval is 8 times as much as that defined in
>>> +???? * the xHCI spec on MTK's controller.
>>> +???? */
>>> +??? xhci->imod_interval = 5000;
>>> +??? device_property_read_u32(dev, "imod-interval", &xhci->imod_interval);
>>> +
>>> ????? xhci->shared_hcd = usb_create_shared_hcd(driver, dev,
>>> ????????????? dev_name(dev), hcd);
>>> ????? if (!xhci->shared_hcd) {
>>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>> index 7ef1274..efbe57b 100644
>>> --- a/drivers/usb/host/xhci-pci.c
>>> +++ b/drivers/usb/host/xhci-pci.c
>>> @@ -234,6 +234,9 @@ static int xhci_pci_setup(struct usb_hcd *hcd)
>>> ????? if (!xhci->sbrn)
>>> ????????? pci_read_config_byte(pdev, XHCI_SBRN_OFFSET, &xhci->sbrn);
>>> ? +??? /* imod_interval is the interrupt modulation value in nanoseconds. */
>>> +??? xhci->imod_interval = 40000;
>>> +
>>> ????? retval = xhci_gen_setup(hcd, xhci_pci_quirks);
>>> ????? if (retval)
>>> ????????? return retval;
>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>> index 09f164f..b78be87 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
>>> @@ -269,6 +269,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>> ????? if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
>>> ????????? xhci->quirks |= XHCI_BROKEN_PORT_PED;
>>> ? +??? /* imod_interval is the interrupt modulation value in nanoseconds. */
>>> +??? xhci->imod_interval = 40000;
>>> +??? device_property_read_u32(sysdev, "imod-interval", &xhci->imod_interval);
>>> +
>>> ????? hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
>>> ????? if (IS_ERR(hcd->usb_phy)) {
>>> ????????? ret = PTR_ERR(hcd->usb_phy);
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index 2424d30..0b7755b 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>>> @@ -586,11 +586,8 @@ int xhci_run(struct usb_hcd *hcd)
>>> ????????????? "// Set the interrupt modulation register");
> 
> Just noticed the driver has all the time incorrectly used the word "modulation"
> instead
> of "moderation".
> 
> If you do the bindings change that Chunfeng pointed out above could you also change
> the "modulation" to "moderation" in this patch.

Sure thing, I will make the change for this patch.

> 
> Don't worry about changing the old ones. There's a cleanup patch on its way that
> will remove most of them anyway.
> 
> Otherwise the xhci parts look good to me.
> 
> -Mathias
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at? http://vger.kernel.org/majordomo-info.html


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
