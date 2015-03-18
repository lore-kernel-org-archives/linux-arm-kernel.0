From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 18 Mar 2015 11:31:09 +0100
Subject: exynos5800-peach-pi: suspend/resume (still) broken
In-Reply-To: <CAMAWPa_r04tAXAXosmLk+DfwvQV0qpD+=8O7T_pwFTAozcjOgQ@mail.gmail.com>
References: <CAMAWPa_r04tAXAXosmLk+DfwvQV0qpD+=8O7T_pwFTAozcjOgQ@mail.gmail.com>
Message-ID: <550953ED.10508@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+people involved in Exynos5420 S2R support (Abhilash, Vikas and Pankaj)

Hello Kevin,

On 03/17/2015 06:35 PM, Kevin Hilman wrote:
> I've tried suspend/resume on peach-pi using v4.0-rc4, next/master and
> samsung/for-next, and it doesn't seem to work on any of them.
> 
> The first problem was the exynos DRM driver is faulting so I had to set CONFIG_\
> DRM_EXYNOS=n for testing in mainline, this is fixed in -next.
>
> Note that RTC wake from "suspend to idle" seems to work, which
> suggests that the RTC wake alarms are working fine.  I tried with both
> the s3c and the max77802 RTC drivers (e.g. rtcwake -d rtc0 -m freeze
> -s4)
> 

Indeed, both max77802 and S3C RTCs wake alarm IRQ are being triggered:

# echo +1 > /sys/class/rtc/rtc0/wakealarm                                                                              
# echo +1 > /sys/class/rtc/rtc1/wakealarm
# grep alarm /proc/interrupts 
 62:          1          0          0          0       PMU  43  s3c2410-rtc alarm
124:          0          0          1          0  max77802-rtc   1  rtc-alarm1

and also as you said suspend-to-idle and resume works:

# echo +5 > /sys/class/rtc/rtc1/wakealarm && echo freeze > /sys/power/state

> However, trying suspend to RAM (rtcwake -d rtc0 -m mem -s4), it never
> resumes, and adding "no_console_suspend" doesn't give anything useful.
> 
> Anyone else having better luck with suspend/resume on peach-pi?
>

# echo +2 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state

Suspend and CPUs shutdown seems to succeed according to [0] but the system
never wakes up...

I also tried to wakeup the system with the keyboard and the trackpad that is
a wake up source but it does not work either.

I remember that when the 5420 s2r support series were posted, aclk200_disp1
and aclk300_disp1 clocks needed to be marked as CLK_IGNORE_UNUSED but afaiu
that was only because display support was not yet merged but it is now.

I tried anyways both marking those clocks as CLK_IGNORE_UNUSED and passing
the clk_ignore_unused to the kernel command line but did not work either.

Abhilash, Vikas, Pankaj,

Any ideas of what could be causing this regression? It seems that by the
time the Exynos5420 S2R support landed in mainline, it was already not
working which makes it hard to bisect what caused the issue.

> I also tried on exynos5422-odroid-xu3, but that doesn't seem to have
> any working RTC drivers. :(
> 
> Kevin
> 

Best regards,
Javier

[0]:
[  517.448354] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  517.453827] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  517.547922] wake enabled for irq 123
[  517.551373] wake enabled for irq 120
[  518.285645] wake enabled for irq 129
[  518.287762] wake enabled for irq 130
[  518.291901] PM: suspend of devices complete after 827.494 msecs
[  518.297218] ldo_35: No configuration
[  518.300769] ldo_34: No configuration
[  518.304327] ldo_33: No configuration
[  518.307899] ldo_32: No configuration
[  518.311513] ldo_29: No configuration
[  518.315000] ldo_28: No configuration
[  518.318554] ldo_27: No configuration
[  518.322090] ldo_26: No configuration
[  518.325667] ldo_25: No configuration
[  518.329224] ldo_24: No configuration
[  518.332780] ldo_23: No configuration
[  518.336317] ldo_21: No configuration
[  518.339894] ldo_20: No configuration
[  518.343451] ldo_19: No configuration
[  518.346988] ldo_18: No configuration
[  518.351369] vdd_1v8_7: No configuration
[  518.354739] vdd_1v2_2: No configuration
[  518.362718] PM: late suspend of devices complete after 3.781 msecs
[  518.371062] PM: noirq suspend of devices complete after 3.631 msecs
[  518.375863] Disabling non-boot CPUs ...
[  518.380035] IRQ50 no longer affine to CPU1
[  518.380266] CPU1: shutdown
[  518.399253] IRQ51 no longer affine to CPU2
[  518.399472] CPU2: shutdown
[  518.418914] IRQ52 no longer affine to CPU3
[  518.419121] CPU3: shutdown
