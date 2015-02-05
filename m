From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 05 Feb 2015 21:36:20 +0100
Subject: [PATCH v2, RFC] RTC: PXA: Fix regression of interrupt before
 ioremap
In-Reply-To: <87siemalt6.fsf@free.fr>
References: <54CA1ECA.8050000@tul.cz> <87fvatnzl7.fsf@free.fr>
 <54CF90F1.4020703@tul.cz> <87a90wb1uq.fsf@free.fr> <54D0D034.1060204@tul.cz>
 <87siemalt6.fsf@free.fr>
Message-ID: <54D3D444.30008@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3.2.2015 19:31, Robert Jarzmik wrote:
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> On 2.2.2015 19:33, Robert Jarzmik wrote:
>>> Petr Cvek <petr.cvek@tul.cz> writes:
>> Actually only thing I want to know after reverting a44802f is how wakeup will
>> work. Because a44802f suggests rtc-pxa needs to have interrupt enabled for
>> waking up (and I cannot test it, because suspend subsystem on my machine needs
>> to be fixed first).
> Process X does :
>  - open /dev/rtc0
>  - call ioctl(fd, RTC_ALM_SET, &time_of_wakeup)
>  - call ioctl(fd, RTC_AIE_ON, 0)
>    - either read(fd, &data, sizeof(unsigned long))
>    - or does write "mem" > /sys/power/state
> 
>  - ... platform sleeps ...
>  - alarm time comes up, RTC IP raises the interrupt line
>  - because in its pxa_rtc_probe(), the driver called device_init_wakeup(dev, 1),
>    the register PWER was set to wakeup the platform if RTC interrupt is raised,
>    the platform wakes up
> 

I was thinking more about setting alarm, ending the OS (and all processes), powering down DRAM, SRAM etc. and then waiting for alarm (like x86 BIOS alarm) to restart.

>>> Moreover, if there are multiple rtc device, how on earth can it work, ie. how
>>> can an ioctl() be sent to a specific rtc device if there is no open() ???
>>
>> It confuses me too, so I tried to look it up and it seems rtc_dev_open() in
>> drivers/rtc/rtc-dev.c handles this by:
>>
>> 	err = ops->open ? ops->open(rtc->dev.parent) : 0;
>>     if (err == 0) {
>>         spin_lock_irq(&rtc->irq_lock);
>>         rtc->irq_data = 0;
>>         spin_unlock_irq(&rtc->irq_lock);
>>
>>         return 0;
>>     }
>>
>> , so without any .open() it just continues with success.
> Yes, true, yet how do you set on a specific RTC block the alarm if you have many
> of them on the system ?

I thought it should be possible with ioctl with appropriate /dev/rtcX opened or /sys/class/rtc/rtcX/wakealarm . 

It seems driver still does not work properly (with reverted patch). For first run the /sys/class/rtc/rtcX/wakealarm file is not created, but it is created for next reload of rtc-pxa module. And it seems that it is caused by .can_wakeup somewhere. 

P.S. Testing application from Documentation/rtc.txt seems to run OK.
