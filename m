From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Aug 2015 10:01:31 +0200
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-pl031.c: reset registers in
 init flow
In-Reply-To: <20150729111700.GA12912@leoy-linaro>
References: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
 <CACRpkdZ5Kvc0LPeG_HAHwejoCRV4JRbpA2+zwNCAxTqzxdDYzQ@mail.gmail.com>
 <20150729111700.GA12912@leoy-linaro>
Message-ID: <CACRpkdYnr8bw_3a7jnaSZqMmA6j+yyVKNrdA+TzSTdNxzaUu+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 1:17 PM, Leo Yan <leo.yan@linaro.org> wrote:

> This issue is found when i use file
> kernel/power/suspend_test.c to verify the system suspend. Before the
> system suspend, the flow need set 10's alarm in RTC for waken up
> event.
>
> But what i observed the phenomenon is:
>
> At the init phase:
> RTC_LR = 0x0;
> RTC_DR = 0x0;
> RTC_MR = 0x0;
>
> According to the timeout is 10s, the function *pl031_set_alarm()* will
> set RTC_MR = 10; So usually RTC_DR will increase one for every second
> and will trigger interrupt when RTC_DR equal to RTC_MR. But on
> Hi6220, though the RTC_DR init value is zero, but very soon it will be
> set a random value which is bigger than 10.

Aha, that's annoying.

> So it will never match with
> RTC_MR register anymore; finally the system cannot resume back due the
> waken up event will not be triggered.

OK I see.

> So suspect RTC_LR has not been initailized correctly and it will load
> random value to RTC_DR. After reset the RTC_LR, this issue will be
> fixed.
>
>> > +       /* Init registers */
>> > +       writel(0x0, ldata->base + RTC_LR);
>>
>> This will reset the clock to jan 1st 1970 on every reboot.
>> The idea is that the RTC should *preserve* the system time
>> if you reboot the system, so NACK.
>>
>> Usually userspace has a script using hwclock to read the
>> system time from the rtc to system time with hwclock -s
>> after userspace comes up. Likewise it writes it back with
>> hwclock -w before rebooting.
>
> This change is wrong.

I don't see what you mean here...

Most RTCs in the world have a battery back-up, so they
sustain time during shutdown. On an ARM system like this,
this PL031 derivative probably loose the time on shutdown,
but not on a soft reset.

However probe() will be called no matter if a shutdown or
soft reset happened, and the time will be reset to
1970-01-01 in any case with this change, even if it was
a soft reset and the time in the RTC is actually valid.

>> > +       writel(RTC_BIT_AI, ldata->base + RTC_ICR);
>>
>> So why do we want to have the alarm enabled by
>> default, before the kernel nor userspace has requested
>> it?
>
> This is to clear any pending interrupt, but not enable alarm.

OK.

>
>> If your problem is with suspend/resume I suggest you work
>> on the [runtime]_suspend/resume hooks instead of probe().
>> Possibly you need to save/restore state across suspend/resume.
>
> Do you think below change is make sense?

It's not using suspend/resume hooks but let's see...

> +       /* Init registers */
> +       writel(0x0, ldata->base + RTC_IMSC);
> +       writel(RTC_BIT_AI, ldata->base + RTC_ICR);

Looks OK.

> @@ -368,6 +372,9 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
>                                 writel(time, ldata->base + RTC_LR);
>                         }
>                 }
> +       } else {
> +               time = readl(ldata->base + RTC_DR);
> +               writel(time, ldata->base + RTC_LR);
>         }

This badly needs a comment in the else-clause describing
what is happening here.

But I think it looks right! This will preserve the time across
soft reboots properly if I read it right.

Yours,
Linus Walleij
