From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 26 Feb 2015 16:48:30 +0800
Subject: [PATCH v4 4/4] phy: add phy-hi6220-usb
In-Reply-To: <54EC4ECA.2090300@ti.com>
References: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
 <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
 <20150220144119.GB1707@saruman.tx.rr.com> <54E75665.6050205@linaro.org>
 <20150220160610.GB6430@saruman.tx.rr.com> <54E89E29.4010807@linaro.org>
 <20150221162102.GA1784@saruman.tx.rr.com> <54E948AC.2010609@linaro.org>
 <54EC4ECA.2090300@ti.com>
Message-ID: <54EEDDDE.9010608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Roger

On 02/24/2015 06:13 PM, Roger Quadros wrote:
>>> On Sat, Feb 21, 2015 at 11:03:05PM +0800, zhangfei wrote:
>>>>>>>> +static void hi6220_start_peripheral(struct hi6220_priv *priv, bool on)
>>>>>>>> +{
>>>>>>>> +    struct usb_otg *otg = priv->phy.otg;
>>>>>>>> +
>>>>>>>> +    if (!otg->gadget)
>>>>>>>> +        return;
>>>>>>>> +
>>>>>>>> +    if (on)
>>>>>>>> +        usb_gadget_connect(otg->gadget);
>>>>>>>> +    else
>>>>>>>> +        usb_gadget_disconnect(otg->gadget);
>>>>>>>
>>>>>>> why is the PHY fiddling with pullups ?
>>>>>>
>>>>>> We use this to enable/disable otg gadget mode.
>>>>>
>>>>> I got that, but the pullups don't belong to the PHY, they belong to the
>>>>> gadget.
>>>>>
>>>>>> The gpio_id & gpio_vbus are used to distinguish otg gadget mode or
>>>>>> host mode.
>>>>>> When micro usb or otg device attached to otg, gpio_vbus falling down.
>>>>>> And gpio_id = 1 is micro usb, gpio_id = 0 is otg device.
>>>>>
>>>>> all of that I understood clearly :-)
>>>>>
>>>>>> So when micro usb attached, we enable gadget mode; while micro usb
>>>>>> detached, we disable gadget mode, and dwc2 will automatically set to
>>>>>> host mode.
>>>>>
>>>>> that's all fine, I'm concerned about letting the PHY fiddle with
>>>>> something it doesn't own. If I am to change pullups rules in udc-core,
>>>>> this is likely to break down miserably and I don't want to have to go
>>>>> through that.
>>>>
>>>> Thanks for the clarifying.
>>>
>>> no problem.
>>>
>>>> How about using usb_gadget_vbus_connect/disconnect, which are used in many
>>>> files under drivers/usb/phy.
>>>> There is no vbus_session in dwc2/gadget.c, I thought it would be same as
>>>> pullup.
>>>>
>>>> However, usb_gadget_vbus_connect still need para gadget, where should we put
>>>> this file, drivers/usb/phy or drivers/phy
>>>
>>> drivers/phy, if the framework misses anything you need, it's a great
>>> opportunity to give back to the community by extending the framework.
>>
>> Sorry, I am a little confused.
>> I need some concrete suggestion for the next step of this patch, which is required for the community board, hikey board.
>>
>> Do you mean in the future we need use hsotg->phy instead of hsotg->uphy.
>>          struct phy *phy;
>>          struct usb_phy *uphy;
>> usb_phy has many members that struct phy does not have, including otg.
>> struct usb_otg          *otg;
>> Is that mean we need port such member from usb_phy to phy.
>
> In my opinion otg structure should belong to the USB core part that takes care
> of the OTG/DRD state machine. We still don't have a clear solution here and
> I'm currently investigating this.
> My current work is to get Dual role functionality working with DWC3 controller and TI
> platforms.
>
> Currently phy drivers take care of OTG operation themselves but there is an opportunity
> to share code and centralize USB role switching.
> The USB core should be the owner of the Host controller, Gadget controller and the OTG phy
> and should take care of the that.

Good idea.
If you have any patch, I will be very happy to verify.

How about adding these things in drivers/phy/phy-core.c, it is also 
sharable, though not in usb core.

Just tried adding one member struct usb_otg otg to struct phy, since not 
find any good member can hold usb_otg.
In drivers/phy/phy-core.c, adding extcon_register_interest, 
phy_vbus_notifier, phy_set_peripheral, it works for me, dwc2 on hikey board.

>
>>
>> Besides, are you ok with using usb_gadget_vbus_connect/disconnect.
>
> I don't think PHY is the right place for this even though older drivers seem to be doing so.
> But at the same time there is nowhere else to add this at the moment.
> The right place should be the USB core that is aware of host/gadget, phy and the state of the bus.

Understand.

>>> Scratching one's own itch kinda thing...
>>>
>>>>>>>> +static void hi6220_detect_work(struct work_struct *work)
>>>>>>>> +{
>>>>>>>> +    struct hi6220_priv *priv =
>>>>>>>> +        container_of(work, struct hi6220_priv, work.work);
>>>>>>>> +    int gpio_id, gpio_vbus;
>>>>>>>> +    enum usb_otg_state state;
>>>>>>>> +
>>>>>>>> +    if (!gpio_is_valid(priv->gpio_id) || !gpio_is_valid(priv->gpio_vbus))
>>>>>>>> +        return;
>>>>>>>> +
>>>>>>>> +    gpio_id = gpio_get_value_cansleep(priv->gpio_id);
>>>>>>>> +    gpio_vbus = gpio_get_value_cansleep(priv->gpio_vbus);
>>>>>>>
>>>>>>> looks like this should be using extcon
>>>>>> Not used extcon before.
>>>>>> However, we need gpio_vbus interrupt.
>>>>>> Checked phy-tahvo.c and phy-omap-otg.c, not find extcon related with
>>>>>> interrupt.
>>>>>> Will investigate tomorrow.
>>>>>
>>>>> drivers/extcon/extcon-gpio.c
>>>> I think there is no need to use extcon, gpio is clear enough.
>>>> extcon-gpio.c even do not support dt.
>>>
>>> well, add DT. The whole idea of free software is that we improve on
>>> things we already have. EXTCON is *the* API to handle such things.
>>
>
> I wrote the extcon-gpio-usb.c driver for exactly your use case. It is
> queued for v4.1
> https://lkml.org/lkml/2015/2/2/187

That's great, thanks.
>
> It takes care of debouncing for you. Although currently it supports only ID gpio,
> it should be very easy to extend to VBUS sense GPIO.
>
>> I think I am still not understanding extcon-gpio, not sure why need use this API here.
>
> several reasons. Let me list a few.
> 1) Code reuse. Every PHY driver doesn't need to implement GPIO/interrupt handling and debouncing.
> It just registers what cable events it wants to hear and gets a notification.
> 2) The events (ID/VBUS) are not only interesting for the PHY driver but also the controller
> driver and the OTG state machine (whenever it exists at a common place) ;).
> 3) standardization because of common API.

Thanks for the explanation.

Zhangfei
