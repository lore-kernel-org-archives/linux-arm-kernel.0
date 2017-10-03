From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 3 Oct 2017 13:14:15 +0200
Subject: [PATCH 3/4] nvmem: add a driver for the Amlogic
 Meson6/Meson8/Meson8b SoCs
In-Reply-To: <cd1e7f9c-5aff-8f4c-82b0-c58c2de4c253@free.fr>
References: <20171001125700.1520-1-martin.blumenstingl@googlemail.com>
 <20171001125700.1520-4-martin.blumenstingl@googlemail.com>
 <cd1e7f9c-5aff-8f4c-82b0-c58c2de4c253@free.fr>
Message-ID: <CAFBinCA8abWDpC71g_LEM3hU6QB8QUifG_6V6rv1ZMsi3remZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Tue, Oct 3, 2017 at 6:48 AM, Chris Moore <moore@free.fr> wrote:
> Hi,
>
> Sorry in advance if I am being extremely stupid here.
>
> Le 01/10/2017 ? 14:56, Martin Blumenstingl a ?crit :
>
> [snip]
>
>> +static int meson_mx_efuse_read(void *context, unsigned int offset,
>> +                              void *buf, size_t bytes)
>> +{
>> +       struct meson_mx_efuse *efuse = context;
>> +       u32 tmp;
>> +       int err, i, addr;
>> +
>> +       err = meson_mx_efuse_hw_enable(efuse);
>> +       if (err)
>> +               return err;
>> +
>> +       meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
>> +                                MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE,
>> +                                MESON_MX_EFUSE_CNTL1_AUTO_RD_ENABLE);
>> +
>> +       for (i = offset; i < offset + bytes; i += efuse->config.word_size)
>> {
>> +               addr = i / efuse->config.word_size;
>> +
>> +               err = meson_mx_efuse_read_addr(efuse, addr, &tmp);
>> +               if (err)
>> +                       break;
>> +
>> +               memcpy(buf + i, &tmp, efuse->config.word_size);
>> +       }
>
>
> This will not give the expected result if offset is not a multiple of
> efuse->config.word_size.
I had a look at mtk-efuse.c and bcm-ocotp.c and both are doing similar
calculations
thus I assumed that the nvmem core takes care of handling this

> This will cause buffer overflow if bytes is not a multiple of
> efuse->config.word_size.
that would be very nasty indeed

> Shouldn't there at least be some sort of test on offset and bytes?
in the driver or in core? if possible these checks should be part of
the core nvmem code to prevent code duplication across various drivers
(and to prevent bugs if a specific driver forgets these checks)

> Also this doesn't look endian-safe, but maybe it is.
dumping the whole efuse via sysfs showed the same results as (the
vendor command in Amlogic's) u-boot.

> Old-timer remarks:
> - I try to avoid divisions where possible but I suppose they are very
> low-cost on recent hardware.
> - I don't like arithmetic on void pointers but I know it is supported by gcc
> (and possibly by recent C standards too).
>
> Sorry again for the noise if I am being stupid.
your questions are reasonable
this is my first nvmem driver, so there may be mistakes in the code -
maybe Srinivas could also comment on your feedback

also thank you for taking the time to review this!


Regards,
Martin
