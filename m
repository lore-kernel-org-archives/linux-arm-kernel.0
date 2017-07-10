From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 10 Jul 2017 14:40:25 -0500
Subject: [PATCH] iio: adc: meson-saradc: add NULL check on
 of_match_device() return value
In-Reply-To: <CAFBinCBgXAFvLqXP5e-j=UeQVd+foUDqKUNzO8hwQ71tKga1Vg@mail.gmail.com>
References: <20170707064630.GA21945@embeddedgus>
 <CAFBinCBgXAFvLqXP5e-j=UeQVd+foUDqKUNzO8hwQ71tKga1Vg@mail.gmail.com>
Message-ID: <20170710144025.Horde.vDNHGoVgk8qoRyi4crvw77O@gator4166.hostgator.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Quoting Martin Blumenstingl <martin.blumenstingl@googlemail.com>:

> On Fri, Jul 7, 2017 at 8:46 AM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>> Check return value from call to of_match_device()
>> in order to prevent a NULL pointer dereference.
>>
>> In case of NULL print error message and return -ENODEV
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> thanks for finding this. a crash here is a rather theoretical problem
> (since all compatible strings have their corresponding match data) -
> but it doesn't hurt either, so:
>

I get it, glad to help. :)

> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
>
>> ---
>>  drivers/iio/adc/meson_saradc.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index 83da50e..07dbcc3 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -915,6 +915,11 @@ static int meson_sar_adc_probe(struct  
>> platform_device *pdev)
>>         init_completion(&priv->done);
>>
>>         match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
>> +       if (!match) {
>> +               dev_err(&pdev->dev, "failed to match device\n");
>> +               return -ENODEV;
>> +       }
>> +
>>         priv->data = match->data;
>>
>>         indio_dev->name = priv->data->name;
>> --
>> 2.5.0
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic

--
Gustavo A. R. Silva
