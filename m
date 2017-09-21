From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 21 Sep 2017 16:37:52 +0530
Subject: [PATCH 2/2] phy: exynos5-usbdrd: Calibrate LOS levels for
 exynos5420/5800
In-Reply-To: <7d87727a-e65e-f25b-0cdc-fe6ff0b7bb90@samsung.com>
References: <1505728934-6200-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170918100944eucas1p2735d3d6a6ee562b927fb9dfaeb0d4090@eucas1p2.samsung.com>
 <1505729371-6509-1-git-send-email-andrzej.p@samsung.com>
 <87y3pcmgv6.fsf@linux.intel.com>
 <e1e1b4e5-0678-faaf-e97b-b18095342af2@ti.com>
 <96001441-2a67-ac9c-a606-eac66138d09e@samsung.com>
 <5c90f022-5cb1-c746-6015-c93a58805cfe@samsung.com>
 <87vakgmb24.fsf@linux.intel.com>
 <7d87727a-e65e-f25b-0cdc-fe6ff0b7bb90@samsung.com>
Message-ID: <ba580a0c-36c3-b227-61ee-97637532823e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 18 September 2017 07:50 PM, Andrzej Pietrasiewicz wrote:
> Hi,
> 
> W dniu 18.09.2017 o 14:43, Felipe Balbi pisze:
>>
>> Hi,
>>
>> Andrzej Pietrasiewicz <andrzej.p@samsung.com> writes:
>>>>>>> +static int exynos5_usbdrd_phy_reset(struct phy *phy)
>>>>>>> +{
>>>>>>> +    struct phy_usb_instance *inst = phy_get_drvdata(phy);
>>>>>>> +    struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
>>>>>>> +
>>>>>>> +    return exynos5420_usbdrd_phy_calibrate(phy_drd);
>>>>>>> +}
>>>>>>> +
>>>>>>>     static const struct phy_ops exynos5_usbdrd_phy_ops = {
>>>>>>>         .init        = exynos5_usbdrd_phy_init,
>>>>>>>         .exit        = exynos5_usbdrd_phy_exit,
>>>>>>>         .power_on    = exynos5_usbdrd_phy_power_on,
>>>>>>>         .power_off    = exynos5_usbdrd_phy_power_off,
>>>>>>> +    .reset        = exynos5_usbdrd_phy_reset,
>>>>>>>         .owner        = THIS_MODULE,
>>>>>>>     };
>>>>>>>     diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>>>> index 03474d3..1d5836e 100644
>>>>>>> --- a/drivers/usb/dwc3/core.c
>>>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>>>> @@ -156,9 +156,10 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>>>>>             } else {
>>>>>>>                 if (dwc->usb2_phy)
>>>>>>>                     otg_set_vbus(dwc->usb2_phy->otg, true);
>>>>>>> -            if (dwc->usb2_generic_phy)
>>>>>>> +            if (dwc->usb2_generic_phy) {
>>>>>>>                     phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>>>>>> -
>>>>>>> +                phy_reset(dwc->usb2_generic_phy);
>>>>>>
>>>>>> it doesn't look like this is the best place to reset the phy. Also,
>>>>>
>>>>> right, phy_reset is done during initialization before
>>>>> phy_power_on/phy_init or
>>>>> in error cases.
>>>>>
>>>>>> ->reset() doesn't seem to match correctly with a calibration. That seems
>>>>>> to be more fitting to a ->power_on() or ->init() implementation.
>>>>>
>>>>> yeah, the initial patch seems to calibrate in phy_init(). Not sure why it's
>>>>> modified.
>>>>
>>>> The original patch used a hack like below, in xhci_plat_probe():
>>>>
>>>> +       /* Initialize and power-on USB 3.0 PHY */
>>>> +       xhci->shared_hcd->phy->init_count = 0;
>>>> +       ret = phy_init(xhci->shared_hcd->phy);
>>>> +       if (ret)
>>>> +               goto dealloc_usb3_hcd;
>>>> +
>>>> +       xhci->shared_hcd->phy->power_count = 0;
>>>> +       ret = phy_power_on(xhci->shared_hcd->phy);
>>>> +       if (ret) {
>>>> +               phy_exit(xhci->shared_hcd->phy);
>>>> +               goto dealloc_usb3_hcd;
>>>> +       }
>>>> +
>>>>
>>>> Manually setting init_count to 0 in order for the subsequent phy_init() to
>>>> happen probably does not look good.
>>>>
>>>> The calibration is clearly needed. However, I don't have any strong opinions
>>>> on from which place exactly to trigger the calibration process.
>>>> The original patch did not make it upstream, but if that patch is ok,
>>>> it is perfectly fine with me to drop my version and take that one instead.
>>>
>>> Me bad, I did not write about an important issue.
>>> The calibration must happen after usb_add_hcd(), otherwise
>>> usb_add_hcd() indirectly triggers overwriting the effects of calibration.
>>
>> in that case, you should do that from xhci-plat indeed. I think the
>> whole idea with init_count is just to make sure you don't initialize it
>> twice.
> 
> As far as I understand the code in question the desired result is exactly the
> opposite:
> to make sure it _does_ initialize twice, otherwise after the first
> initialization the
> calibration results were lost. In other words, in the code snippet above,
> in xhci_plat_probe() the phy_init() was creatively (ab)used in order to force
> the calibration at a desired moment, while in the original invocation of
> phy_init()
> the calibration result was merely a short-term side effect discarded soon
> afterwards.
> 
>>
>> One thing's for sure, ->reset() doesn't seem to be the matching callback
>> for you to use and, given your explanation above, dwc3 doesn't seem to
>> be the right place to fiddle with that.
>>
>> Seems like we need an extension of the generic PHY framework to cope
>> with your requirement.
>>
> 
> Here are old patches from Vivek:
> 
> https://lkml.org/lkml/2014/9/2/166
> 
> In particular:
> 
> https://lkml.org/lkml/2014/9/2/170
> 
> Please see the discussion that follows the latter.
> 
> All in all, is adding the calibrate() method to phy_ops the way to go or not?

Adding calibrate is fine but doing init() and power_on() in one driver and
calibrate() in another doesn't look correct. Why not let xhci do init() and
power_on() of phy instead of dwc3?

Thanks
Kishon
