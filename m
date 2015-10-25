From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 25 Oct 2015 12:16:32 +0000
Subject: [PATCH] staging: iio: select IRQ_WORK for IIO_DUMMY_EVGEN
In-Reply-To: <CAEnQRZDTP6Xut9hGLe4QpgdZJvumY0fESMc_aYWJ4TW3oHeUJw@mail.gmail.com>
References: <22609671.lgCfBiaFIf@wuerfel>
 <CAEnQRZDTP6Xut9hGLe4QpgdZJvumY0fESMc_aYWJ4TW3oHeUJw@mail.gmail.com>
Message-ID: <562CC820.9060100@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/15 09:16, Daniel Baluta wrote:
> On Sat, Oct 17, 2015 at 1:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The iio dummy code was recently changed to use irq_work_queue, but
>> that code is compiled into the kernel only if IRQ_WORK is set, so
>> we can get a link error here:
>>
>> drivers/built-in.o: In function `iio_evgen_poke':
>> (.text+0x208a04): undefined reference to `irq_work_queue'
>>
>> This changes the Kconfig file to match what other drivers do.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: fd2bb310ca3d ("Staging: iio: Move evgen interrupt generation to irq_work")
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the fixes-togreg branch of iio.git.  I fear this won't get to Linus
until just after the release occurs.  Unfortunate timing.

Jonathan
> 
>> ---
>> Found on ARM randconfig tests
>>
>> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
>> index 6d5b38d69578..9d7f0004d2d7 100644
>> --- a/drivers/staging/iio/Kconfig
>> +++ b/drivers/staging/iio/Kconfig
>> @@ -18,7 +18,8 @@ source "drivers/staging/iio/resolver/Kconfig"
>>  source "drivers/staging/iio/trigger/Kconfig"
>>
>>  config IIO_DUMMY_EVGEN
>> -       tristate
>> +       tristate
>> +       select IRQ_WORK
>>
>>  config IIO_SIMPLE_DUMMY
>>         tristate "An example driver with no hardware requirements"
>>
>> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
