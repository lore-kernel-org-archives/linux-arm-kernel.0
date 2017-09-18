From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Mon, 18 Sep 2017 13:27:14 +0200
Subject: [PATCH 2/2] phy: exynos5-usbdrd: Calibrate LOS levels for
 exynos5420/5800
In-Reply-To: <e1e1b4e5-0678-faaf-e97b-b18095342af2@ti.com>
References: <1505728934-6200-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170918100944eucas1p2735d3d6a6ee562b927fb9dfaeb0d4090@eucas1p2.samsung.com>
 <1505729371-6509-1-git-send-email-andrzej.p@samsung.com>
 <87y3pcmgv6.fsf@linux.intel.com>
 <e1e1b4e5-0678-faaf-e97b-b18095342af2@ti.com>
Message-ID: <96001441-2a67-ac9c-a606-eac66138d09e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 18.09.2017 o?13:06, Kishon Vijay Abraham I pisze:
> Hi,
> 
> On Monday 18 September 2017 04:08 PM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Andrzej Pietrasiewicz <andrzej.p@samsung.com> writes:
>>> From: Vivek Gautam <gautam.vivek@samsung.com>
>>>
>>> Adding phy calibration sequence for USB 3.0 DRD PHY present on
>>> Exynos5420/5800 systems.

<snip>

>>>   
>>> +static int exynos5_usbdrd_phy_reset(struct phy *phy)
>>> +{
>>> +	struct phy_usb_instance *inst = phy_get_drvdata(phy);
>>> +	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
>>> +
>>> +	return exynos5420_usbdrd_phy_calibrate(phy_drd);
>>> +}
>>> +
>>>   static const struct phy_ops exynos5_usbdrd_phy_ops = {
>>>   	.init		= exynos5_usbdrd_phy_init,
>>>   	.exit		= exynos5_usbdrd_phy_exit,
>>>   	.power_on	= exynos5_usbdrd_phy_power_on,
>>>   	.power_off	= exynos5_usbdrd_phy_power_off,
>>> +	.reset		= exynos5_usbdrd_phy_reset,
>>>   	.owner		= THIS_MODULE,
>>>   };
>>>   
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 03474d3..1d5836e 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -156,9 +156,10 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>   		} else {
>>>   			if (dwc->usb2_phy)
>>>   				otg_set_vbus(dwc->usb2_phy->otg, true);
>>> -			if (dwc->usb2_generic_phy)
>>> +			if (dwc->usb2_generic_phy) {
>>>   				phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>> -
>>> +				phy_reset(dwc->usb2_generic_phy);
>>
>> it doesn't look like this is the best place to reset the phy. Also,
> 
> right, phy_reset is done during initialization before phy_power_on/phy_init or
> in error cases.
> 
>> ->reset() doesn't seem to match correctly with a calibration. That seems
>> to be more fitting to a ->power_on() or ->init() implementation.
> 
> yeah, the initial patch seems to calibrate in phy_init(). Not sure why it's
> modified.

The original patch used a hack like below, in xhci_plat_probe():

+       /* Initialize and power-on USB 3.0 PHY */
+       xhci->shared_hcd->phy->init_count = 0;
+       ret = phy_init(xhci->shared_hcd->phy);
+       if (ret)
+               goto dealloc_usb3_hcd;
+
+       xhci->shared_hcd->phy->power_count = 0;
+       ret = phy_power_on(xhci->shared_hcd->phy);
+       if (ret) {
+               phy_exit(xhci->shared_hcd->phy);
+               goto dealloc_usb3_hcd;
+       }
+

Manually setting init_count to 0 in order for the subsequent phy_init() to
happen probably does not look good.

The calibration is clearly needed. However, I don't have any strong opinions
on from which place exactly to trigger the calibration process.
The original patch did not make it upstream, but if that patch is ok,
it is perfectly fine with me to drop my version and take that one instead.

Andrzej
