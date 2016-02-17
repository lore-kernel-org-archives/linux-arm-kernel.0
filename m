From: jic23@kernel.org (Jonathan Cameron)
Date: Wed, 17 Feb 2016 20:51:14 +0000
Subject: [PATCH] iio: pressure: ms5611: select IIO_BUFFER
In-Reply-To: <CAEnQRZBk0R-A5VEEd_D+kLKnyhc3nhrm0tv2JOkv0iqywGFtuw@mail.gmail.com>
References: <1455634525-2023774-1-git-send-email-arnd@arndb.de>
 <CAEnQRZBk0R-A5VEEd_D+kLKnyhc3nhrm0tv2JOkv0iqywGFtuw@mail.gmail.com>
Message-ID: <56C4DD42.9090400@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 18:03, Daniel Baluta wrote:
> On Tue, Feb 16, 2016 at 4:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The ms5611 driver started using the IIO_TRIGGERED_BUFFER infrastructure
>> which in turn depend on IIO_BUFFER, and it produces a build error now
>> if that is not enabled:
>>
>> warning: (... && MS5611 && ...) selects IIO_TRIGGERED_BUFFER which has unmet direct dependencies (IIO && IIO_BUFFER)
>> buffer/industrialio-triggered-buffer.c: In function 'iio_triggered_buffer_setup':
>> buffer/industrialio-triggered-buffer.c:58:2: error: implicit declaration of function 'iio_device_attach_buffer' [-Werror=implicit-function-declaration]
>> pressure/ms5611_core.c: In function 'ms5611_trigger_handler':
>> pressure/ms5611_core.c:193:2: error: implicit declaration of function 'iio_push_to_buffers_with_timestamp' [-Werror=implicit-function-declaration]
>>
>> This adds the second select.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 713bbb4efb9d ("iio: pressure: ms5611: Add triggered buffer support")
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied.

Thanks, I've gotten a bit too reliant on the autobuilders it seems.
Need to keep a closer eye on this stuff to stop wasting Arnd's time!

Jonathan
> 
>> ---
>>  drivers/iio/pressure/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
>> index f15f66d6f527..31c0e1fd2202 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -69,6 +69,7 @@ config MPL3115
>>
>>  config MS5611
>>         tristate "Measurement Specialties MS5611 pressure sensor driver"
>> +       select IIO_BUFFER
>>         select IIO_TRIGGERED_BUFFER
>>         help
>>           Say Y here to build support for the Measurement Specialties
>> --
>> 2.7.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
