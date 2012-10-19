From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 19 Oct 2012 10:16:12 +0800
Subject: [PATCH 01/10] pinctrl: use postcore_initcall
In-Reply-To: <20121018222802.GG30550@atomide.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <5080802B.3000209@wwwdotorg.org>
 <20121018222802.GG30550@atomide.com>
Message-ID: <CAN1soZy17wO2s7WoRSRod8k5Zh7fuUc1gxhQiHEb0=zwLhyj6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 6:28 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [121018 15:20]:
>> On 10/18/2012 03:06 AM, Haojian Zhuang wrote:
>> > Since pins are configured in device driver, pinctrl driver should be
>> > loaded by those device driver. module_platform_driver() only declares
>> > pinctrl driver is in module_initcall privilege. Use postcore_initcall
>> > privilege instead.
>>
>> I'm not convinced this is needed; doesn't deferred probe sort out the
>> dependencies correctly?
>
> I'm a bit concerned about this need too as the trend is towards
> initializing things later than earlier. The drivers/Makefile order
> and deferred probe should be already enough?
>
> Specifically could you decribe the cases where this issue happens?
> Also check if one of your client drivers has some early initcall
> that's no longer needed.
>
> Regards,
>
> Tony

Yes, the special case is PMIC. Most of PMIC are based on I2C/SPI bus.
It means that I2C/SPI bus driver should be initialized firstly. For example,
we could find that PMIC mfd driver are initialized in subsys init call level.
It means that pinctrl should be initialized earlier than I2C/SPI bus driver.
Otherwise, pins of I2C bus may not be configured as I2C function since
pinctrl driver is module init call level.

Regards
Haojian
