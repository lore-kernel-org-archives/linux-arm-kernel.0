From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 25 Feb 2015 21:28:36 +0800
Subject: [PATCH v4 4/4] phy: add phy-hi6220-usb
In-Reply-To: <20150223153612.GF32701@saruman.tx.rr.com>
References: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
 <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
 <20150220144119.GB1707@saruman.tx.rr.com> <54E75665.6050205@linaro.org>
 <20150220160610.GB6430@saruman.tx.rr.com> <54E89E29.4010807@linaro.org>
 <20150221162102.GA1784@saruman.tx.rr.com> <54E948AC.2010609@linaro.org>
 <20150223153612.GF32701@saruman.tx.rr.com>
Message-ID: <54EDCE04.3040404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/23/2015 11:36 PM, Felipe Balbi wrote:
> Hi,
>
> On Sun, Feb 22, 2015 at 11:10:36AM +0800, zhangfei wrote:
>>>>>>>> +static void hi6220_start_peripheral(struct hi6220_priv *priv, bool on)
>>>>>>>> +{
>>>>>>>> +	struct usb_otg *otg = priv->phy.otg;
>>>>>>>> +
>>>>>>>> +	if (!otg->gadget)
>>>>>>>> +		return;
>>>>>>>> +
>>>>>>>> +	if (on)
>>>>>>>> +		usb_gadget_connect(otg->gadget);
>>>>>>>> +	else
>>>>>>>> +		usb_gadget_disconnect(otg->gadget);
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
>> I need some concrete suggestion for the next step of this patch, which is
>> required for the community board, hikey board.
>>
>> Do you mean in the future we need use hsotg->phy instead of hsotg->uphy.
>>          struct phy *phy;
>>          struct usb_phy *uphy;
>
> yes, we need to move everybody to use struct phy, instead of struct
> usb_phy.
>
>> usb_phy has many members that struct phy does not have, including otg.
>> struct usb_otg          *otg;
>> Is that mean we need port such member from usb_phy to phy.
>
> This means we have a little ground work to do before we can add your phy
> driver to that framework, right ? As I said, if the framework is missing
> anything, work with Kishon (generic phy maintainer) to add those missing
> pieces generically.

OK, got it.
>
>> Besides, are you ok with using usb_gadget_vbus_connect/disconnect.
>>
>>>
>>> Scratching one's own itch kinda thing...
>>>
>>>>>>>> +static void hi6220_detect_work(struct work_struct *work)
>>>>>>>> +{
>>>>>>>> +	struct hi6220_priv *priv =
>>>>>>>> +		container_of(work, struct hi6220_priv, work.work);
>>>>>>>> +	int gpio_id, gpio_vbus;
>>>>>>>> +	enum usb_otg_state state;
>>>>>>>> +
>>>>>>>> +	if (!gpio_is_valid(priv->gpio_id) || !gpio_is_valid(priv->gpio_vbus))
>>>>>>>> +		return;
>>>>>>>> +
>>>>>>>> +	gpio_id = gpio_get_value_cansleep(priv->gpio_id);
>>>>>>>> +	gpio_vbus = gpio_get_value_cansleep(priv->gpio_vbus);
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
>> I think I am still not understanding extcon-gpio, not sure why need
>> use this API here.
>
> because extcon is the API to use for external connectors. The same way
> you use regulator framework to control that single GPIO tied to an
> enable signal of a fixed regulator, you use extcon when you need to read
> that gpio signal tied to id pin of the USB connector.
>
>> Here two gpio requires, one gpio as interrupt, in the interrupt
>> handler, we detect the gpio status judging the otg status.
>> extcon-gpio.c use the interrupt, then can we also use the gpio
>> interrupt.  Using extcon-gpio is used for saving gpio_request?
>
> extcon is used to hide gpio_request from dwc2. dwc2 only knows about
> extcon, not gpios. extcon will request the gpio and use it as interrupt
> source. When an IRQ fires, it will read the gpio state and decide if it
> should broadcast a message to tell dwc2 to become host or peripheral.

Thanks for the kind education, understand now.
