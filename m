From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 14:26:46 -0600
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <CACRpkdb5Jiw71jBLDXpf2VTJQx7_gABqs03_20CeCLbVT=JkaA@mail.gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
 <508080CB.5010904@wwwdotorg.org>
 <CACRpkdb5Jiw71jBLDXpf2VTJQx7_gABqs03_20CeCLbVT=JkaA@mail.gmail.com>
Message-ID: <5085AC06.8070508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 02:45 AM, Linus Walleij wrote:
> On Fri, Oct 19, 2012 at 12:20 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> On 10/18/2012 03:06 AM, Haojian Zhuang wrote:
>>> Configure pins by pinctrl driver.
>>
>> In general, it seems better to use pinctrl "hogs" if the driver is only
>> going to statically set up one pinctrl state and never change it. The
>> alternative is make every single driver execute these pinctrl calls,
>> which could be tedious.
> 
> True. And each platform has to choose how to go ahead with this.
> 
> I always imagined that any system of the "power socket in wall"
> type would just use hogs to configure its pins and be done with
> it, and there appear to be some platforms like that. (e.g. MIPS and
> various power-inaware references come to mind).
> 
> For the Ux500 drivers we have found that all of those that have pin
> resources actually have to be handled by the driver. The reason is
> that all of them have idle and/or sleep states that need to be
> handled at runtime.

Well, presumably the pinctrl driver itself could have both default/idle
states, and system sleep could engage the appropriate system-wide setting.

> As an additional complication our drivers are used also by
> the Versatile and SPEAr family of platforms, so the control
> need to be tolerant (accept missing pinctrl handles and states)
> as well. (I can see that other drivers take shortcuts by being less
> elaborate since there is a 1:1 driver<->platform mapping.)

Isn't the driver (or DT binding) supposed to define what pinctrl states
must exist, and those state must always exist? There's no requirement
for a pinctrl state definition to always actually contain content that
changes the state. That's exactly why PIN_MAP_TYPE_DUMMY_STATE exists.

> An alternative to embedding the pin handling code into
> the drivers is to use bus notifiers as is done with the
> shmobile clocking by drivers/base/power/clock_ops.c
> I could easily imagine pinctrl_ops.c like that for some
> platforms. This mandates still binding the pin table entries
> to a device but avoids adding any code to the drivers.
> 
> However this latter approach does not work for us (Ux500) -
> the three resources we have: clocks, pins and power domains
> are dependent on state switch ordering (sometimes you need
> to switch off the clock then set pin state, sometimes the
> other way around) and it is not even
> the same for all drivers - the notifier approach mandates
> that all drivers do the clock, power domain and pin handling
> uniformly.

That certainly does imply that individual drivers do need to handle this
explicitly. Although I still think that only specific drivers actually
affected by this should end up actively managing pinctrl; shouldn't
anything that can get away with relying on system hogs do so?
