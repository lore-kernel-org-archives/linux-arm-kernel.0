From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sun, 9 Nov 2014 09:49:41 +0530
Subject: [PATCH v2 2/2] tty: serial: samsung: Clean-up selection of number
 of available UARTs
In-Reply-To: <CAM4voamvxxdfXApgUL6xB_8VDwFoFqz5hXKtu4W6aYCmCbs0kg@mail.gmail.com>
References: <1412181777-6388-1-git-send-email-a.kesavan@samsung.com>
 <1412181777-6388-2-git-send-email-a.kesavan@samsung.com>
 <041301cff29a$5c9a5fa0$15cf1ee0$@kernel.org>
 <CAM4voakzWhfMc1SyTXs1eOxuvEp_U3qfRLxPAzWzeX54jwadvA@mail.gmail.com>
 <CAM4voa=0i6WsYn1z9AdeCSPFqdOS35-LX=b-Rc+Npr9dVFD_-w@mail.gmail.com>
 <CAM4voamvxxdfXApgUL6xB_8VDwFoFqz5hXKtu4W6aYCmCbs0kg@mail.gmail.com>
Message-ID: <CAM4voa=TTFfuKqih2jDk6FV4K56T1Fj5sitnei2JAxdG9BwGwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 3, 2014 at 1:51 PM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hello Kukjin,
>
> On Fri, Oct 31, 2014 at 8:06 AM, Abhilash Kesavan
> <kesavan.abhilash@gmail.com> wrote:
>> Hi Kukjin,
>>
>> On Tue, Oct 28, 2014 at 5:56 PM, Abhilash Kesavan
>> <kesavan.abhilash@gmail.com> wrote:
>>> Hi Kukjin
>>>
>>> On Tue, Oct 28, 2014 at 4:01 PM, Kukjin Kim <kgene@kernel.org> wrote:
>>>> Abhilash Kesavan wrote:
>>>>>
>>>> Hi,
>>>>
>>>> Sorry for late response.
>>>>
>>>>> Remove symbols SERIAL_SAMSUNG_UARTS_4 and SERIAL_SAMSUNG_UARTS which
>>>>> select the number of UART ports available on the SoC. Replace the usage
>>>>> of SERIAL_SAMSUNG_UARTS in the serial driver with the maximum number of
>>>>
>>>> Well, as you know the number of uart ports are different on each Samsung SoCs
>>>> so I don't think just using maximum number of uart ports are possible for new
>>>> exynos7 SoC at this moment.
>>>
>>> Thanks for the review.
>>> The main reason for me sending this patch was so that we may be able
>>> to re-use the serial driver on arm64 based Exynos7 too. The two
>>> symbols mentioned above which depend on PLAT_SAMSUNG prevent this. I
>>> initially sent a patch which changed the dependency to SERIAL_SAMSUNG
>>> for these 2 symbols. However, Tomasz suggested that a clean-up of
>>> these two symbols would be a better option.
>>>
>>> Please see the discussion of the previous version here:
>>> https://lkml.org/lkml/2014/9/29/702
>>>
>>> Can you please let me know if the previous version is acceptable ?
>>
>> Kukjin, can you please indicate the approach you would like me to
>> take. Without this serial support is blocked on Exynos7.
>
> Gentle reminder on this.

Hi Kukjin,

I don't mean to nag, but this another reminder to review this.
Please let me know if you are too busy to have a look at this or
require some more inputs from me.

