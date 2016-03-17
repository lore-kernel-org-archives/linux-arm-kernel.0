From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 16 Mar 2016 21:28:36 -0700
Subject: [PATCH 2/4] pinctrl: amlogic: Make driver independent from
 two-domain configuration
In-Reply-To: <CAOi56cWN-iPVh6Ace-SXUFoX4POnSyT0OmG8gyqivNpQTo9u4A@mail.gmail.com>
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
 <1456869876-19320-3-git-send-email-carlo@caione.org>
 <CAOi56cWN-iPVh6Ace-SXUFoX4POnSyT0OmG8gyqivNpQTo9u4A@mail.gmail.com>
Message-ID: <CAOi56cXG=-so8xcpW+j2ix7Wu10_1e9c=UHrOAZ3fApOv9W1Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 8:31 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Carlo
>
> On Tue, Mar 1, 2016 at 2:04 PM, Carlo Caione <carlo@caione.org> wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> In the Amlogic Meson8 / Meson8b platforms we have two different buses:
>> cbus and aobus, corresponding to 2 different power domains (regular and
>> always-on). On each bus a different set of registers is mapped to manage
>> muxes, GPIOs and in general to control a clear subset of the pins.
>>
>> Considering this architecture, having two different pinctrl devices, one
>> for each bus / power domain, makes much more sense than just having one
>> single device.
>>
>> Right now we have one single pin controller driver that uses two
>> different domains (represented by 'gpio' and 'gpio-ao' sub-nodes in the
>> DTS) to manage the set of registers on the two buses. This dual-domain
>> configuration is hardcoded into the driver that strictly requires one
>> domain for each bus in the same pin controller device.
>>
>> With this patch we refactor the driver to allow splitting the driver in
>> two parts. This change is needed to have a proper description of the HW
>> in the device-tree where we want to introduce aobus and cbus.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
> kernelci.org detected that the meson8b-odroidc1 started failing boot
> test in mainline[1] and I bisected it down to this patch, which is in
> mainline in he form of  commit 9dab1868ec0d (pinctrl: amlogic: Make
> driver independent from two-domain configuration.)
>
> I confirmed that reverting this patch on top of Linus' master branch
> (commit 9256d5a308c9) gets the odroid-c1 booting again.

Note  that the board was failing to boot in next-20160316 as well[1],
and reverting that same patch gets it booting again.

Kevin

[1] https://kernelci.org/boot/meson8b-odroidc1/job/next/kernel/next-20160316/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=56e991a359b514dd6b791517
