From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 19 Oct 2012 10:53:07 +0800
Subject: [PATCH 01/10] pinctrl: use postcore_initcall
In-Reply-To: <20121019023818.GO30550@atomide.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <5080802B.3000209@wwwdotorg.org>
 <20121018222802.GG30550@atomide.com>
 <CAN1soZy17wO2s7WoRSRod8k5Zh7fuUc1gxhQiHEb0=zwLhyj6A@mail.gmail.com>
 <20121019023818.GO30550@atomide.com>
Message-ID: <CAN1soZw+EzFjEcxDJfi50BEhuQqDUwsB4DMGEXg+oyU-6gO_Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 10:38 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@gmail.com> [121018 19:17]:
>> On Fri, Oct 19, 2012 at 6:28 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > Specifically could you decribe the cases where this issue happens?
>> > Also check if one of your client drivers has some early initcall
>> > that's no longer needed.
>>
>> Yes, the special case is PMIC. Most of PMIC are based on I2C/SPI bus.
>> It means that I2C/SPI bus driver should be initialized firstly. For example,
>> we could find that PMIC mfd driver are initialized in subsys init call level.
>> It means that pinctrl should be initialized earlier than I2C/SPI bus driver.
>> Otherwise, pins of I2C bus may not be configured as I2C function since
>> pinctrl driver is module init call level.
>
> Hmm, the order in drivers/Makefile is already:
>
> pinctrl/
> i2c/
>
> Maybe check that your i2c drivers don't have non-standard initcalls?
>
> Also the i2c drivers may need to return -EPROBE_DEFER?
>
> Regards,
>
> Tony

OK. I'll support -EPROBE_DEFER if failed to get pin from pinctrl system.
This solution could also resolve the issue.

Regards
Haojian
