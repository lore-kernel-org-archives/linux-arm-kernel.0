From: padma.kvr@gmail.com (Padma Venkat)
Date: Thu, 8 Aug 2013 13:13:02 +0530
Subject: [PATCH V3 2/3] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <2116389.OxrlCQ9LXd@amdc1227>
References: <1375865122-5258-1-git-send-email-padma.v@samsung.com>
 <1375865122-5258-3-git-send-email-padma.v@samsung.com>
 <2116389.OxrlCQ9LXd@amdc1227>
Message-ID: <CAAgF-BdpsgQk8myq7OOk5zJ8Zxy+J6LUPb3-d40+iE2aNwdwDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Aug 7, 2013 at 4:43 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Ahh, one more thing inline.
>

[snip]

>>
>> +static struct samsung_i2s_dai_data i2sv3_dai_type = {
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_NO_MUXPSR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data i2sv4_dai_type = {
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_NO_MUXPSR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data i2sv5_c100_dai_type = {
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_NO_MUXPSR | QUIRK_SEC_DAI |
>> +                     QUIRK_NEED_RSTCLR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data i2sv5_dai_type = {
>> +     .dai_type = TYPE_PRI,
>> +     .quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR,
>> +};
>> +
>> +static struct samsung_i2s_dai_data samsung_dai_type_sec = {
>> +     .dai_type = TYPE_SEC,
>> +};
>> +
>>  static struct platform_device_id samsung_i2s_driver_ids[] = {
>>       {
>> -             .name           = "samsung-i2s",
>> -             .driver_data    = TYPE_PRI,
>> +             .name           = "samsung,s3c6410-i2s",
>> +             .driver_data    = (kernel_ulong_t)&i2sv3_dai_type,
>> +     }, {
>> +             .name           = "samsung,s3c6410-i2s-multi",
>> +             .driver_data    = (kernel_ulong_t)&i2sv4_dai_type,
>> +     }, {
>> +             .name           = "samsung,s5pc100-i2s",
>> +             .driver_data    = (kernel_ulong_t)&i2sv5_c100_dai_type,
>>       }, {
>> -             .name           = "samsung-i2s-sec",
>> -             .driver_data    = TYPE_SEC,
>> +             .name           = "samsung,s5pv210-i2s",
>> +             .driver_data    = (kernel_ulong_t)&i2sv5_dai_type,
>> +     }, {
>> +             .name           = "samsung-i2s-sec",
>> +             .driver_data    = (kernel_ulong_t)&samsung_dai_type_sec,
>
> I don't think you need to change the legacy platform IDs at all.

If legacy platforms not required to change then I need to introduce a
new samsung_i2s_dai_data structure which holds only dai_type for
non-dt platforms. If I change legacy platforms it breaks the older
platforms now. Is it okay adding a samsung_i2s_dai_data structure for
non-dt platforms which will be removed later?

>
> IMHO it would be better to keep the old way of quirk retrieval from
> platform_data (which I think this patch does anyway, because the probe path
> without DT is unchanged), as it will be dropped in some point in time
> anyway.
>
> This would also eliminate the need for patch 1.
>
> Best regards,
> Tomasz
>

Thanks
Padma
