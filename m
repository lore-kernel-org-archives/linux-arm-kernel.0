From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 19 May 2015 16:48:23 +0200
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <20150518184300.GB28888@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150518184300.GB28888@pengutronix.de>
Message-ID: <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-18 20:43 GMT+02:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
>> From: Xudong Chen <xudong.chen@mediatek.com>
>>
>> The mediatek SoCs have I2C controller that handle I2C transfer.
>> This patch include common I2C bus driver.
>> This driver is compatible with I2C controller on mt65xx/mt81xx.
>>
>> Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
>> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  drivers/i2c/busses/Kconfig      |   9 +
>>  drivers/i2c/busses/Makefile     |   1 +
>>  drivers/i2c/busses/i2c-mt65xx.c | 675 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 685 insertions(+)
>>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 2255af2..14c7266 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -620,6 +620,15 @@ config I2C_MPC
>>         This driver can also be built as a module.  If so, the module
>>         will be called i2c-mpc.
>>
>> +config I2C_MT65XX
>> +     tristate "MediaTek I2C adapter"
>> +     depends on ARCH_MEDIATEK || COMPILE_TEST
>> +     help
>> +       This selects the MediaTek(R) Integrated Inter Circuit bus driver
>> +       for MT65xx and MT81xx.
>> +       If you want to use MediaTek(R) I2C interface, say Y or M here.
>> +       If unsure, say N.
>> +
>>  config I2C_MV64XXX
>>       tristate "Marvell mv64xxx I2C Controller"
>>       depends on MV64X60 || PLAT_ORION || ARCH_SUNXI
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index cdf941d..abbf422 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -60,6 +60,7 @@ obj-$(CONFIG_I2C_JZ4780)    += i2c-jz4780.o
>>  obj-$(CONFIG_I2C_KEMPLD)     += i2c-kempld.o
>>  obj-$(CONFIG_I2C_MESON)              += i2c-meson.o
>>  obj-$(CONFIG_I2C_MPC)                += i2c-mpc.o
>> +obj-$(CONFIG_I2C_MT65XX)     += i2c-mt65xx.o
>>  obj-$(CONFIG_I2C_MV64XXX)    += i2c-mv64xxx.o
>>  obj-$(CONFIG_I2C_MXS)                += i2c-mxs.o
>>  obj-$(CONFIG_I2C_NOMADIK)    += i2c-nomadik.o
>> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
>> new file mode 100644
>> index 0000000..7462f05
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-mt65xx.c
>> @@ -0,0 +1,675 @@
>> +/*
>> + * Copyright (c) 2014 MediaTek Inc.
>> + * Author: Xudong.chen <xudong.chen@mediatek.com>
> s/Xudong.chen/Xudong Chen/
>
>> +#define I2C_DRV_NAME         "mt-i2c"
> i2c-mt65xx ?

As this works for all SoCs so far, I would propose: i2c-mtk

-- 
motzblog.wordpress.com
