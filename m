From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 9 Nov 2017 04:03:27 +0100
Subject: DryIce , RTC not working on imx53.
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
Message-ID: <20171109030327.anzo47xayxckn47r@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2017 at 07:50:41 +0000, Patrick Br?nn wrote:
> I am seeing a lot of interrupts with kernel 4.14-rc4 (jessie and stretch), but they seem to be unhandled:
> root at CX9020:~# uname -a
> Linux CX9020 4.14.0-rc4+ #151 PREEMPT Wed Oct 11 10:40:34 CEST 2017 armv7l GNU/Linux
> root at CX9020:~# hwclock -D -r
> hwclock from util-linux 2.29.2
> Using the /dev interface to the clock.
> Last drift adjustment done at 1490885082 seconds after 1969
> Last calibration done at 1490885082 seconds after 1969
> Hardware clock is on UTC time
> Assuming hardware clock is kept in UTC time.
> Waiting for clock tick...
> [   26.795437] irq 40: nobody cared (try booting with the "irqpoll" option)
> [   26.802696] handlers:
> [   26.805031] [<c06029e8>] dryice_irq
> [   26.808584] Disabling IRQ #40
> select() to /dev/rtc to wait for clock tick timed out...synchronization failed
> root at CX9020:~# cat /proc/interrupts
>            CPU0
>  17:       4276      tzic   1 Edge      mmc0
>  18:         52      tzic   2 Edge      mmc1
>  22:          0      tzic   6 Edge      sdma
>  30:        176      tzic  14 Edge      53f80200.usb
>  40:     100000      tzic  24 Edge      53fa4000.srtc
>  48:        268      tzic  32 Edge      53fc0000.serial
>  55:       2288      tzic  39 Edge      i.MX Timer Tick
>  74:          0      tzic  58 Edge      53f98000.wdog
>  79:        278      tzic  63 Edge      63fc4000.i2c
>  93:          0      tzic  77 Edge      arm-pmu
> 103:        662      tzic  87 Edge      63fec000.ethernet
> 145:          0  gpio-mxc   1 Edge      50004000.esdhc cd
> 148:          0  gpio-mxc   4 Edge      50008000.esdhc cd
> 368:        674       IPU  23 Edge      imx_drm
> 369:          0       IPU  28 Edge      imx_drm
> Err:          0
> 
> I added some tracing to dryice_irq() and saw that most of the time (if not all the time) dsr == DSR_MCO /* monotonic clock overflow */ with dier vary between 0x110, 0x10 and even 0x0.
> I don't know what's the right thing to do, to recover from DSR_MCO. " return IRQ_HANDLED" will stop the nobody cared message but hwclock still times out.
> 

hwclock times out because the alarm is not working properly. Can you
check whether rtctest is working?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
