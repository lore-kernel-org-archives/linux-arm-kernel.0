From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 29 Aug 2013 18:55:40 +0800
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
Message-ID: <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 4:58 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 28, 2013 at 11:57 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> On Tue, Aug 20, 2013 at 04:32:28PM +0800, Zhangfei Gao wrote:
>
>>> Instead of use platform_driver_probe, use module_platform_driver
>>> To support deferred probing
>>> Also subsys_initcall may too early to auto set pinctl
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Acked-by: Baruch Siach <baruch@tkos.co.il>
>>
>> This patch is tougher than it looks. You need it, because
>> subsys_initcall may be too early for pinctrl.
>
> pinctrl is initialized very early, core_initcall().
>
> This is more a question of individual pin control drivers
> and when they probe, and dependencies trying to take
> a pinctrl handle before the pin controller is available
> will be deferred. Even by those grabbed in the core
> by drivers/base/pinctrl.c.

Thanks Linus.
Your explanation is really make sense.

We use drivers/pinctrl/pinctrl-single.c, if subsys_initcall for
pinctrl-single, no issue at all.

Checked in 3.11-rc4, there is really deferring probe happen.
i2c_designware fcb08000.i2c: could not find pctldev for node
/amba/pinmux at fc803000/i2c0
_pmx_func, deferring probe

However, bus_probe_device failed, since the drv name list does not
have i2c_designware.
deferred_probe_work_func -> bus_probe_device -> device_attach ->
bus_for_each_drv -> __device_attach

It can be solved change
return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
to
return platform_driver_register(&dw_i2c_driver);
static struct platform_driver dw_i2c_driver = {
        .probe          = dw_i2c_probe,
~

Dear Wolfram

Thanks for telling me the dependency about subsys_initcall.
Should I resubmit one patch using platform_driver_register while
keeping subsys_initcall?

Besides, also find platform_driver_probe is used in
drivers/i2c/busses/i2c-imx.c and drivers/i2c/busses/i2c-stu300.c.

Thanks
