From: robherring2@gmail.com (Rob Herring)
Date: Wed, 1 Oct 2014 08:55:39 -0500
Subject: [PATCH 5/6] tty/serial: Add Spreadtrum's serial earlycon
In-Reply-To: <3038755.G9Y3LOUCHH@wuerfel>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-6-git-send-email-zhang.lyra@gmail.com>
 <3038755.G9Y3LOUCHH@wuerfel>
Message-ID: <CAL_JsqK78usBOE0UxSjyzN3VMrkP43uOuYz=yZM_wsaS2YDarA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 8:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 29 September 2014 20:04:52 zhang.lyra at gmail.com wrote:
>> From: "chunyan.zhang" <chunyan.zhang@spreadtrum.com>
>>
>> Adds earlycon support for the Spreadtrum's serial.
>>
>> Signed-off-by: chunyan.zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  drivers/tty/serial/Kconfig             |   12 ++++++
>>  drivers/tty/serial/Makefile            |    1 +
>>  drivers/tty/serial/serial_sprd_early.c |   64 ++++++++++++++++++++++++++++++++
>>  3 files changed, 77 insertions(+)
>>  create mode 100644 drivers/tty/serial/serial_sprd_early.c
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 26cec64..ede16e6 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -85,6 +85,18 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
>>         with "earlycon=smh" on the kernel command line. The console is
>>         enabled when early_param is processed.
>>
>> +config SERIAL_EARLYCON_SPRD
>> +     bool "Early console using SPRD serial"
>> +     depends on ARM64
>> +     select SERIAL_CORE
>> +     select SERIAL_CORE_CONSOLE
>> +     select SERIAL_EARLYCON
>> +     help
>
> I assume you will later want to have a proper device driver for
> this hardware, so it would be better to make the Kconfig symbol
> and the file name what you are going to use in the long run, but
> for now only have the earlycon support included.
>
>
>> +static int __init serial_sprd_early_console_setup(
>> +                             struct earlycon_device *device,
>> +                             const char *opt)
>> +{
>> +     if (!device->port.membase)
>> +             return -ENODEV;
>> +
>> +     device->con->write = serial_sprd_early_write;
>> +     return 0;
>> +}
>> +EARLYCON_DECLARE(serial_sprd, serial_sprd_early_console_setup);
>> +OF_EARLYCON_DECLARE(serial_sprd, "sprd,serial",
>> +                 serial_sprd_early_console_setup);
>>
>
> I think you should drop the EARLYCON_DECLARE() line, using
> OF_EARLYCON_DECLARE should be enough.

No, I've been telling people to put both in. The reason is you may
have a bootloader or boot files (e.g PXELINUX) that only allows
changing changing the command line or you want to override/extend the
command line in the kernel.

I'm thinking the declaration should be combined into one to do both
since I'm getting tired of making this comment.

Rob
