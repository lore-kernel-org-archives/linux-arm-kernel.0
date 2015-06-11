From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 11 Jun 2015 11:53:28 +0200
Subject: [PATCH v4 1/2] phy-sun4i-usb: Add full support for usb0 phy / OTG
In-Reply-To: <55795800.4070405@ti.com>
References: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
 <1433088626-8858-2-git-send-email-hdegoede@redhat.com>
 <55795800.4070405@ti.com>
Message-ID: <55795A98.8090303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11-06-15 11:42, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Sunday 31 May 2015 09:40 PM, Hans de Goede wrote:
>> The usb0 phy is connected to an OTG controller, and as such needs some special
>> handling:
>>
>> 1) It allows explicit control over the pullups, enable these on phy_init and
>> disable them on phy_exit.
>>
>> 2) It has bits to signal id and vbus detect to the musb-core, add support for
>> for monitoring id and vbus detect gpio-s for use in dual role mode, and set
>> these bits to the correct values for operating in host only mode when no
>> gpios are specified in the devicetree.
>>
>> 3) When in dual role mode the musb sunxi glue needs to know if the a host or
>> device cable is plugged in, so when in dual role mode register an extcon.
>>
>> While updating the devicetree binding documentation also add documentation
>> for the sofar undocumented usage of regulators for vbus for all 3 phys.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Removed the sunxi specific phy functions, instead the id / vbus gpio polling
>>   has been moved to the phy-sun4i-usb driver and their status is exported
>>   through extcon for the sunxi-musb glue
>> Changes in v3:
>> -No changes
>> Changes in v4:
>> -Do not call regulator_disable in an unbalanced manner when an external vbus
>>   is present
>> ---
>>   .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  18 +-
>>   drivers/phy/Kconfig                                |   1 +
>>   drivers/phy/phy-sun4i-usb.c                        | 273 ++++++++++++++++++++-
>>   3 files changed, 281 insertions(+), 11 deletions(-)
>>
> .
> .
> <snip>
> .
> .
>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> index 91c5be4..b45d707 100644
>> --- a/drivers/phy/phy-sun4i-usb.c
>> +++ b/drivers/phy/phy-sun4i-usb.c
>> @@ -1,7 +1,7 @@
>
> .
> .
> <snip>
> .
> .
>>   static struct phy *sun4i_usb_phy_xlate(struct device *dev,
>>                       struct of_phandle_args *args)
>>   {
>> @@ -240,13 +417,20 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>>       struct phy_provider *phy_provider;
>>       bool dedicated_clocks;
>>       struct resource *res;
>> -    int i;
>> +    int i, ret;
>>
>>       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>       if (!data)
>>           return -ENOMEM;
>>
>>       mutex_init(&data->mutex);
>> +    INIT_DELAYED_WORK(&data->detect, sun4i_usb_phy0_id_vbus_det_scan);
>> +    data->extcon_cable_names[0] = extcon_cable_name[EXTCON_USB_HOST];
>> +    data->extcon_cable_names[1] = extcon_cable_name[EXTCON_USB];
>> +    data->extcon_cable_names[2] = NULL;
>> +    data->extcon.name = DRIVER_NAME;
>> +    data->extcon.supported_cable = data->extcon_cable_names;
>> +    data->extcon.dev.parent = dev;
>>
>>       if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy"))
>>           data->num_phys = 2;
>> @@ -269,6 +453,34 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>>       if (IS_ERR(data->base))
>>           return PTR_ERR(data->base);
>>
>> +    data->id_det_gpio = devm_gpiod_get(dev, "usb0_id_det", GPIOD_IN);
>> +    if (IS_ERR(data->id_det_gpio)) {
>> +        if (PTR_ERR(data->id_det_gpio) == -EPROBE_DEFER)
>> +            return -EPROBE_DEFER;
>> +        data->id_det_gpio = NULL;
>> +    }
>> +
>> +    data->vbus_det_gpio = devm_gpiod_get(dev, "usb0_vbus_det", GPIOD_IN);
>> +    if (IS_ERR(data->vbus_det_gpio)) {
>> +        if (PTR_ERR(data->vbus_det_gpio) == -EPROBE_DEFER)
>> +            return -EPROBE_DEFER;
>> +        data->vbus_det_gpio = NULL;
>> +    }
>> +
>> +    /* We either want both gpio pins or neither (when in host mode) */
>> +    if (!data->id_det_gpio != !data->vbus_det_gpio) {
>> +        dev_err(dev, "failed to get id or vbus detect pin\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    if (data->id_det_gpio) {
>> +        ret = devm_extcon_dev_register(dev, &data->extcon);
>> +        if (ret) {
>> +            dev_err(dev, "failed to register extcon: %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>>       for (i = 0; i < data->num_phys; i++) {
>>           struct sun4i_usb_phy *phy = data->phys + i;
>>           char name[16];
>> @@ -318,12 +530,54 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>>           phy_set_drvdata(phy->phy, &data->phys[i]);
>>       }
>>
>> +    data->id_det_irq = gpiod_to_irq(data->id_det_gpio);
>> +    data->vbus_det_irq = gpiod_to_irq(data->vbus_det_gpio);
>> +    if (data->id_det_irq  < 0 || data->vbus_det_irq < 0)
>> +        data->phy0_poll = true;
>
> if polling is enabled, we shouldn't enable irq at all?

Thanks for the review.

One some boards one of the gpio-s is irq capable and the other
is not, in which case the current code indeed enables both
irq handling for the one gpio which is irq capable and enables
polling. This is done this way deliberately as the irq path
has much better latency then polling and the 2 can co-exist.

>> +
>> +    if (data->id_det_irq >= 0) {
>> +        ret = devm_request_irq(dev, data->id_det_irq,
>> +                sun4i_usb_phy0_id_vbus_det_irq,
>> +                IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +                "usb0-id-det", data);
>> +        if (ret) {
>> +            dev_err(dev, "Err requesting id-det-irq: %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    if (data->vbus_det_irq >= 0) {
>> +        ret = devm_request_irq(dev, data->vbus_det_irq,
>> +                sun4i_usb_phy0_id_vbus_det_irq,
>> +                IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +                "usb0-vbus-det", data);
>> +        if (ret) {
>> +            dev_err(dev, "Err requesting vbus-det-irq: %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>>       dev_set_drvdata(dev, data);
>>       phy_provider = devm_of_phy_provider_register(dev, sun4i_usb_phy_xlate);
>>
>>       return PTR_ERR_OR_ZERO(phy_provider);
>>   }
>>
>> +static int sun4i_usb_phy_remove(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
>> +
>> +    if (data->id_det_irq >= 0)
>> +        devm_free_irq(dev, data->id_det_irq, data);
>> +    if (data->vbus_det_irq >= 0)
>> +        devm_free_irq(dev, data->vbus_det_irq, data);
>
> This shouldn't be needed since you already use devm_* in probe.

The use of devm_* in probe helps to keep the error handling in
probe sane, but we must explicitly free the irqs here, otherwise
they may trigger after this:

>> +    cancel_delayed_work_sync(&data->detect);

call causing the workqueue to get run after (parts of) the
phy resources have been freed and then bad things will happen.

>> +
>> +    return 0;
>> +}
>> +
>>   static const struct of_device_id sun4i_usb_phy_of_match[] = {
>>       { .compatible = "allwinner,sun4i-a10-usb-phy" },
>>       { .compatible = "allwinner,sun5i-a13-usb-phy" },
>> @@ -335,9 +589,10 @@ MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
>>
>>   static struct platform_driver sun4i_usb_phy_driver = {
>>       .probe    = sun4i_usb_phy_probe,
>> +    .remove    = sun4i_usb_phy_remove,
>>       .driver = {
>>           .of_match_table    = sun4i_usb_phy_of_match,
>> -        .name  = "sun4i-usb-phy",
>> +        .name  = DRIVER_NAME,
>>       }
>>   };
>>   module_platform_driver(sun4i_usb_phy_driver);
>>

Regards,

Hans
