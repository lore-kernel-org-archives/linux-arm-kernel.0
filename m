From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 10 Sep 2014 16:12:55 -0700
Subject: [PATCH 0/2] IO voltage domain support for rk3188 and rk3288
In-Reply-To: <CACRpkda-XS0XLSkAZ-16=JvD8FbRJNuN4UVL4dMyV71bfU5T2A@mail.gmail.com>
 (Linus Walleij's message of "Thu, 4 Sep 2014 18:51:47 +0200")
References: <1409254565-10677-1-git-send-email-dianders@chromium.org>
 <53FF9E93.3040601@ti.com>
 <CAD=FV=Vcj+tAno92c38Prviyi-v2CmuGSzak1ppETL033KAF4w@mail.gmail.com>
 <1450179.xJuMFg9Vvn@diego>
 <CACRpkda-XS0XLSkAZ-16=JvD8FbRJNuN4UVL4dMyV71bfU5T2A@mail.gmail.com>
Message-ID: <7hlhprqdc8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Sat, Aug 30, 2014 at 1:27 PM, Heiko St?bner <heiko@sntech.de> wrote:
>> Am Freitag, 29. August 2014, 21:51:46 schrieb Doug Anderson:
>>> On Thu, Aug 28, 2014 at 2:26 PM, Santosh Shilimkar
>>>
>>> <santosh.shilimkar@ti.com> wrote:
>>> > On Thursday 28 August 2014 03:36 PM, Doug Anderson wrote:
>>> >> These two patches add support for automatically configuring the IO
>>> >> voltage domains on rk3188 and rk3288 SoCs.  The first patch adds some
>>> >> new notification types to the regulator code.  It's used by the second
>>> >> patch which actually implements the IO voltage domain driver.
>>> >>
>>> >> These two patches were co-developed by Heiko St?bner and Doug Anderson
>>> >> (proof of concept patches were written by Heiko).  They were tested in
>>> >> a private branch on an rk3288 board using rk808 instead of mainline
>>> >> since rk808 support isn't finalized in mainline yet.
>>> >>
>>> >> (sorry if you got this series twice; my mailer seems unhappy with me)
>>> >>
>>> >> Heiko St?bner (2):
>>> >>   regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT)
>>> >>   soc/rockchip: io-domain: add driver handling io domains
>>> >
>>> > Sorry to shot down but your IO domains are nothing but voltage domains
>>> > and you should really build something in the drivers/power/*
>>>
>>> If everyone agrees that this belongs in drivers/power that's totally
>>> OK.  Neither Heiko nor I was confident that it should be in
>>> drivers/soc.  I had even though that the code wouldn't be totally out
>>> of place in the Rockchip pinctrl driver (adding Linus W since I think
>>> some SoCs did add code to handle 3.3V vs. 1.8V in pinctrl).
>>
>> a bit of context for Linus ...
>>
>> This is essentially the continuation of  the thread "io-domain voltages as
>> regulators?" from the beginning of august. After more discussions we found out
>> that the io voltage selection I asked about is not an independent supply, but
>> instead has to reflect the voltage of the real supplying regulator.
>>
>> And setting the io-voltage setting to 1.8V while the regulator is supplying
>> 3.3V for example may actually damage the chip.
>>
>>
>> So in our current approach here, we added a driver that tracks voltage changes
>> of the supplying regulator via a notifier and sets the register bits
>> accordingly.
>
> I feel I'm not smart enough for this. You need the PM people to look
> at this stuff, like Rafael Wysocki, Kevin Hilman and Ulf Hansson.

I think the best fit for this is along with the Adaptive Voltage Scaling
(AVS) stuff we currently have in drivers/power/avs.  It's not exactly
adaptive in the same sense as the TI/SmartReflex is because there's no
hardware being configured to dynamically make micro-adjustments to the
regulators.  But, it is adaptive in the sense that there's SoC-specific
"stuff" to do right around the same time the voltage is scaled.

So I would suggest drivers/power/avs.

Kevin
