From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 27 Nov 2014 19:49:00 +0900
Subject: [01/19] pinctrl: exynos: Add support for Exynos5433
In-Reply-To: <5476FC4E.7030505@samsung.com>
References: <1417073716-22997-2-git-send-email-cw00.choi@samsung.com>
 <5476FC4E.7030505@samsung.com>
Message-ID: <5477019C.50101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 11/27/2014 07:26 PM, Pankaj Dubey wrote:
> Hi Chanwoo,
> 
> On Thursday 27 November 2014 01:04 PM, Chanwoo Choi wrote:
>> This patch adds driver data for Exynos5433 SoC. Exynos5433 includes 228 multi-
>> functional input/output port pins and 135 memory port pins. There are 41 general
>> port groups and 2 memory port groups.
>>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Thomas Abraham <thomas.abraham@linaro.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
>> Acked-by: Inki Dae <inki.dae@samsung.com>
>>
>> ---
>> drivers/pinctrl/samsung/pinctrl-exynos.c  | 163 ++++++++++++++++++++++++++++++
>>   drivers/pinctrl/samsung/pinctrl-samsung.c |   2 +
>>   drivers/pinctrl/samsung/pinctrl-samsung.h |   1 +
>>   3 files changed, 166 insertions(+)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> index 8e3e0c0..bd4c4ec 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> @@ -1268,6 +1268,169 @@ struct samsung_pin_ctrl exynos5420_pin_ctrl[] = {
>>       },
>>   };
>>
>> +/* pin banks of exynos5433 pin-controller - ALIVE */
>> +static struct samsung_pin_bank exynos5433_pin_banks0[] = {
>> +    EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
>> +    EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
>> +    EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
>> +    EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - AUD */
>> +static struct samsung_pin_bank exynos5433_pin_banks1[] = {
>> +    EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
>> +    EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - CPIF */
>> +static struct samsung_pin_bank exynos5433_pin_banks2[] = {
>> +    EXYNOS_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - eSE */
>> +static struct samsung_pin_bank exynos5433_pin_banks3[] = {
>> +    EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - FINGER */
>> +static struct samsung_pin_bank exynos5433_pin_banks4[] = {
>> +    EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - FSYS */
>> +static struct samsung_pin_bank exynos5433_pin_banks5[] = {
>> +    EXYNOS_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
>> +    EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
>> +    EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
>> +    EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
>> +    EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
>> +    EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - IMEM */
>> +static struct samsung_pin_bank exynos5433_pin_banks6[] = {
>> +    EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
> 
> Is this complete?

Exynos5433 has gpf1~gpf5. But, This patch did not include gpf1~gpf5.
because gpf1~gpf5 of Exynos5433 has different offset of EINT register.

gpf1~gpf5 is included in IMEM (0x11090000) part But,EINT register of gpf1~gpf5
is included in ALIVE (0x10580000) part. So, I'll consider how to support
gpf1~gpf5 gpios.

> 
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - NFC */
>> +static struct samsung_pin_bank exynos5433_pin_banks7[] = {
>> +    EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - PERIC */
>> +static struct samsung_pin_bank exynos5433_pin_banks8[] = {
>> +    EXYNOS_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
>> +    EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
>> +    EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
>> +    EXYNOS_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
>> +    EXYNOS_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
>> +    EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
>> +    EXYNOS_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
>> +    EXYNOS_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
>> +    EXYNOS_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
>> +    EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
>> +    EXYNOS_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
>> +    EXYNOS_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
>> +    EXYNOS_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
>> +    EXYNOS_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
>> +    EXYNOS_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
>> +    EXYNOS_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
>> +    EXYNOS_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
>> +};
>> +
>> +/* pin banks of exynos5433 pin-controller - TOUCH */
>> +static struct samsung_pin_bank exynos5433_pin_banks9[] = {
>> +    EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
>> +};
>> +
>> +/*
>> + * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
>> + * four gpio/pin-mux/pinconfig controllers.
> 
> four? I can see you added 10.

You're right. I'll fix it.

Best Regards,
Chanwoo Choi
