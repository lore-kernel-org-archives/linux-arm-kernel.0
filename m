From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Mon, 9 Jul 2012 09:16:34 +0800
Subject: [PATCH] Watchdog: OMAP: Fix the runtime pm code to avoid module
 getting stuck intransition state.
In-Reply-To: <20120708092612.GA735@spo001.leaseweb.com>
References: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com>
 <4FF93B93.60701@windriver.com> <20120708092612.GA735@spo001.leaseweb.com>
Message-ID: <4FFA30F2.7010909@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?08? 17:26, Wim Van Sebroeck ??:
> Hi All,
>
>> Hello, Lokesh,
>>
>> One question: Does "echo 1>  /dev/watchdog" work well?
>>
>> Regards,
>> Zumeng
> Please note hat "echo 1>  /dev/watchdog" for drivers that have the WDIOF_MAGICCLOSE
> flag set, reboots the system. This is because it opens the watchdog device ; then
> writes the characters "1" to it and then closes the watchdog. So the watchdog keeps
> running (because it didn't see the magic char "V" written to it).
Yes, this is _absolutely_ right.
>
> In this case (omap_wdt) it opens the watchdog device (and starts the watchdog) then
> it writes a "1" to the watchdog (so basically the watchdog is being pinged) and then
> closes the watchdog device (which stops the watchdog if NOWAYOUT was not set).
Wim,

Agreed for all above, sorry for jumping in:

I just have a little question about this patch:


we have enable pm_runtime_enable(wdev->dev) in probe,
and do ret = misc_register(&(wdev->omap_wdt_miscdev));

Then this patch wants to remove pm_runtime_get_sync
in file operation function, is that right?

Regards,
Zumeng

>
> Kind regards,
> Wim.
>
