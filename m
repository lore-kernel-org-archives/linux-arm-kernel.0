From: spk.linux@gmail.com (Sachin Kamat)
Date: Fri, 1 Aug 2014 12:14:41 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <CAK5sBcEPQtMvT+mp4+jXQA06FcBRTdAVJLbTCtCu-kV07Wh5RQ@mail.gmail.com>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <12165027.MHmNZOI7jc@wuerfel>
 <CAOesGMjo0AY=eGcfTh1sVxKkURK9bzK8SBAeEbvBFN4R0sF34A@mail.gmail.com>
 <CAC5m3BwDvHVMJEfXE4w5zQ2RYXYt9PRF8uP=3M03Rr3Ls=N4eQ@mail.gmail.com>
 <CAK5sBcEPQtMvT+mp4+jXQA06FcBRTdAVJLbTCtCu-kV07Wh5RQ@mail.gmail.com>
Message-ID: <CAK5sBcGrAKCRYvLxvgeDU=Bu-MoDTgwY+dmEBbiuCpn5ttRU3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 11:56 AM, Sachin Kamat <spk.linux@gmail.com> wrote:
> On Thu, Jul 31, 2014 at 11:37 AM, Tushar Behera <trblinux@gmail.com> wrote:
>> On Wed, Jul 23, 2014 at 1:58 AM, Olof Johansson <olof@lixom.net> wrote:
>>> On Tue, Jul 22, 2014 at 11:36 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Tuesday 22 July 2014 11:01:10 Olof Johansson wrote:
>>>>> This is a major refresh of the multi_v7_defconfig:
>>>>>
>>>>> - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
>>>>>  * Enable big.LITTLE
>>>>>  * MCPM
>>>>>  * CYAPA touchpad
>>>>>  * Samsung-related MTD/regulator/clk/pinmux drivers
>>>>>  * Add some of the CrOS EC drivers
>>>>> - Turn on TPM, HW_RANDOM
>>>>> - OMAP_USB3 -> TI_PIPE3 option rename
>>>>> - Enable MCPM/b.L for VEXPRESS
>>>>> - Add new CONFIG_MTD_SPI_NOR since it otherwise masks off SPI NOR drivers
>>>>> - CONFIG_LOGO, because penguins.
>>>>>
>>>>> I took care to keep the new options that have been added for whose the
>>>>> drivers are not yet in our for-next branch. This was pretty awkward so
>>>>> we should sort out how to handle those better in the future.
>>>>
>>>> Since you've already done all those, how about enabling THUMB2_KERNEL?
>>>> For the multi_v7_defconfig, it should actually give some benefits,
>>>> since it's rather large, and it would be good to have some more testing
>>>> with this option enabled.
>>>>
>>>> I guess the first step would be to enable it and just see if your
>>>> boot farm survives the change.
>>>
>>> Good point, I'll definitely give that a go once the current issues are resolved.
>>>
>>> Which are: These changes make 5250-based machines (snow and arndale)
>>> break. Lots of i2c timeouts on SATA and hdmi-phy. Looks like arndale
>>> might be missing pinctrl setups for it?
>
> i2c timeout issue should have been fixed with the following patch:
> i2c: i2c-s3c2410: Drop class based scanning to improve bootup time
> (commit id: 6031d3dfc73b49bede540872e51a70ee0b6786d4) which is
> available on Wolfram's I2C tree (should be part of linux-next too). Also
> I do not see I2C_S3C2410 enabled in the config.
> I do not have access to h/w today. I can verify and check tomorrow or
> somebody could test it in the meantime with the above suggestions?

Olof,
Tested your multi_v7_defconfig patch on top of latest linux-next (20140731).
I did not see any aforementioned i2c issues on 5250 based Snow board. It
booted fine. However on 5250 based Arndale board, the boot stops at
the following:

[    1.951863] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.956937] ehci-pci: EHCI PCI platform driver
[    1.961392] ehci-exynos: EHCI EXYNOS driver
[    1.965698] exynos-ehci 12110000.usb: EHCI Host Controller
[    1.971007] exynos-ehci 12110000.usb: new USB bus registered,
assigned bus number 1
[    1.981593] exynos-ehci 12110000.usb: can't setup: -110
[    1.985361] exynos-ehci 12110000.usb: USB bus 1 deregistered
[    1.991001] exynos-ehci 12110000.usb: Failed to add USB HCD
[    1.996569] exynos-ehci: probe of 12110000.usb failed with error -110
[    2.003041] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.009149] ohci-exynos: OHCI EXYNOS driver
[    2.013457] exynos-ohci 12120000.usb: USB Host Controller
[    2.018702] exynos-ohci 12120000.usb: new USB bus registered,
assigned bus number 1

Boots well with exynos_defconfig though. Probably some conflict with
other config options?
I couldn't find out as I am busy with some other activity.

-- 
Regards,
Sachin.
