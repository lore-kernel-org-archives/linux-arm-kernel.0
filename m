From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Thu, 01 Oct 2009 10:36:41 +0200
Subject: [at91sam9g45] touch screen not detected by Angstrom Linux
In-Reply-To: <4AC329DB.4000004@atmel.com>
References: <4AC31F7F.6090001@visionsystems.de> <4AC329DB.4000004@atmel.com>
Message-ID: <4AC46A19.7050500@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I could successfully apply your touch screen drivers to 2.6.32-rc2:
>>
>> 2.6.30-at91-exp-0045-input-atmel_tsadcc-touchscreen-use-platform-paramet.patch
>> 2.6.30-at91-exp-0046-at91-input-platform-parameters-for-atmel_tsadcc-in.patch
>> 2.6.30-at91-exp-0047-at91-input-touchscreen-support-for-at91sam9g45ekes.patch
>>
>> Here dmesg output for 2.6.32-rc2:
>>
>> atmel_tsadcc atmel_tsadcc: Master clock is set at: 133333333 Hz
>> atmel_tsadcc atmel_tsadcc: Prescaler is set at: 221
>> input: atmel touch screen controller as /devices/platform/atmel_tsadcc/input/input1
>>
>> Here dmesg output for 2.6.27 where touch screen is working under Angstrom Linux:
>>
>> atmel_tsadcc atmel_tsadcc: Master clock is set at: 133333333 Hz
>> atmel_tsadcc atmel_tsadcc: Prescaler is set at: 221
>> input: atmel touch screen controller as /class/input/input1
>>
>> The device is working if I read /dev/input/event1, but I'm not able to get it working under Angstrom Linux. Any ideas?
> 
> Yes: in the driver we do not report the pressure measurement (not 
> available on at91sam9rl). There is a bug in tslib that prevents 
> a pressure-less touchscreen to work correctly.
> 
> 1/ solution one: apply the patch I posted on tslib ml:
> https://lists.berlios.de/pipermail/tslib-general/2009-September/000225.html

Your patch was committed about 10 hours ago http://svn.berlios.de/viewcvs/tslib?view=rev&revision=78
 
> 2/ re-introduce the fake pressure report in your source (atmel_tsadcc driver)
> 
> 8<-------------------------------------------
> diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
> index 3c24783..27ac912 100644
> --- a/drivers/input/touchscreen/atmel_tsadcc.c
> +++ b/drivers/input/touchscreen/atmel_tsadcc.c
> @@ -134,6 +134,7 @@ static irqreturn_t atmel_tsadcc_interrupt(int irq, void *dev)
>  
>  		input_report_key(input_dev, BTN_TOUCH, 0);
>  		ts_dev->bufferedmeasure = 0;
> +		input_report_abs(input_dev, ABS_PRESSURE, 0);
>  		input_sync(input_dev);
>  
>  	} else if (status & ATMEL_TSADCC_PENCNT) {
> @@ -158,6 +159,7 @@ static irqreturn_t atmel_tsadcc_interrupt(int irq, void *dev)
>  			input_report_abs(input_dev, ABS_X, ts_dev->prev_absx);
>  			input_report_abs(input_dev, ABS_Y, ts_dev->prev_absy);
>  			input_report_key(input_dev, BTN_TOUCH, 1);
> +			input_report_abs(input_dev, ABS_PRESSURE, 7500);
>  			input_sync(input_dev);
>  		} else
>  			ts_dev->bufferedmeasure = 1;
> @@ -256,6 +258,7 @@ static int __devinit atmel_tsadcc_probe(struct platform_device *pdev)
>  	__set_bit(EV_ABS, input_dev->evbit);
>  	input_set_abs_params(input_dev, ABS_X, 0, 0x3FF, 0, 0);
>  	input_set_abs_params(input_dev, ABS_Y, 0, 0x3FF, 0, 0);
> +	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 15000, 0, 0);
>  
>  	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
>  
> 
> 8<-------------------------------------------

I have used the second solution and it is working like a charm. Thank you for support.

Regards,
Yegor
