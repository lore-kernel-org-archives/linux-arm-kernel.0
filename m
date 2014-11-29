From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Sat, 29 Nov 2014 15:22:04 +0800
Subject: [PATCH v3 1/2] ARM: hip04: set ARCH_NR_GPIO to 128
In-Reply-To: <CACRpkdbahD314DL-ONQNkOzu9yHc_av4mxkqrYi8dS0PP43n8Q@mail.gmail.com>
References: <1417156188-500-1-git-send-email-wangzhou.bry@gmail.com>
 <1417156188-500-2-git-send-email-wangzhou.bry@gmail.com>
 <3094004.3WUKgY6xNz@wuerfel>
 <CACRpkdbahD314DL-ONQNkOzu9yHc_av4mxkqrYi8dS0PP43n8Q@mail.gmail.com>
Message-ID: <5479741C.6090301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?11?28? 23:54, Linus Walleij wrote:
> On Fri, Nov 28, 2014 at 10:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 28 November 2014 14:29:47 Zhou Wang wrote:
>
>>> Set ARCH_NR_GPIO for Hisilicon Soc Hip04, which has 4 GPIO
>>> controllers with 32 GPIOs each.
>>>
>>> Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
>>> ---
>>>   arch/arm/Kconfig                |    1 +
>>>   arch/arm/configs/hisi_defconfig |    3 +++
>>>   2 files changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 89c4b5c..26aae1e 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -1509,6 +1509,7 @@ config ARCH_NR_GPIO
>>>          default 352 if ARCH_VT8500
>>>          default 288 if ARCH_ROCKCHIP
>>>          default 264 if MACH_H4700
>>> +       default 128 if ARCH_HIP04
>>>          default 0
>>>          help
>>>            Maximum number of GPIOs in the system.
>>>
>>
>> If I remember correctly, you don't actually need to set this if all gpio
>> clients are using the new gpio descriptor interfaces instead of gpio
>> numbers.
>
> Unfortunately you still have to. We are working on removing the
> dependency on ARCH_NR_GPIO, old habits die hard. But I just
> merged this patch:
> http://marc.info/?l=linux-gpio&m=141638350328535&w=2
>
> Which makes the situation better.
>
> There is however some other use of this define, so there is
> some work required still to get rid of it.
>
> And that patch may blow up in testing too...
>
>> Linus, one question for you: Does the ARCH_NR_GPIO actually work as designed?
>> I see that e.g. OMAP4 defines 192 GPIO lines but does not have an ARCH_NR_GPIO
>> setting. In an OMAP4-only kernel you would get the default value (512)
>> from include/asm-generic/gpio.h, and in a multiplatform kernel you get at
>> least 512 if any of the (ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
>> SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || ARCH_SHMOBILE
>> || ARCH_TEGRA) are set, so that is still good.
>
> Yeah that is how it kind of works...
>
>> However if one builds a kernel that just enables OMAP4 and HIP04, I suspect
>> it can't work on OMAP4 for any gpio line above 128, which seems to be
>> a fundamental multiplatform problem.
>
> Yes I guess you are right :(

Hi Linus,

If so, what is your opinion about this patch about Hip04 GPIO?
If we use default ARCH_NR_GPIO, it will be strange to user:
for GPIO 0~127, their GPIO numbers are 384~511 :(

Best Regards,
Zhou Wang

>
> It's probably just so that so many platforms converge on 512.
>
>> Do we neet to increase the default to 512 for all ARCH_MULTIPLATFORM
>> configurations and just leave ARCH_SHMOBILE, ARCH_TEGRA and MACH_H4700
>> here as special cases?
>
> That'd be good while we are working to kill off
> ARCH_NR_GPIO for good.
>
> I guess there could be arch-specific problems with trying
> to get rid of ARCH_NR_GPIO for good, do you have some
> input on this? (Arch maintainer hat on...)
>
> Yours,
> Linus Walleij
>
