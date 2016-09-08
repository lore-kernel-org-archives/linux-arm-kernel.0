From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Sep 2016 09:41:07 +0800
Subject: [PATCH 0/3] gpio/pinctrl: imx: let IOMUX controller know about
 on-SoC GPIOs
In-Reply-To: <1c1d23a0-9656-2682-e573-13385a002998@mentor.com>
References: <1471644615-10320-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <cc5ab313-c3c6-bfd4-d2b8-92a7d153cf05@mentor.com>
 <20160905021201.GC25778@tiger>
 <1c1d23a0-9656-2682-e573-13385a002998@mentor.com>
Message-ID: <20160908014107.GA2533@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 02:49:16PM +0300, Vladimir Zapolskiy wrote:
> >If I understand it correctly, with the change, most of GPIO client
> >device drivers use the same init level as GPIO driver.  So we are not
> >sure if GPIO driver is ready when client drivers try to request GPIO.
> 
> please give it a test run (with and without DTS gpio-ranges changes,
> or just 2/3 from the series), I've tested on iMX6Q SabreLite, SabreAuto,
> SabreSD and I don't see any regressions or noticeable increase of
> -EPROBE_DEFER hits due to not ready GPIOs.
> 
> >most of GPIO client device drivers use the same init level as GPIO driver.
> 
> IMHO that will be the case, if the change 2/3 from the series is applied.
> 
> Statisticaly most of GPIO consumers should settle on device_initcall or
> module_init level, the latter one is translated to device_initcall if
> a driver is built-in, so the proposed downgrading of GPIO controller
> driver init call level looks to be appropriate.
> 
> However pinctrl/pinmux driver should definitely have higher init level
> priority in comparison to GPIO controller driver, every GPIO consumer
> is a pinctrl/pinmux consumer as well, most of iMX pinctrl/pinmux drivers
> are initialized at arch_initcall level, so there is a plenty of options
> to satisfy (GPIO driver initcall) < (pinmux/pinctrl driver initcall)
> equation:
> * change pinmux/pinctrl driver initcall level to postcore_initcall
>   and GPIO driver initcall level to arch_initcall or lower one,
> * keep pinmux/pinctrl driver at arch_initcall level, set GPIO driver
>   initcall level to any lower than arch_initcall (e.g. device_initcall)
> * keep everything as is, drop 2/3 and rely on -EPROBE_DEFER from
>   GPIO driver probe due to not yet initialized pinctrl driver.
> 
> >It shouldn't be a problem if every client driver handle the failure
> >with deferred probing, but I'm not sure that's the case now.
> >
> 
> From what I see it is the case for the most critical drivers, for the
> rest I believe it is a bug, which can be revealed by shifting GPIO
> driver initcall level and fixed, see also
> 
> https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003419.html

Okay, fair enough.

For the series,

Acked-by: Shawn Guo <shawnguo@kernel.org>
