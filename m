From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Aug 2015 15:54:18 +0200
Subject: [PATCH 2/2] soc/fsl: add ftm alarm driver for ls1021a platform
In-Reply-To: <1439358807-9024-2-git-send-email-dongsheng.wang@freescale.com>
References: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
 <1439358807-9024-2-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <CACRpkdbninKuGzhEc5mN+85j-=w_wYQgra-Ark_Du6gWKN2=tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 7:53 AM, Dongsheng Wang
<dongsheng.wang@freescale.com> wrote:

> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> Only Ftm0 can be used when system going to deep sleep. So this driver
> to support ftm0 as a wakeup source.
>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *V2*
> Change Copyright 2014 to 2015.
(...)
> +config FTM_ALARM
> +       bool "FTM alarm driver"
> +       depends on SOC_LS1021A
> +       default n
> +       help
> +         Say y here to enable FTM alarm support.  The FTM alarm provides
> +         alarm functions for wakeup system from deep sleep.  There is only
> +         one FTM can be used in ALARM(FTM 0).
(...)
> +static u32 time_to_cycle(unsigned long time)
> +static u32 cycle_to_time(u32 cycle)
> +static int ftm_set_alarm(u64 cycle)
> +static irqreturn_t ftm_alarm_interrupt(int irq, void *dev_id)
> +static ssize_t ftm_alarm_show(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf)
> +static ssize_t ftm_alarm_store(struct device *dev,
> +                              struct device_attribute *attr,
> +                              const char *buf, size_t count)
(...)
> +static struct device_attribute ftm_alarm_attributes = __ATTR(ftm_alarm, 0644,
> +                       ftm_alarm_show, ftm_alarm_store);

If you're gonna invent ABIs, document then in Documentation/ABI/testing/*.

But I don't get it. Why is this driver not in drivers/rtc?

It does a subset of what an RTC does. The ioctl()'s of an RTC
can do what you want to do. And much much more.

If it can't do all an RTC can do, surely the RTC subsystem
can be augmented to host it anyway. It's way to close to
an RTC to have it's own random sysfs driver like this.

Unless I'm totally off, rewrite this to an RTC driver and post
it to the RTC maintainers.

Yours,
Linus Walleij
