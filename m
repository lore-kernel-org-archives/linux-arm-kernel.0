From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 30 May 2013 18:40:55 +0530
Subject: [PATCH] ARM: EXYNOS: Update defconfig for Arndale and Origen board
In-Reply-To: <000001ce5c4f$839f4cb0$8adde610$@samsung.com>
References: <1368168599-28507-1-git-send-email-tushar.behera@linaro.org>
 <87sj1qzaov.fsf@linaro.org> <5191AA89.6010901@linaro.org>
 <20130528231740.GA28879@quad.lixom.net> <51A57D39.8030506@linaro.org>
 <CAOesGMh50Dzr_jczHZC5_txfW=6a+7EgFKvgZgj9MhUcVUTJ1Q@mail.gmail.com>
 <51A5C16D.20408@linaro.org> <000001ce5c4f$839f4cb0$8adde610$@samsung.com>
Message-ID: <3D99F44C56954EC59167436E26BE91F6@sisodomain.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Wednesday, May 29, 2013 5:51 PM, Tushar Behera:
>> On 05/29/2013 11:01 AM, Olof Johansson wrote:
>> > On Tue, May 28, 2013 at 8:59 PM, Tushar Behera 
>> > <tushar.behera@linaro.org> wrote:
>> >
>> >> The patches are at [1].
>> >
>> > FWIW, a cgit/gitweb link is easier to follow when you're reading an
>> > email. Anyway, found the patches.
>> >
>> >> There are a total of 6 patches on top of
>> >> v3.10-rc3. 3 of them (a, b, d) are queued for 3.10-rc4 and another 
>> >> patch
>> >> (c) is just a defconfig hack to get Arndale booting. Remaining 2 
>> >> patches
>> >> (e, f) are required to reset the hub during EHCI initialization.
>> >
>> > Huh, I thought you said that (c) wasn't needed when I posted the
>> > defconfig update. It'd be nice to see the code fixed to handle this
>> > case instead of Linaro carrying a patch like this though. I.e. make it
>> > able to deselect the uart, or make it tied to DEBUG_LL like on other
>> > platforms instead of having a separate config for this.
>> >
>>
>> It would be good to free up the dependency on the correct UART port for
>> the board to boot. Without that, there would always be boards that don't
>> boot with default mainline defconfig file even though all other
>> components are in place.
>>
>> >> a. ARM: exynos: defconfig update
>> >> b. ARM: EXYNOS: Update defconfig for Arndale and Origen board
>> >> c. [TEMP] ARM: EXYNOS: Set low-level UART port to 2
>> >> d. ARM: dts: Enabling samsung-usb2phy driver for exynos5250
>> >> e. usb: ehci-s5p: add the HSIC port initialization
>> >> f. ARM: dts: Add USB gpio entries for Arndale board
>> >>
>> >> I am not sure whether such kind of board-specific patches (e, f) are
>> >> appreciated in the drivers. But that is all we need to get USB and
>> >> Ethernet to work on v3.10-rc3 kernel.
>> >
>> > I've come across a similar situation with wifi reset sequence on the
>> > chromebook. On the product kernel we added some code to the board file
>> > to deal with it, but if we keep doing that things will grow out of
>> > hand.
>> >
>> > I don't know if it'll be unpopular, but I think it's time to start a
>> > drivers/platform/arm for these kind of things, and have those drivers
>> > probe on the system compatible value, similar to how x86 does it (with
>> > DMI tables). At least that's my plan for approaching the wifi
>> > reset/power-on sequence on the Chromebook. I hope to have patches in
>> > not all that long...
>> >
>> > Likewise, the hub reset/enable code doesn't have to go with the USB
>> > driver, right? I.e. if you cycle reset/enable on the hub after the
>> > host and phy is configured, you'll still have a working setup?
>> >
>>
>> Right, hub reset/enable code need not be tied up with USB driver. As per
>> your suggestion regarding drivers/platform/arm, I implemented an Arndale
>> specific driver [2] in drivers/platform/arm and verified USB and
>> ethernet to be working.
>
> CC'ed Thomas Abraham, Vivek Gautam
>
> I think so.
>
> I looked at Arndale board Schematics.
> 'Hub chip' on Arndale board needs hub reset/enable code.
> 'HUB_RESET' and 'HUB_CONNECT' pins are used to reset 'Hub chip'
> on Arndale board, not Exynos EHCI controller. So, Exynos EHCI driver
> does not need to consider this hub reset/enable code.
>
> If there is a driver for this 'Hub chip', 'Hub chip' driver maybe
> consider this.
>
> However, Olof Johansson mentioned, 'drivers/platform/arm/board_arndale.c'
> would be a good alternative.

We do have a driver for USB3503 in upstream now, which has enough 
infrastructure for us to use.
We just want to handle states of HUB_CONNECT line or RESET_N line, which 
should just be fine with this driver.

Am I missing something ?

>
>>
>> [2]
>> https://git.linaro.org/gitweb?p=landing-
>> teams/working/samsung/kernel.git;a=shortlog;h=refs/heads/upstream/arndale-usb-2
>
> It looks good.


Regards
Vivek 
