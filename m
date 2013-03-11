From: ian@slimlogic.co.uk (Ian Lartey)
Date: Mon, 11 Mar 2013 15:16:32 +0000
Subject: [PATCH v8 09/12] leds: Add support for Palmas LEDs
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E45A1C@DQHE02.ent.ti.com>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-9-git-send-email-ian@slimlogic.co.uk>
 <A874F61F95741C4A9BA573A70FE3998F82E45A1C@DQHE02.ent.ti.com>
Message-ID: <513DF550.2040703@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/13 01:13, Kim, Milo wrote:
>> The Palmas familly of chips has LED support. This is not always muxed
>> to output pins so depending on the setting of the mux this driver
>> will create the appropriate LED class devices.
>
> It looks good and I've added few comments.

Thanks for your comments Kim.

>
>> diff --git a/drivers/leds/leds-palmas.c b/drivers/leds/leds-palmas.c
>
>> +static int palmas_leds_blink_set(struct led_classdev *led_cdev,
>> +				   unsigned long *delay_on,
>> +				   unsigned long *delay_off)
>> +{
>> +	struct palmas_led *led = to_palmas_led(led_cdev);
>> +	unsigned long flags;
>> +	int ret = 0;
>> +	int period;
>> +
>> +	/* Pick some defaults if we've not been given times */
>> +	if (*delay_on == 0 && *delay_off == 0) {
>> +		*delay_on = 250;
>> +		*delay_off = 250;
>> +	}
>> +
>> +	spin_lock_irqsave(&led->value_lock, flags);
>> +
>> +	/*
>> +	 * We only have a limited selection of settings, see if we can
>> +	 * support the configuration we're being given
>> +	 */
>> +	switch (*delay_on) {
>> +	case 500:
>> +		led->on_time = LED_ON_500MS;
>> +		break;
>> +	case 250:
>> +		led->on_time = LED_ON_250MS;
>> +		break;
>> +	case 125:
>> +		led->on_time = LED_ON_125MS;
>> +		break;
>> +	case 62:
>> +	case 63:
>> +		/* Actually 62.5ms */
>> +		led->on_time = LED_ON_62_5MS;
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>
> Invalid delay on time,
> Can it return here quickly if updating the period is not mandatory?

The led still needs to be turned off later on in the procedure.
led_blink = 0;
so we can't return early.


>
>> +static int palmas_leds_probe(struct platform_device *pdev)
>> +{
>> +	struct palmas *palmas = dev_get_drvdata(pdev->dev.parent);
>> +	struct palmas_leds_platform_data *pdata = pdev->dev.platform_data;
>> +	struct palmas_leds_data *leds_data;
>> +	struct device_node *node = pdev->dev.of_node;
>> +	int ret, i;
>> +	int offset = 0;
>> +
>> +	if (!palmas->led_muxed && !is_palmas_charger(palmas->product_id))
>> {
>> +		dev_err(&pdev->dev, "there are no LEDs muxed\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Palmas charger requires platform data */
>> +	if (is_palmas_charger(palmas->product_id) && node && !pdata) {
>> +
>> +		if (!pdata)
>> +			return -ENOMEM;
>> +
>> +		ret = palmas_dt_to_pdata(&pdev->dev, node, pdata);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (is_palmas_charger(palmas->product_id) && !pdata)
>> +		return -EINVAL;
>
> In _probe(), is_palmas_charger() is called several times.
> Any reason to get the charger at each time?
> If it's not, just get once and store the value in the variable.
> Then many calls can be replaced with it simply.

is_palmas_charger is simply a macro which checks a value so it
is as simple as it gets.

>
>> +
>> +	leds_data = devm_kzalloc(&pdev->dev, sizeof(*leds_data),
>> GFP_KERNEL);
>> +	if (!leds_data)
>> +		return -ENOMEM;
>> +	platform_set_drvdata(pdev, leds_data);
>> +
>> +	leds_data->palmas = palmas;
>> +
>> +	switch (palmas->led_muxed) {
>> +	case PALMAS_LED1_MUXED | PALMAS_LED2_MUXED:
>> +		leds_data->no_leds = 2;
>> +		break;
>> +	case PALMAS_LED1_MUXED:
>> +	case PALMAS_LED2_MUXED:
>> +		leds_data->no_leds = 1;
>> +		break;
>> +	default:
>> +		leds_data->no_leds = 0;
>> +		break;
>> +	}
>> +
>> +	if (is_palmas_charger(palmas->product_id)) {
>> +		if (pdata->chrg_led_mode)
>> +			leds_data->no_leds += 2;
>> +		else
>> +			leds_data->no_leds++;
>> +	}
>> +
>> +	if (leds_data->no_leds == 0)
>> +		leds_data->palmas_led = NULL;
>> +	else
>> +		leds_data = devm_kzalloc(&pdev->dev,
>> +				leds_data->no_leds * sizeof(*leds_data),
>> +				GFP_KERNEL);
>> +
>> +	/* Initialise LED1 */
>> +	if (palmas->led_muxed & PALMAS_LED1_MUXED) {
>> +		palmas_init_led(leds_data, offset, 1);
>> +		offset++;
>> +	}
>> +
>> +	/* Initialise LED2 */
>> +	if (palmas->led_muxed & PALMAS_LED2_MUXED) {
>> +		palmas_init_led(leds_data, offset, 2);
>> +		offset++;
>> +	}
>> +
>> +	if (is_palmas_charger(palmas->product_id)) {
>> +		palmas_init_led(leds_data, offset, 3);
>> +		offset++;
>> +
>> +		if (pdata->chrg_led_mode) {
>> +			palmas_led_update_bits(leds_data,
>> PALMAS_CHRG_LED_CTRL,
>> +					PALMAS_CHRG_LED_CTRL_CHRG_LED_MODE,
>> +					PALMAS_CHRG_LED_CTRL_CHRG_LED_MODE);
>> +
>> +			palmas_init_led(leds_data, offset, 4);
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < leds_data->no_leds; i++) {
>> +		ret = led_classdev_register(leds_data->dev,
>> +				&leds_data->palmas_led[i].cdev);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev,
>> +				"Failed to register LED no: %d err: %d\n",
>> +				i, ret);
>> +			goto err_led;
>> +		}
>> +	}
>> +
>> +	if (!is_palmas_charger(palmas->product_id))
>> +		return 0;
>> +
>> +	/* Set the LED current registers if set in platform data */
>> +	if (pdata->led1_current)
>> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL1,
>> +				PALMAS_LED_CURRENT_CTRL1_LED_1_CURRENT_MASK,
>> +				pdata->led1_current);
>
> It looks buggy when 'led1_current' is negative value or out-of-range.
> Why don't you define ledN_current as enum type?
> Then it guarantees exact range of configurable value.
>
> For example,
> enum palmas_led_current {
> 	PALMAS_ILED_1mA,
> 	PALMAS_ILED_2mA,
> ...
> };

Your right it does need some bounds checking here, I'll put some in.

>
>> +
>> +	if (pdata->led2_current)
>> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL1,
>> +				PALMAS_LED_CURRENT_CTRL1_LED_2_CURRENT_MASK,
>> +				pdata->led2_current <<
>> +				PALMAS_LED_CURRENT_CTRL1_LED_2_CURRENT_SHIFT);
>> +
>> +	if (pdata->led3_current)
>> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL2,
>> +				PALMAS_LED_CURRENT_CTRL2_LED_3_CURRENT_MASK,
>> +				pdata->led3_current);
>> +
>> +	if (pdata->led3_current)
>> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL2,
>> +				PALMAS_LED_CURRENT_CTRL2_LED_3_CURRENT_MASK,
>> +				pdata->led3_current);
>> +
>> +	if (pdata->led4_current)
>> +		palmas_led_update_bits(leds_data, PALMAS_CHRG_LED_CTRL,
>> +				PALMAS_CHRG_LED_CTRL_CHRG_LED_CURRENT_MASK,
>> +				pdata->led4_current <<
>> +				PALMAS_CHRG_LED_CTRL_CHRG_LED_CURRENT_SHIFT);
>> +
>> +	if (pdata->chrg_led_vbat_low)
>> +		palmas_led_update_bits(leds_data, PALMAS_CHRG_LED_CTRL,
>> +				PALMAS_CHRG_LED_CTRL_CHRG_LOWBAT_BLK_DIS,
>> +				PALMAS_CHRG_LED_CTRL_CHRG_LOWBAT_BLK_DIS);
>> +
>> +	return 0;
>> +
>> +err_led:
>> +	for (i = 0; i < leds_data->no_leds; i++)
>> +		led_classdev_unregister(&leds_data->palmas_led[i].cdev);
>> +	kfree(leds_data->palmas_led);
>> +	kfree(leds_data);
>
> The kfree()s can be ignored because of memory allocation with devm_zalloc().

Yes, thanks for that.
>
>> +static int palmas_leds_remove(struct platform_device *pdev)
>> +{
>> +	struct palmas_leds_data *leds_data = platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	for (i = 0; i < leds_data->no_leds; i++)
>> +		led_classdev_unregister(&leds_data->palmas_led[i].cdev);
>> +	if (i)
>> +		kfree(leds_data->palmas_led);
>> +	kfree(leds_data);
>
> Ditto. The kfree()s are not required with devm_zalloc().

agreed

>
>> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
>> index 5661f2d..7399c71 100644
>> --- a/include/linux/mfd/palmas.h
>> +++ b/include/linux/mfd/palmas.h
>> @@ -232,6 +232,16 @@ struct palmas_clk_platform_data {
>>   	int clk32kgaudio_mode_sleep;
>>   };
>>
>> +struct palmas_leds_platform_data {
>> +	int led1_current;
>> +	int led2_current;
>> +	int led3_current;
>> +	int led4_current;
>
> Ditto, replaceable with enum type ?
>
> Thanks.
>
> Best Regards,
> Milo
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
