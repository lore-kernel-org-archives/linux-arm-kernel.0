From: lokeshvutla@ti.com (Vutla, Lokesh)
Date: Mon, 9 Jul 2012 09:19:20 +0530
Subject: [PATCH] Watchdog: OMAP: Fix the runtime pm code to avoid module
 getting stuck intransition state.
In-Reply-To: <4FFA30F2.7010909@windriver.com>
References: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com>
 <4FF93B93.60701@windriver.com> <20120708092612.GA735@spo001.leaseweb.com>
 <4FFA30F2.7010909@windriver.com>
Message-ID: <CAJ1gdcZGCYmbuOgVyKnNARb0F_37j0qz0H-+5qfPzwRV1xwsag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 6:46 AM, Zumeng Chen <zumeng.chen@windriver.com> wrote:
> ? 2012?07?08? 17:26, Wim Van Sebroeck ??:
>
>> Hi All,
>>
>>> Hello, Lokesh,
>>>
>>> One question: Does "echo 1>  /dev/watchdog" work well?
>>>
>>> Regards,
>>> Zumeng
>>
>> Please note hat "echo 1>  /dev/watchdog" for drivers that have the
>> WDIOF_MAGICCLOSE
>> flag set, reboots the system. This is because it opens the watchdog device
>> ; then
>> writes the characters "1" to it and then closes the watchdog. So the
>> watchdog keeps
>> running (because it didn't see the magic char "V" written to it).
>
> Yes, this is _absolutely_ right.
>
>>
>> In this case (omap_wdt) it opens the watchdog device (and starts the
>> watchdog) then
>> it writes a "1" to the watchdog (so basically the watchdog is being
>> pinged) and then
>> closes the watchdog device (which stops the watchdog if NOWAYOUT was not
>> set).
>
> Wim,
>
> Agreed for all above, sorry for jumping in:
>
> I just have a little question about this patch:
>
>
> we have enable pm_runtime_enable(wdev->dev) in probe,
> and do ret = misc_register(&(wdev->omap_wdt_miscdev));
>
> Then this patch wants to remove pm_runtime_get_sync
> in file operation function, is that right?

Yes, this patch removes pm_runtime_get/put_sync when we
know that watchdog is running.

>
> Regards,
> Zumeng
>
>>
>> Kind regards,
>> Wim.
>>
>
