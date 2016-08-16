From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 16 Aug 2016 22:01:15 +0200
Subject: [PATCH v2 4/7] phy-sun4i-usb: Add support for phy_set_mode
In-Reply-To: <6058a676-1e2c-0301-6edd-eee64b515b51@cogentembedded.com>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
 <1471288892-21702-5-git-send-email-hdegoede@redhat.com>
 <6058a676-1e2c-0301-6edd-eee64b515b51@cogentembedded.com>
Message-ID: <93bda5ac-4548-9e92-742c-baba7ed52849@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/16/2016 03:48 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 08/15/2016 10:21 PM, Hans de Goede wrote:
>
>> Together with some musb sunxi glue changes this allows run-time dr_mode
>> switching support via the "mode" musb sysfs attribute.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/phy/phy-sun4i-usb.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> index fb2d4f3..d369081 100644
>> --- a/drivers/phy/phy-sun4i-usb.c
>> +++ b/drivers/phy/phy-sun4i-usb.c
>> @@ -427,6 +427,29 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
>>      return 0;
>>  }
>>
>> +static int sun4i_usb_phy_set_mode(struct phy *_phy, enum phy_mode mode)
>> +{
>> +    struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
>> +    struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
>> +
>> +    if (phy->index != 0)
>> +        return -EINVAL;
>> +
>> +    switch (mode) {
>> +    case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
>> +    case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
>> +    case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    dev_info(&_phy->dev, "Changing dr_mode to %d\n", (int)data->dr_mode);
>> +    data->force_session_end = true;
>> +    queue_delayed_work(system_wq, &data->detect, 0);
>> +
>> +    return 0;
>> +}
>> +
>>  void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
>>  {
>>      struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> [...]
>
> $ scripts/checkpatch.pl ~/patches/phy-sun4i-usb-Add-support-for-phy_set_mode.patch
> ERROR: trailing statements should be on next line
> #29: FILE: drivers/phy/phy-sun4i-usb.c:439:
> +    case PHY_MODE_USB_HOST:   data->dr_mode = USB_DR_MODE_HOST; break;
>
> ERROR: trailing statements should be on next line
> #30: FILE: drivers/phy/phy-sun4i-usb.c:440:
> +    case PHY_MODE_USB_DEVICE: data->dr_mode = USB_DR_MODE_PERIPHERAL; break;
>
> ERROR: trailing statements should be on next line
> #31: FILE: drivers/phy/phy-sun4i-usb.c:441:
> +    case PHY_MODE_USB_OTG:    data->dr_mode = USB_DR_MODE_OTG; break;

This is normal codeing style for a switch-case assigning a single value per case,
but checkpatch does not know this.

Regaards,

Hans
