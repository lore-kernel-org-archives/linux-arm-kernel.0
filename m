From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 15 Nov 2009 20:46:25 -0500
Subject: [PATCH 10/10] regulator: refresh 88pm8607 driver with updated api
In-Reply-To: <1258109903.3586.9.camel@odin>
References: <771cded00911130106t64b72ffdn1911dc2940cee7e2@mail.gmail.com>
	<1258109903.3586.9.camel@odin>
Message-ID: <771cded00911151746n29ba3506s99dc4159c3db5c95@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 5:58 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Fri, 2009-11-13 at 04:06 -0500, Haojian Zhuang wrote:
>> >From 8fb032bd84d98409e78700bd1427d9506a44c602 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Mon, 9 Nov 2009 12:48:23 -0500
>> Subject: [PATCH] regulator: refresh 88pm8607 driver with updated api
>>
>> Since i2c API of mfd 88pm860x driver is changed, refresh 88pm8607 driver.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?drivers/regulator/88pm8607.c | ? 34 ++++++++++++++++++----------------
>> ?drivers/regulator/Kconfig ? ?| ? ?2 +-
>> ?2 files changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
>> index 0471955..aad829f 100644
>> --- a/drivers/regulator/88pm8607.c
>> +++ b/drivers/regulator/88pm8607.c
>> ? ? ? case PM8607_ID_BUCK1:
>> ? ? ? case PM8607_ID_BUCK3:
>> - ? ? ? ? ? ? ret = pm8607_set_bits(chip, info->update_reg,
>> + ? ? ? ? ? ? ret = pm860x_set_bits(chip->parent, DESC_8607,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? info->update_reg,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 1 << info->update_bit,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 1 << info->update_bit);
>
>
> Would it not be better if the chip struct contained the chip type. This
> would save you having to pass in this extra DESC_8607 parameter and imho
> looks neater.
>
>
> Liam
>
Em. It still can't cover all the cases. For example, USB charger
device driver needs to access both registers of 88pm8606 and 88pm8607.
I use the descriptor as parameter at here, since I want to access both
8606 and 8607 registers in one driver even the device is only mounted
on 88pm8606.

And there's some similar situation on other PMIC chips. I remember
that there're three I2C slave address and two IRQ lines on MAX8925.
Some device driver also needs to access these multiple I2C addresses,
but it should only be mounted on one I2C device.

So I prefer to use descriptor as parameter in these APIs.

Best Regards
Haojian
