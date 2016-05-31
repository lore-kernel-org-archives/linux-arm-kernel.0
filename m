From: dianders@chromium.org (Doug Anderson)
Date: Tue, 31 May 2016 10:03:37 -0700
Subject: [PATCH 2/5] clocksource: rockchip: remove unnecessary clear irq
 before request_irq
In-Reply-To: <574CC839.60608@linaro.org>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-3-git-send-email-wxt@rock-chips.com>
 <574CC839.60608@linaro.org>
Message-ID: <CAD=FV=U5zqU0CMeg1dDTYHrRqWAxTQO_xk2T7p09GJuj-Fn9Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 30, 2016 at 4:09 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 05/25/2016 11:49 AM, Caesar Wang wrote:
>>
>> From: Huang Tao <huangtao@rock-chips.com>
>>
>> rk_timer_interrupt_clear and rk_timer_disable is unnecessary before
>> request_irq. Timer should keep disabled before booting Linux.
>
>
> That's true in the perfect world :/ Some version has u-boot letting the
> timer with irq enabled, therefore as soon as request_irq is done, an irq
> fires and leads to a kernel panic.
>
> On the other side, this timer is not used on the other rockchip version than
> rk3399 because of no need of a broadcast timer, so removing these two lines
> may be acceptable.
>
> Can try the changes with another board, eg rk3288 (and forcing to use this
> timer). Can you do the test and confirm it does not break with different
> version of u-boot ?

Actually, I'm not even sure that's true in a perfect world.  ;)  There
are two main problems that might be lurking here:

1. On exynos5 devices I've worked with, the private timer (MCT)
actually shared the same physical counter with the ARM Architected
Timer.  IIRC stopping or resetting the MCT had the effect of stopping
/ resetting the Arch Timer.  Is it the same for you?  As I understand
it the Arch Timer isn't supposed to ever be stopped or reset.  If
firmware left the timer stopped and the kernel happened to be compiled
without support for the Rockchip timer (but had the Arch Timers) then
things would be very broken.  Also the early kernel boot might be
broken if the Arch Timer inits before the Rockchip timer.

NOTE: If your timer and the Arch Timer are totally separate then point
#1 is not important.


2. Historically in Chrome OS there's been an unofficial agreement that
the firmware would start its high speed timer as soon as possible at
bootup and that this could be used to (roughly) measure the time
between the start of firmware and the start of the kernel.  That means
that the kernel was expecting the timer to actually be running when it
started up.  Yup, this is a bit of a hack and I'm not sure it's
terribly well documented, but it does provide a reason that firmware
might have left the timer running.


-Doug
