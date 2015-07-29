From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jul 2015 11:08:30 +0200
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-pl031.c: reset registers in
 init flow
In-Reply-To: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
References: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CACRpkdZ5Kvc0LPeG_HAHwejoCRV4JRbpA2+zwNCAxTqzxdDYzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 8:02 AM, Leo Yan <leo.yan@linaro.org> wrote:

> When use rtc-pl031 for suspend test on Hisilicon's SoC Hi6220, Usually
> the data register (DR) will read back as value zero. So the suspend
> test code will set the match register (MR) for 10 seconds' timeout; But
> there have chance later will read back some random values from DR
> register; So finally miss with match value and will not trigger
> waken up event anymore.
>
> This issue can be dismissed by reset registers in initialization flow;
> And this code have no harm for ST's variant.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

I don't understand this...

> +       /* Init registers */
> +       writel(0x0, ldata->base + RTC_LR);

This will reset the clock to jan 1st 1970 on every reboot.
The idea is that the RTC should *preserve* the system time
if you reboot the system, so NACK.

Usually userspace has a script using hwclock to read the
system time from the rtc to system time with hwclock -s
after userspace comes up. Likewise it writes it back with
hwclock -w before rebooting.

> +       writel(0x0, ldata->base + RTC_DR);

This is a read-only register in the PL031 clean variant.
What do you want to achieve here? Is this register writeable
on the HiSilicon?

> +       writel(0x0, ldata->base + RTC_IMSC);

OK

> +       writel(RTC_BIT_AI, ldata->base + RTC_ICR);

So why do we want to have the alarm enabled by
default, before the kernel nor userspace has requested
it?

If your problem is with suspend/resume I suggest you work
on the [runtime]_suspend/resume hooks instead of probe().
Possibly you need to save/restore state across suspend/resume.

Yours,
Linus Walleij
