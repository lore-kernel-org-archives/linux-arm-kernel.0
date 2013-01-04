From: rogerq@ti.com (Roger Quadros)
Date: Fri, 4 Jan 2013 16:06:53 +0200
Subject: [PATCH v5 13/22] mfd: omap-usb-host: override number of ports
 from platform data
In-Reply-To: <50E57F10.6030402@mvista.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com>
 <1357138842-28964-14-git-send-email-rogerq@ti.com>
 <50E57F10.6030402@mvista.com>
Message-ID: <50E6E1FD.40604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 02:52 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 02-01-2013 19:00, Roger Quadros wrote:
> 
>> Both OMAP4 and 5 exhibit the same revision ID in the REVISION register
>> but they have different number of ports i.e. 2 and 3 respectively.
>> So we can't rely on REVISION register for number of ports on OMAP5
>> and depend on platform data (or device tree) instead.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> [...]
> 
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 5edb828..710460d 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -497,19 +497,27 @@ static int usbhs_omap_probe(struct
>> platform_device *pdev)
>>        */
>>       pm_runtime_put_sync(dev);
>>
>> -    switch (omap->usbhs_rev) {
>> -    case OMAP_USBHS_REV1:
>> -        omap->nports = 3;
>> -        break;
>> -    case OMAP_USBHS_REV2:
>> -        omap->nports = 2;
>> -        break;
>> -    default:
>> -        omap->nports = OMAP3_HS_USB_PORTS;
>> -        dev_dbg(dev,
>> -          "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
>> -           omap->usbhs_rev, omap->nports);
>> -        break;
>> +    /*
>> +     * If platform data contains nports then use that
>> +     * else make out number of ports from USBHS revision
>> +     */
>> +    if (pdata->nports) {
>> +        omap->nports = pdata->nports;
>> +    } else {
>> +        switch (omap->usbhs_rev) {
>> +        case OMAP_USBHS_REV1:
>> +            omap->nports = 3;
>> +            break;
>> +        case OMAP_USBHS_REV2:
>> +            omap->nports = 2;
>> +            break;
>> +        default:
>> +            omap->nports = OMAP3_HS_USB_PORTS;
>> +            dev_dbg(dev,
>> +            "USB HOST Rev:0x%d not recognized, assuming %d ports\n",
> 
>    Please indent the string to the right somewhat, as it was before.
> 

OK. I will fix it in the pull request e-mail that i'll send in a while
as a reply to the first message in this patchset.

--
cheers,
-roger
