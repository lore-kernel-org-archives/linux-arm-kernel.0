From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Oct 2012 11:26:40 +0200
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <5085AC06.8070508@wwwdotorg.org>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
 <508080CB.5010904@wwwdotorg.org>
 <CACRpkdb5Jiw71jBLDXpf2VTJQx7_gABqs03_20CeCLbVT=JkaA@mail.gmail.com>
 <5085AC06.8070508@wwwdotorg.org>
Message-ID: <CACRpkdY-XyagxGU_ya_FZirzbqStTirOC5nuBBwwFY3f4bBTYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 10:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/22/2012 02:45 AM, Linus Walleij wrote:

>> For the Ux500 drivers we have found that all of those that have pin
>> resources actually have to be handled by the driver. The reason is
>> that all of them have idle and/or sleep states that need to be
>> handled at runtime.
>
> Well, presumably the pinctrl driver itself could have both default/idle
> states, and system sleep could engage the appropriate system-wide setting.

I thought about that, but it does not allow us to control the
resource activation/deactivation order.

In some drivers the suspend() path could be:

- pins to sleep
- clk_disable
- disable external regulator
- release power domain

In others:

- clk_disable()
- disable external regulator
- pins to sleep()
- release power domain

Ulf Hansson ran into this a while back.

Just like with the notifier approach, this approach assumes that either
the ordering above doesn't matter, or that it is the same for all drivers.

>> As an additional complication our drivers are used also by
>> the Versatile and SPEAr family of platforms, so the control
>> need to be tolerant (accept missing pinctrl handles and states)
>> as well. (I can see that other drivers take shortcuts by being less
>> elaborate since there is a 1:1 driver<->platform mapping.)
>
> Isn't the driver (or DT binding) supposed to define what pinctrl states
> must exist, and those state must always exist? There's no requirement
> for a pinctrl state definition to always actually contain content that
> changes the state. That's exactly why PIN_MAP_TYPE_DUMMY_STATE exists.

Well, it could also define that e.g. the "sleep" state is optional.

I'm sort of scared about imposing too strict usage patterns as
it may cause more problems than it solves even if the code
does look simpler.

>> An alternative to embedding the pin handling code into
>> the drivers is to use bus notifiers as is done with the
>> shmobile clocking by drivers/base/power/clock_ops.c
>> I could easily imagine pinctrl_ops.c like that for some
>> platforms. This mandates still binding the pin table entries
>> to a device but avoids adding any code to the drivers.
>>
>> However this latter approach does not work for us (Ux500) -
>> the three resources we have: clocks, pins and power domains
>> are dependent on state switch ordering (sometimes you need
>> to switch off the clock then set pin state, sometimes the
>> other way around) and it is not even
>> the same for all drivers - the notifier approach mandates
>> that all drivers do the clock, power domain and pin handling
>> uniformly.
>
> That certainly does imply that individual drivers do need to handle this
> explicitly. Although I still think that only specific drivers actually
> affected by this should end up actively managing pinctrl; shouldn't
> anything that can get away with relying on system hogs do so?

I don't know. Having say regulator, clock and pin handling in the
driver itself also gives a nice encapsulated view and sense of
control when just reading that one driver.

As one developer put it he does not really like that bus notifiers
are doing things behind his back. The debugging of the
driver can become very hairy, as you trace through bus
notifiers etc to find out what is wrong with your pins/clock/voltage.

We don't have hogs, bus notifiers and the like for regulators,
and IIRC Mark disliked the idea. Basically I think it's better if
all resources are atleast handled the same way.

Yours,
Linus Walleij
