From: dianders@chromium.org (Doug Anderson)
Date: Tue, 31 May 2016 19:36:55 -0700
Subject: [PATCH 2/5] clocksource: rockchip: remove unnecessary clear irq
 before request_irq
In-Reply-To: <574E48CC.1040004@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-3-git-send-email-wxt@rock-chips.com>
 <574CC839.60608@linaro.org>
 <CAD=FV=U5zqU0CMeg1dDTYHrRqWAxTQO_xk2T7p09GJuj-Fn9Gw@mail.gmail.com>
 <574E48CC.1040004@rock-chips.com>
Message-ID: <CAD=FV=WA6OaOTM07+qxDJOW_TMsG06eAYwq5p5L_hw7PKd5MwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 31, 2016 at 7:30 PM, Huang, Tao <huangtao@rock-chips.com> wrote:
>> Actually, I'm not even sure that's true in a perfect world.  ;)  There
>> are two main problems that might be lurking here:
>>
>> 1. On exynos5 devices I've worked with, the private timer (MCT)
>> actually shared the same physical counter with the ARM Architected
>> Timer.  IIRC stopping or resetting the MCT had the effect of stopping
>> / resetting the Arch Timer.  Is it the same for you?  As I understand
>> it the Arch Timer isn't supposed to ever be stopped or reset.  If
>> firmware left the timer stopped and the kernel happened to be compiled
>> without support for the Rockchip timer (but had the Arch Timers) then
>> things would be very broken.  Also the early kernel boot might be
>> broken if the Arch Timer inits before the Rockchip timer.
>>
>> NOTE: If your timer and the Arch Timer are totally separate then point
>> #1 is not important.
>
> We never use the timer which provide clock source of arch timer as
> clockevent timer. If we do such stupid thing, when rk timer disabled,
> the arch timer will stop too. Generally, we use this special timer as
> clocksouce or never touch it again when it is running.

Ah, OK.  :)  I didn't go through and review / test the code.  I just
wanted to make sure we weren't going to run into the same bug I
remember running into before.  ;)


>> 2. Historically in Chrome OS there's been an unofficial agreement that
>> the firmware would start its high speed timer as soon as possible at
>> bootup and that this could be used to (roughly) measure the time
>> between the start of firmware and the start of the kernel.  That means
>> that the kernel was expecting the timer to actually be running when it
>> started up.  Yup, this is a bit of a hack and I'm not sure it's
>> terribly well documented, but it does provide a reason that firmware
>> might have left the timer running.
>
> Why you chose the timer shared with Linux kernel, there are so many
> timer? I think loader should do the right thing, uninit the resources
> when it boot the kernel. I believe this code is lagacy from very old
> chip such as rk2908 which is Cortex-A8. There are not arch timer, so the
> loader may keep the timer running when enter kernel. Any way, if we
> adopt the code suggested by Daniel, it is safe to keep the code.

If this is a separate / distinct timer than the main clocksource
timer, then you can ignore my comments.  ;)

...but obviously the comments from Daniel are much more important to
address and it sounds like you're all set for doing that.  :)

-Doug
