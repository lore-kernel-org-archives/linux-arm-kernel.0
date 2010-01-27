From: buserror@gmail.com (M P)
Date: Wed, 27 Jan 2010 15:08:36 +0000
Subject: [PATCH 2/3] ARM: S3C: Configuration override for UART names
In-Reply-To: <20100127145959.GK10014@trinity.fluff.org>
References: <1264601924-18480-1-git-send-email-buserror@gmail.com>
	<1264601924-18480-2-git-send-email-buserror@gmail.com>
	<20100127145959.GK10014@trinity.fluff.org>
Message-ID: <dc447791001270708u753d5183oe08831bb5fd4cdf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 2:59 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Jan 27, 2010 at 02:18:43PM +0000, Michel Pollet wrote:
>> S3C UART devices ?are named s3c2410_serialX and it is
>> inconsistent with the kernel at boot time (console=ttySACx)
>> This patch allows the config file to override this and
>> use the standard name instead.
>
> Is this fixing an actual problem? if so what problem?


Boot with console=ttySAC0,xxx and you never find the /dev/ttySAC0 in
/dev afterward. OpenWRT get fooled, Angstrom/OE gets fooled and so
forth. In most case you spend some entertaining time trying to figure
out why you can't get a console running even tho it appears to have
booted properly.

+ Is there something sufficiently different about the s3c2410_serial
that it needs a reminder in the filename ? Do you have another case of
an UART named "ppc_serial" or "omap_serial" ? (regardless of the fact
that in many case, it's not even running on an s3c2410 proper)
+ Why have a different name than the one used by the console= parameter ?

Michel

>> Signed-off-by: Michel Pollet <buserror@gmail.com>
>> ---
>> ?drivers/serial/samsung.c | ? ?9 ++++++++-
>> ?1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
>> index 52e3df1..e3dd135 100644
>> --- a/drivers/serial/samsung.c
>> +++ b/drivers/serial/samsung.c
>> @@ -55,7 +55,14 @@
>>
>> ?/* UART name and device definitions */
>>
>> +#ifdef CONFIG_S3C_STD_UART_NAMES
>> +/* All other SoC use this naming sheme,
>> + ? including the kernel earlier at boot time */
>> ?#define S3C24XX_SERIAL_NAME ?"ttySAC"
>> +#else
>> +/* Legacy option */
>> +#define S3C24XX_SERIAL_NAME ?"s3c2410_serial"
>> +#endif
>> ?#define S3C24XX_SERIAL_MAJOR 204
>> ?#define S3C24XX_SERIAL_MINOR 64
>>
>> @@ -878,7 +885,7 @@ static struct uart_ops s3c24xx_serial_ops = {
>>
>> ?static struct uart_driver s3c24xx_uart_drv = {
>> ? ? ? .owner ? ? ? ? ?= THIS_MODULE,
>> - ? ? .dev_name ? ? ? = "s3c2410_serial",
>> + ? ? .dev_name ? ? ? = S3C24XX_SERIAL_NAME,
>> ? ? ? .nr ? ? ? ? ? ? = CONFIG_SERIAL_SAMSUNG_UARTS,
>> ? ? ? .cons ? ? ? ? ? = S3C24XX_SERIAL_CONSOLE,
>> ? ? ? .driver_name ? ?= S3C24XX_SERIAL_NAME,
>> --
>> 1.6.6
>>
>
> --
> --
> Ben
>
> Q: ? ? ?What's a light-year?
> A: ? ? ?One-third less calories than a regular year.
>
>
