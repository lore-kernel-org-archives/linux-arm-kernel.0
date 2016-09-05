From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 5 Sep 2016 14:49:16 +0300
Subject: [PATCH 0/3] gpio/pinctrl: imx: let IOMUX controller know about
 on-SoC GPIOs
In-Reply-To: <20160905021201.GC25778@tiger>
References: <1471644615-10320-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <cc5ab313-c3c6-bfd4-d2b8-92a7d153cf05@mentor.com>
 <20160905021201.GC25778@tiger>
Message-ID: <1c1d23a0-9656-2682-e573-13385a002998@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 09/05/2016 05:12 AM, Shawn Guo wrote:
> On Fri, Sep 02, 2016 at 04:11:46PM +0300, Vladimir Zapolskiy wrote:
>> Hi Shawn, Fabio,
>>
>> On 08/20/2016 01:10 AM, Vladimir Zapolskiy wrote:
>>> The change establishes a connection between on-SoC IOMUX controller(s)
>>> and GPIO controllers found on some SoC from Freescale/NXP iMX series,
>>> if a GPIO controller device node contains common gpio-ranges information.
>>>
>>> The change is backward compatible with respect to potentially not updated
>>> outdated DTB data without gpio-ranges propery, for such boards the only
>>> functional change is lowered initcall priority of GPIO controller driver,
>>> which in general anyway is exected to be used only after pinctrl/pinmux
>>> controller.
>>>
>>> If this change is applied the next interesting applications may be done
>>> as a follow-up work, for example switching pad function to GPIO on gpiod
>>> request, converting iomux controller driver to strict type and so on.
>>>
>>> For actual values of gpio-ranges properties please reference series
>>> "ARM: dts: imx: add gpio-ranges properties to some iMX GPIO controllers"
>>> http://archive.arm.linux.org.uk/lurker/message/20160819.220621.86d845d1.en.html
>>>
>>> Deepak Das (1):
>>>  gpio: mxc: lower level of gpio_mxc_init() initcall
>>>
>>> Vladimir Zapolskiy (2):
>>>  pinctrl: imx: accept gpio request/free from pinctrl
>>>  gpio: mxc: add generic gpio request/free callbacks to pinctrl
>>>
>>> drivers/gpio/gpio-mxc.c                 | 7 ++++++-
>>> drivers/pinctrl/freescale/pinctrl-imx.c | 4 ++--
>>> 2 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>
>> no comments so far, please could you express your concerns about
>> this change? IMHO it would be nice to have this feature enabled
>> in v4.9.
>>
>> I assume that the most worrisome commit is the change of GPIO controller
>> driver init level, but I belive it is safe enough, no?
>
> If I understand it correctly, with the change, most of GPIO client
> device drivers use the same init level as GPIO driver.  So we are not
> sure if GPIO driver is ready when client drivers try to request GPIO.

please give it a test run (with and without DTS gpio-ranges changes,
or just 2/3 from the series), I've tested on iMX6Q SabreLite, SabreAuto,
SabreSD and I don't see any regressions or noticeable increase of
-EPROBE_DEFER hits due to not ready GPIOs.

> most of GPIO client device drivers use the same init level as GPIO driver.

IMHO that will be the case, if the change 2/3 from the series is applied.

Statisticaly most of GPIO consumers should settle on device_initcall or
module_init level, the latter one is translated to device_initcall if
a driver is built-in, so the proposed downgrading of GPIO controller
driver init call level looks to be appropriate.

However pinctrl/pinmux driver should definitely have higher init level
priority in comparison to GPIO controller driver, every GPIO consumer
is a pinctrl/pinmux consumer as well, most of iMX pinctrl/pinmux drivers
are initialized at arch_initcall level, so there is a plenty of options
to satisfy (GPIO driver initcall) < (pinmux/pinctrl driver initcall)
equation:
* change pinmux/pinctrl driver initcall level to postcore_initcall
   and GPIO driver initcall level to arch_initcall or lower one,
* keep pinmux/pinctrl driver@arch_initcall level, set GPIO driver
   initcall level to any lower than arch_initcall (e.g. device_initcall)
* keep everything as is, drop 2/3 and rely on -EPROBE_DEFER from
   GPIO driver probe due to not yet initialized pinctrl driver.

> It shouldn't be a problem if every client driver handle the failure
> with deferred probing, but I'm not sure that's the case now.
>

 From what I see it is the case for the most critical drivers, for the
rest I believe it is a bug, which can be revealed by shifting GPIO
driver initcall level and fixed, see also

https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003419.html

--
With best wishes,
Vladimir