Regards,
Abhilash
>
> Abhilash
>>
>> Thanks,
>> Abhilash
>>>
>>>>
>>>>> UART ports possible. Removal of these symbols also helps in Exynos7
>>>>> serial enablement.
>>>>>
>>>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>>>> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> ---
>>>>>  drivers/tty/serial/Kconfig   |   16 ----------------
>>>>>  drivers/tty/serial/samsung.c |   11 +++--------
>>>>>  drivers/tty/serial/samsung.h |    5 ++++-
>>>>>  3 files changed, 7 insertions(+), 25 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>>> index 81f6ee7..9fc9092 100644
>>>>> --- a/drivers/tty/serial/Kconfig
>>>>> +++ b/drivers/tty/serial/Kconfig
>>>>> @@ -247,22 +247,6 @@ config SERIAL_SAMSUNG
>>>>>         provide all of these ports, depending on how the serial port
>>>>>         pins are configured.
>>>>>
>>>>> -config SERIAL_SAMSUNG_UARTS_4
>>>>> -     bool
>>>>> -     depends on PLAT_SAMSUNG
>>>>> -     default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
>>>>> -     help
>>>>> -       Internal node for the common case of 4 Samsung compatible UARTs
>>>>> -
>>>>> -config SERIAL_SAMSUNG_UARTS
>>>>> -     int
>>>>> -     depends on PLAT_SAMSUNG
>>>>> -     default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
>>>>> -     default 3
>>>>> -     help
>>>>> -       Select the number of available UART ports for the Samsung S3C
>>>>> -       serial driver
>>>>> -
>>>>>  config SERIAL_SAMSUNG_DEBUG
>>>>>       bool "Samsung SoC serial debug"
>>>>>       depends on SERIAL_SAMSUNG && DEBUG_LL
>>>>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>>>>> index c78f43a..ba04c6d 100644
>>>>> --- a/drivers/tty/serial/samsung.c
>>>>> +++ b/drivers/tty/serial/samsung.c
>>>>> @@ -962,14 +962,14 @@ static struct uart_ops s3c24xx_serial_ops = {
>>>>>  static struct uart_driver s3c24xx_uart_drv = {
>>>>>       .owner          = THIS_MODULE,
>>>>>       .driver_name    = "s3c2410_serial",
>>>>> -     .nr             = CONFIG_SERIAL_SAMSUNG_UARTS,
>>>>> +     .nr             = MAX_SAMSUNG_UARTS,
>>>>>       .cons           = S3C24XX_SERIAL_CONSOLE,
>>>>>       .dev_name       = S3C24XX_SERIAL_NAME,
>>>>>       .major          = S3C24XX_SERIAL_MAJOR,
>>>>>       .minor          = S3C24XX_SERIAL_MINOR,
>>>>>  };
>>>>>
>>>>> -static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
>>>>> +static struct s3c24xx_uart_port s3c24xx_serial_ports[MAX_SAMSUNG_UARTS] = {
>>>>>       [0] = {
>>>>>               .port = {
>>>>>                       .lock           = __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[0].port.lock),
>>>>> @@ -992,8 +992,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
>>>>>                       .line           = 1,
>>>>>               }
>>>>>       },
>>>>> -#if CONFIG_SERIAL_SAMSUNG_UARTS > 2
>>>>> -
>>>>>       [2] = {
>>>>>               .port = {
>>>>>                       .lock           = __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[2].port.lock),
>>>>> @@ -1005,8 +1003,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
>>>>>                       .line           = 2,
>>>>>               }
>>>>>       },
>>>>> -#endif
>>>>> -#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
>>>>>       [3] = {
>>>>>               .port = {
>>>>>                       .lock           = __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[3].port.lock),
>>>>> @@ -1018,7 +1014,6 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
>>>>>                       .line           = 3,
>>>>>               }
>>>>>       }
>>>>> -#endif
>>>>>  };
>>>>>
>>>>>  /* s3c24xx_serial_resetport
>>>>> @@ -1590,7 +1585,7 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
>>>>>
>>>>>       /* is this a valid port */
>>>>>
>>>>> -     if (co->index == -1 || co->index >= CONFIG_SERIAL_SAMSUNG_UARTS)
>>>>> +     if (co->index == -1 || co->index >= MAX_SAMSUNG_UARTS)
>>>>
>>>> If we use max number, second condition is not required...
>>>>
>>>>>               co->index = 0;
>>>>>
>>>>>       port = &s3c24xx_serial_ports[co->index].port;
>>>>> diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
>>>>> index eb071dd..484b49e 100644
>>>>> --- a/drivers/tty/serial/samsung.h
>>>>> +++ b/drivers/tty/serial/samsung.h
>>>>> @@ -1,6 +1,9 @@
>>>>>  #ifndef __SAMSUNG_H
>>>>>  #define __SAMSUNG_H
>>>>>
>>>>> +/* Maximum UART ports available */
>>>>> +#define MAX_SAMSUNG_UARTS       4
>>>>
>>>> If there is a Samsung SoC having 5 UARTS, we need to update?
>>>
>>> Yes, we would need to update the MAX_SAMSUNG_UARTS define for a newer
>>> SoC with 5 uart ports but even without this patch we would have to
>>> modify the SERIAL_SAMSUNG_UARTS symbol to handle 5 ports.
>>>>
>>>> And hmm...maybe we need to keep the useless array sometimes...
>>>
>>> Yes, for the 24xx series with 3 uart ports we would.
>>>
>>> Regards,
>>> Abhilash
>>>>
>>>>> +
>>>>>  /*
>>>>>   * Driver for Samsung SoC onboard UARTs.
>>>>>   *
>>>>> @@ -38,7 +41,7 @@ struct s3c24xx_uart_info {
>>>>>  struct s3c24xx_serial_drv_data {
>>>>>       struct s3c24xx_uart_info        *info;
>>>>>       struct s3c2410_uartcfg          *def_cfg;
>>>>> -     unsigned int                    fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
>>>>> +     unsigned int                    fifosize[MAX_SAMSUNG_UARTS];
>>>>>  };
>>>>>
>>>>>  struct s3c24xx_uart_port {
>>>>> --
>>>>> 1.7.9.5
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
