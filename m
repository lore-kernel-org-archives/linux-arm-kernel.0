From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 02 May 2014 06:22:36 -0700
Subject: [RFC PATCH 1/5] watchdog: Add API to trigger reboots
In-Reply-To: <20140502100105.GC17370@arm.com>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
 <1398958893-30049-2-git-send-email-linux@roeck-us.net>
 <20140502100105.GC17370@arm.com>
Message-ID: <53639C1C.8050701@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2014 03:01 AM, Will Deacon wrote:
> Hi Guenter,
>
> This looks pretty sensible to me (and the arm/arm64 bits look fine too), but
> I have one question below...
>
> On Thu, May 01, 2014 at 04:41:29PM +0100, Guenter Roeck wrote:
>> Some hardware implements reboot through its watchdog hardware,
>> for example by triggering a watchdog timeout. Platform specific
>> code starts to spread into watchdog drivers, typically by setting
>> pointers to a callback functions which is then called from the
>> platform reset handler.
>>
>> To simplify code and provide a unified API to trigger reboots by
>> watchdog drivers, provide a single API to trigger such reboots
>> through the watchdog subsystem.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/watchdog/watchdog_core.c |   17 +++++++++++++++++
>>   include/linux/watchdog.h         |   11 +++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
>> index cec9b55..4ec6e2f 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -43,6 +43,17 @@
>>   static DEFINE_IDA(watchdog_ida);
>>   static struct class *watchdog_class;
>>
>> +static struct watchdog_device *wdd_reboot_dev;
>> +
>> +void watchdog_do_reboot(enum reboot_mode mode, const char *cmd)
>> +{
>> +	if (wdd_reboot_dev) {
>> +		if (wdd_reboot_dev->ops->reboot)
>> +			wdd_reboot_dev->ops->reboot(wdd_reboot_dev, mode, cmd);
>> +	}
>> +}
>
> What reboot_mode values would you expect a watchdog to support other than
> REBOOT_HARD? Also, is the cmd even useful here?
>

Answer is "I don't know" in both cases. I thought about dropping the parameters,
but then I thought it does not hurt to have them around either. I am open to
suggestions and to dropping the parameters if everyone agrees that they are
useless.

Guenter
