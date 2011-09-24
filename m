From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Sat, 24 Sep 2011 16:11:52 +0530
Subject: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
In-Reply-To: <4E7D99CB.7090004@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
Message-ID: <CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh, Kevin,

[...]
>>> After that, pm_runtime_put_sync() is called, which will trigger the
>>> driver's ->runtime_suspend callback. ?The ->runtime_suspend() callback
>>> checks bank->mod_usage as well, and if zero, doesn't do anything
>>> (notably, it doesn't disable debounce clocks.)
>> I need some clarification in reproducing/testing the fix on OMAP3430SDP.
>> The first thing I am trying to verify is the code flow of suspend.
>>
>> 1) With no debounce clock enabled, when I enable UART timeouts, I
>> automatically see
>> system going to retention. That is I don't have to type echo mem >
>> /sys/power/state
>> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>>
>> 2) I am do not see the print in omap_gpio_suspend/resume(), but I see
>> the print in
>> *_prepare_for_idle()/*_resume_after_idle().
>>
> Hmmm,
>
> This is mostly happening because you are missing a below
> fix from Kevin in the branch you are testing with.
>
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg54927.html
> {OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq handlers}
>
> If you rebase, your branch against 3.1-rc6, you should already
> have this fix. Commit {126caf1376e7}
Yes, this patch was missing in Kevin's branch and was
causing the suspend issue.

As pointed out by Kevin, debounce clock was not getting disabled.
In my testing I was somehow grepping CORE power domain instead
of PER power domain and hence missed it. The fix for the debounce
clock issue is at the end of the email.

- Have re-based the for_3.2/gpio-cleanup branch against 3.1-rc6.
- Dropped [PATCH 26/26] gpio/omap: add dbclk aliases for all gpio modules
as suggested by Kevin since it's already taken care by hwmod.
- Added the debounce clock fix in the end.

With above, PER is hitting low power state in Suspend and Idle path.

Have pushed a branch at below URL with mentioned changes.
git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
for_3.2/kevin/gpio-cleanup

Regards,
Tarun
