From: P.Bruenn@beckhoff.com (=?utf-8?B?UGF0cmljayBCcsO8bm4=?=)
Date: Thu, 12 Oct 2017 07:50:41 +0000
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Vellemans, Noel [mailto:Noel.Vellemans at visionBMS.com]
>Sent: Donnerstag, 5. Oktober 2017 16:19
>Hello,
>
Hi,
not sure if I can help on this, but as I did some testing myself I thought I should throw in my results as well.

>DryIce , SRTC not working on imx53. ( kernel 4.x)  ( same hardware running
>older kernel versions.. means , rtc is working)
>
Is it only the kernel you are changing? I am asking because I had the impression that hwclock behaves different on Debian stretch (util-linux 2.29.2) and jessie (util-linux 2.25.2).
I am saying impression because it seemed on jessie I would always get a response of hwclock, but on stretch never. When I did more systematic testing it looks like right after boot hwclock -r will always fail. But if I wait some minutes, all calls succeed.
>...
>QUICK analyses  ( could be wrong) ?
>It seems that hwclock is reading the current-timestamp 3 times and if not
>changed in those 3 read cycles? it sets up an read-interrupt-abort able time
>reader that should return as soon as the irq fires? but this seems to be
>missing !
>
I am seeing a lot of interrupts with kernel 4.14-rc4 (jessie and stretch), but they seem to be unhandled:
root at CX9020:~# uname -a
Linux CX9020 4.14.0-rc4+ #151 PREEMPT Wed Oct 11 10:40:34 CEST 2017 armv7l GNU/Linux
root at CX9020:~# hwclock -D -r
hwclock from util-linux 2.29.2
Using the /dev interface to the clock.
Last drift adjustment done at 1490885082 seconds after 1969
Last calibration done at 1490885082 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
[   26.795437] irq 40: nobody cared (try booting with the "irqpoll" option)
[   26.802696] handlers:
[   26.805031] [<c06029e8>] dryice_irq
[   26.808584] Disabling IRQ #40
select() to /dev/rtc to wait for clock tick timed out...synchronization failed
root at CX9020:~# cat /proc/interrupts
           CPU0
 17:       4276      tzic   1 Edge      mmc0
 18:         52      tzic   2 Edge      mmc1
 22:          0      tzic   6 Edge      sdma
 30:        176      tzic  14 Edge      53f80200.usb
 40:     100000      tzic  24 Edge      53fa4000.srtc
 48:        268      tzic  32 Edge      53fc0000.serial
 55:       2288      tzic  39 Edge      i.MX Timer Tick
 74:          0      tzic  58 Edge      53f98000.wdog
 79:        278      tzic  63 Edge      63fc4000.i2c
 93:          0      tzic  77 Edge      arm-pmu
103:        662      tzic  87 Edge      63fec000.ethernet
145:          0  gpio-mxc   1 Edge      50004000.esdhc cd
148:          0  gpio-mxc   4 Edge      50008000.esdhc cd
368:        674       IPU  23 Edge      imx_drm
369:          0       IPU  28 Edge      imx_drm
Err:          0

I added some tracing to dryice_irq() and saw that most of the time (if not all the time) dsr == DSR_MCO /* monotonic clock overflow */ with dier vary between 0x110, 0x10 and even 0x0.
I don't know what's the right thing to do, to recover from DSR_MCO. " return IRQ_HANDLED" will stop the nobody cared message but hwclock still times out.

And for completeness:
root at CX9020:~# dmesg | grep srtc
[    0.299043] imxdi_rtc 53fa4000.srtc: Unlocked unit detected
[    0.299539] imxdi_rtc 53fa4000.srtc: security violation interrupt not available.
[    0.299757] rtc rtc0: 53fa4000.srtc: dev (253:0)
[    0.299778] imxdi_rtc 53fa4000.srtc: rtc core: registered 53fa4000.srtc as rtc0
[    0.436785] imxdi_rtc 53fa4000.srtc: setting system clock to 2017-10-12 06:38:08 UTC (1507790288)
[  445.486624] imxdi_rtc 53fa4000.srtc: Write-wait timeout val = 0x59df0f8e reg = 0x00000008
[ 3025.076612] imxdi_rtc 53fa4000.srtc: Write-wait timeout val = 0x59df19a2 reg = 0x00000008
[ 3082.316612] imxdi_rtc 53fa4000.srtc: Write-wait timeout val = 0x59df19db reg = 0x00000008

Novice question: Is hwclock still required these days? For me it looks like the kernel is synchronizing with rtc on it's own. Maybe some kernel config is incompatible with hwclock?

Regards,
Patrick
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
