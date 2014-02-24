From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 24 Feb 2014 21:14:37 +0000
Subject: [PATCH] staging/iio/adc/MXS/LRADC: fix touchscreen statemachine
In-Reply-To: <20140224164817.GE4436@piout.net>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <201402241416.24270.jbe@pengutronix.de> <20140224133316.GI26722@mwanda>
 <201402241539.53707.jbe@pengutronix.de> <20140224164817.GE4436@piout.net>
Message-ID: <530BB63D.4050200@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/14 16:48, Alexandre Belloni wrote:
> On 24/02/2014 at 15:39:53 +0100, Juergen Beisert wrote :
>> Releasing the touchscreen lets the internal statemachine left in a wrong state.
>> Due to this the release coordinate will be reported again by accident when the next
>> touchscreen event happens. This change sets up the correct state when waiting
>> for the next touchscreen event.
>>
>> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>>
>
> Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Applied to the fixes-togreg branch of iio.git  Thanks

Jonathan
>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
>> index 7fc66a6..514844e 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -757,6 +757,7 @@ static void mxs_lradc_finish_touch_event(struct mxs_lradc *lradc, bool valid)
>>   	}
>>
>>   	/* if it is released, wait for the next touch via IRQ */
>> +	lradc->cur_plate = LRADC_TOUCH;
>>   	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
>>   	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
>>   }
>>
>> --
>> Pengutronix e.K.                              | Juergen Beisert             |
>> Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
>
