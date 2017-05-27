From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat, 27 May 2017 11:08:29 +0800
Subject: [PATCH 2/6] mfd: hi6421-pmic: move hi6421_regmap_config
 definition to header file
In-Reply-To: <CAK8P3a0maxQdwLMMwEnYgmMHRHDRUaeYRb5JM0PtRbWopeHjUw@mail.gmail.com>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
 <20170526063518.21246-3-guodong.xu@linaro.org>
 <CAK8P3a0maxQdwLMMwEnYgmMHRHDRUaeYRb5JM0PtRbWopeHjUw@mail.gmail.com>
Message-ID: <CAFGCpxxiwevKqJ19v7fFe6SA9HUbDsdoiL3nOKrkRLmg2=U2xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 4:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, May 26, 2017 at 8:35 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
>> Move hi6421_regmap_config definition from c code to common header:
>>  - include/linux/mfd/hi6421-pmic.h
>>
>> This is to improve code re-use for upcoming hi6421 series of MFD driver.
>>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>
>> diff --git a/include/linux/mfd/hi6421-pmic.h b/include/linux/mfd/hi6421-pmic.h
>> index 587273e..f4674ff 100644
>> --- a/include/linux/mfd/hi6421-pmic.h
>> +++ b/include/linux/mfd/hi6421-pmic.h
>> @@ -38,4 +38,10 @@ struct hi6421_pmic {
>>         struct regmap           *regmap;
>>  };
>>
>> +static const struct regmap_config hi6421_regmap_config = {
>> +       .reg_bits = 32,
>> +       .reg_stride = 4,
>> +       .val_bits = 8,
>> +       .max_register = HI6421_REG_TO_BUS_ADDR(HI6421_REG_MAX),
>> +};
>>  #endif         /* __HI6421_PMIC_H */
>
> Header files should not have static variables in general, it will cause warnings
> about unused variables when you include the header from another file
> (depending on compiler version and warning options, I think older gcc
> versions don't warn about this, but clang and latest gcc do).
>

I will fix that.

> How about adding the new code into the existing
> drivers/mfd/hi6421-pmic-core.c file, and splitting out the part that differs
> (the regmap_update_bits is the only difference I see)

Yes, indeed.

> into a callback
> that you reference through the of_device_id->data pointer?
>

Thanks Arnd. I will look into this. I'll drop hi6421v530-pmic.c and
resend this patchset.

-Guodong

>         Arnd
