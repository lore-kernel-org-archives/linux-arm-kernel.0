From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 06 May 2014 22:43:36 +0200
Subject: [PATCH] rtc: rtc-at91rm9200: fix infinite wait for ACKUPD irq
In-Reply-To: <aed75d16aa46476eb6f6c5b0d4bef30d@BLUPR05MB037.namprd05.prod.outlook.com>
References: <94c06375c1b44c8eb5233b0ccf2e4b13@BY2PR05MB048.namprd05.prod.outlook.com>
 <1399386481-18643-1-git-send-email-boris.brezillon@free-electrons.com>
 <aed75d16aa46476eb6f6c5b0d4bef30d@BLUPR05MB037.namprd05.prod.outlook.com>
Message-ID: <53694978.3050303@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/05/2014 21:06, Bryan Evenson wrote:
> Boris,
>
>> -----Original Message-----
>> From: Boris BREZILLON [mailto:boris.brezillon at free-electrons.com]
>> Sent: Tuesday, May 06, 2014 10:28 AM
>> To: Bryan Evenson
>> Cc: Andrew Victor; Nicolas Ferre; Jean-Christophe Plagniol-Villard; linux-arm-
>> kernel at lists.infradead.org; Alessandro Zummo; rtc-
>> linux at googlegroups.com; linux-kernel at vger.kernel.org; Boris BREZILLON
>> Subject: [PATCH] rtc: rtc-at91rm9200: fix infinite wait for ACKUPD irq
>>
>> The rtc user must wait at least 1 sec between each time/calandar update
>> (see atmel's datasheet chapter "Updating Time/Calendar").
>>
>> Use the 1Hz interrupt to update the at91_rtc_upd_rdy flag and wait for
>> the at91_rtc_wait_upd_rdy event if the rtc is not ready.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> Reported-by: Bryan Evenson <bevenson@melinkcorp.com>
>> ---
>> Hello Bryan,
>>
>> I reproduced your bug (using your script) and this patch seems to fix the
>> problem.
>>
>> Could you try it and let me know if it works for you ?
> Looks good to me.  I modified the test script as follows:
>
> ----------
> #!/bin/sh
> i=0
> while [ 1 ]; do
>   hwclock -w -u > /dev/null 2>&1
>   echo $$ $i $?
>   : $((i++))
> done
> ----------
>
> This version then attempts to write to the RTC as often as possible (script change was due to a suggestion on the Busybox mailing list).  I ran two instances of the script, which each looped through about 60,000 times over a 30 minute run.  At no point has access to the RTC been permanently locked out on my system.  I'd call this fixed.

Great!

> I'd assume this patch would be backported to the longterm releases?

I'd like to wait for Nicolas' ack before asking for a backport to stable
releases.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
