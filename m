From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 18 Aug 2016 11:05:46 +0200
Subject: [PATCH v2 4/7] phy-sun4i-usb: Add support for phy_set_mode
In-Reply-To: <877fbe5xuk.fsf@linux.intel.com>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
 <1471288892-21702-5-git-send-email-hdegoede@redhat.com>
 <6058a676-1e2c-0301-6edd-eee64b515b51@cogentembedded.com>
 <93bda5ac-4548-9e92-742c-baba7ed52849@redhat.com>
 <877fbe5xuk.fsf@linux.intel.com>
Message-ID: <bf40c95d-ae2e-8980-90c9-f68415b06461@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On 18-08-16 09:40, Felipe Balbi wrote:
>
> Hi,
>
> Hans de Goede <hdegoede@redhat.com> writes:
>> Hi,
>>
>> On 08/16/2016 03:48 PM, Sergei Shtylyov wrote:
>>> Hello.
>>>
>>> On 08/15/2016 10:21 PM, Hans de Goede wrote:
>>>
>>>> Together with some musb sunxi glue changes this allows run-time dr_mode
>>>> switching support via the "mode" musb sysfs attribute.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  drivers/phy/phy-sun4i-usb.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>>>> index fb2d4f3..d369081 100644
>>>> --- a/drivers/phy/phy-sun4i-usb.c
>>>> +++ b/drivers/phy/phy-sun4i-usb.c
>>>> @@ -427,6 +427,29 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
>>>>      return 0;
>>>>  }
>>>>
>>>> +static int sun4i_usb_phy_set_mode(struct phy *_phy, enum phy_mode mode)
>>>> +{
>>>> +    struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
>>>> +    struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
>>>> +
>>>> +    if (phy->index != 0)
>>>> +        return -EINVAL;
>>>> +
>>>> +    switch (mode) {
>>>> +    case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
>>>> +    case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
>>>> +    case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;
>>>> +    default:
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    dev_info(&_phy->dev, "Changing dr_mode to %d\n", (int)data->dr_mode);
>>>> +    data->force_session_end = true;
>>>> +    queue_delayed_work(system_wq, &data->detect, 0);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>  void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
>>>>  {
>>>>      struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
>>> [...]
>>>
>>> $ scripts/checkpatch.pl ~/patches/phy-sun4i-usb-Add-support-for-phy_set_mode.patch
>>> ERROR: trailing statements should be on next line
>>> #29: FILE: drivers/phy/phy-sun4i-usb.c:439:
>>> +    case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
>>>
>>> ERROR: trailing statements should be on next line
>>> #30: FILE: drivers/phy/phy-sun4i-usb.c:440:
>>> +    case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
>>>
>>> ERROR: trailing statements should be on next line
>>> #31: FILE: drivers/phy/phy-sun4i-usb.c:441:
>>> +    case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;
>>
>> This is normal codeing style for a switch-case assigning a single value per case,
>> but checkpatch does not know this.
>
> I don't see that in CodingStyle

It is an exception to the rule as such it is not listed, but this
really is quite a normal thing to do in C code.

> and it's quite ugly.

So this is ugly:

     switch (mode) {
     case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
     case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
     case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;
     default:
         return -EINVAL;
     }

Where as this is not:

     switch (mode) {
     case PHY_MODE_USB_HOST:
         data->dr_mode = USB_DR_MODE_HOST;
         break;
     case PHY_MODE_USB_DEVICE:
         data->dr_mode = USB_DR_MODE_PERIPHERAL;
         break;
     case PHY_MODE_USB_OTG:
         data->dr_mode = USB_DR_MODE_OTG;
         break;
     default:
         return -EINVAL;
     }

???

IMHO the original version is much easier to read / makes it much
clearer what the code is doing.

But if you insist I can do a v3 changing the coding style to
the (IMHO) uglier version.

Also note that the real ugliness is that we've 3 different enums
for host / device / dual-role. For some reason the musb code has
2 all of its own and then there is "enum phy_mode".

Anyways let me know if you want a v3 with check-patch warnings
fixed.

Regards,

Hans
