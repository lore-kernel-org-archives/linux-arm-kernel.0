From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 19 Apr 2018 14:42:56 +0200
Subject: [PATCH 2/2] memory: aemif: add support for board files
In-Reply-To: <15d56b6d-6546-0655-563e-4492982c8d78@ti.com>
References: <20180418153552.14632-1-brgl@bgdev.pl>
 <20180418153552.14632-3-brgl@bgdev.pl>
 <15d56b6d-6546-0655-563e-4492982c8d78@ti.com>
Message-ID: <CAMpxmJUC7wC7BSPekF_WjeSc+YV7AeRvU2ZfC8ZcqYvX5BKV5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-19 14:09 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Wednesday 18 April 2018 09:05 PM, Bartosz Golaszewski wrote:
>> @@ -373,15 +372,23 @@ static int aemif_probe(struct platform_device *pdev)
>>               goto error;
>>       }
>>
>> -     /*
>> -      * For every controller device node, there is a cs device node that
>> -      * describe the bus configuration parameters. This functions iterate
>> -      * over these nodes and update the cs data array.
>> -      */
>> -     for_each_available_child_of_node(np, child_np) {
>> -             ret = of_aemif_parse_abus_config(pdev, child_np);
>> -             if (ret < 0)
>> -                     goto error;
>> +     if (np) {
>> +             /*
>> +              * For every controller device node, there is a cs device node
>> +              * that describe the bus configuration parameters. This
>> +              * functions iterate over these nodes and update the cs data
>> +              * array.
>> +              */
>> +             for_each_available_child_of_node(np, child_np) {
>> +                     ret = of_aemif_parse_abus_config(pdev, child_np);
>> +                     if (ret < 0)
>> +                             goto error;
>> +             }
>> +     } else if (pdata && pdata->num_abus_data > 0) {
>> +             for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
>> +                     aemif->cs_data[i].cs = pdata->abus_data->cs;
>
> Since abus_data is an array, shouldn't it be pdata->abus_data[i].cs ?
>
> Thanks,
> Sekhar

Yes, it should. It only worked because we're using a single config
entry. Thanks, I'll fix it.

Bart
