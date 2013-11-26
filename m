From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 26 Nov 2013 14:30:27 +0200
Subject: [PATCH v3 1/6] watchdog: davinci: change driver to use WDT core
In-Reply-To: <52948FA8.7000609@roeck-us.net>
References: <1385388285-10553-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1385388285-10553-2-git-send-email-ivan.khoronzhuk@ti.com>
 <52948184.50604@ti.com> <52948FA8.7000609@roeck-us.net>
Message-ID: <52949463.3060609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 02:10 PM, Guenter Roeck wrote:
> On 11/26/2013 03:09 AM, Grygorii Strashko wrote:
>> On 11/25/2013 04:04 PM, Ivan Khoronzhuk wrote:
>>> To reduce code duplicate and increase code readability use WDT core
>>> code to handle WDT interface.
>>>
>>> Remove io_lock as the WDT core uses mutex to lock each wdt device.
>>> Remove wdt_state as the WDT core tracks state with its own variable.
>>>
>>> The watchdog_init_timeout() can read timeout value from timeout-sec
>>> property if the passed value is out of bounds. The heartbeat is
>>> initialized in next way. If heartbeat is not set thought module
>>> parameter, try to read it's value from WDT node timeout-sec property.
>>> If node has no one, use default value.
>>>
>>> The heartbeat is hold in wdd->timeout by WDT core, so use it in
>>> order to set timeout period.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>   arch/arm/mach-davinci/da8xx-dt.c      |    2 +-
>>>   arch/arm/mach-davinci/devices-da8xx.c |    4 +-
>>>   arch/arm/mach-davinci/devices.c       |    2 +-
>>>   drivers/watchdog/Kconfig              |    2 +
>>>   drivers/watchdog/davinci_wdt.c        |  151
>>> ++++++++-------------------------
>>>   5 files changed, 43 insertions(+), 118 deletions(-)
>>
>> Pls note, that this patch contains both changes in platform and driver
>> code to fix regression reported by Sekhar Nori on v2 of this series
>> and caused by driver name changing.
>>
>> Is it ok?
>>
>> It can be splitted, but then both patches will introduce regression by
>> itself and thing will work only if both of them will be applied together.
>>
> Splitting it would break bisect, even if applied together, so I don't
> think this would be a good idea.

Thanks

Regards,
-grygorii
