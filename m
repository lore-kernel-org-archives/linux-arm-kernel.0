From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 21 Aug 2016 17:20:14 +0200
Subject: [PATCH v3 5/7] phy-sun4i-usb: Warn when external vbus is detected
In-Reply-To: <27711471789929@web21g.yandex.ru>
References: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
 <1471781799-10457-5-git-send-email-hdegoede@redhat.com>
 <27711471789929@web21g.yandex.ru>
Message-ID: <fabf206f-7f7a-4f00-dbdf-c3ad24211fef@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-08-16 16:32, Icenowy Zheng wrote:
>
>
> 21.08.2016, 20:22, "Hans de Goede" <hdegoede@redhat.com>:
>> Warn when external vbus is detected when we're trying to enable our
>> own vbus.
>
> Will it lead to a dmesg flood if a not-well-connected USB OTG Charging Hub
> is present?

No, we only try to turn on Vbus once when switching to host-mode.

When using a device which is actually providing power and has an
id pin claiming it wants the port in host mode then this message
will trigger once. I'm actually adding it exactly because of the
USB OTG Charging Hub case. In this case you want to see this
messages once, if you're not seeing it and the hub is sending
power to the micro-usb port then something is wrong.

Note in many cases these hubs will only send power when in
charging mode and in this case the the id-pin is such
that the micro-usb port will be in device mode and will
never try to provide power. In this scenario you will not
get the warning, not will Linux see the hub.

Regards,

Hans






>
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -No changes
>> Changes in v3:
>> -No changes
>> ---
>>  drivers/phy/phy-sun4i-usb.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> index af42f8d..03f030b 100644
>> --- a/drivers/phy/phy-sun4i-usb.c
>> +++ b/drivers/phy/phy-sun4i-usb.c
>> @@ -390,8 +390,10 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
>>
>>          /* For phy0 only turn on Vbus if we don't have an ext. Vbus */
>>          if (phy->index == 0 && sun4i_usb_phy0_have_vbus_det(data) &&
>> - data->vbus_det)
>> + data->vbus_det) {
>> + dev_warn(&_phy->dev, "External vbus detected, not enabling our own vbus\n");
>>                  return 0;
>> + }
>>
>>          ret = regulator_enable(phy->vbus);
>>          if (ret)
>> --
>> 2.7.4
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
