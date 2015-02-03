From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 03 Feb 2015 19:31:49 +0100
Subject: [PATCH v2,
 RFC] RTC: PXA: Fix regression of interrupt before ioremap
In-Reply-To: <54D0D034.1060204@tul.cz> (Petr Cvek's message of "Tue, 03 Feb
 2015 14:42:12 +0100")
References: <54CA1ECA.8050000@tul.cz> <87fvatnzl7.fsf@free.fr>
 <54CF90F1.4020703@tul.cz> <87a90wb1uq.fsf@free.fr>
 <54D0D034.1060204@tul.cz>
Message-ID: <87siemalt6.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> On 2.2.2015 19:33, Robert Jarzmik wrote:
>> Petr Cvek <petr.cvek@tul.cz> writes:
> Actually only thing I want to know after reverting a44802f is how wakeup will
> work. Because a44802f suggests rtc-pxa needs to have interrupt enabled for
> waking up (and I cannot test it, because suspend subsystem on my machine needs
> to be fixed first).
Process X does :
 - open /dev/rtc0
 - call ioctl(fd, RTC_ALM_SET, &time_of_wakeup)
 - call ioctl(fd, RTC_AIE_ON, 0)
   - either read(fd, &data, sizeof(unsigned long))
   - or does write "mem" > /sys/power/state

 - ... platform sleeps ...
 - alarm time comes up, RTC IP raises the interrupt line
 - because in its pxa_rtc_probe(), the driver called device_init_wakeup(dev, 1),
   the register PWER was set to wakeup the platform if RTC interrupt is raised,
   the platform wakes up

>> Moreover, if there are multiple rtc device, how on earth can it work, ie. how
>> can an ioctl() be sent to a specific rtc device if there is no open() ???
>
> It confuses me too, so I tried to look it up and it seems rtc_dev_open() in
> drivers/rtc/rtc-dev.c handles this by:
>
> 	err = ops->open ? ops->open(rtc->dev.parent) : 0;
>     if (err == 0) {
>         spin_lock_irq(&rtc->irq_lock);
>         rtc->irq_data = 0;
>         spin_unlock_irq(&rtc->irq_lock);
>
>         return 0;
>     }
>
> , so without any .open() it just continues with success.
Yes, true, yet how do you set on a specific RTC block the alarm if you have many
of them on the system ?

Cheers.

-- 
Robert
