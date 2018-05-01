From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 17:06:37 +0530
Subject: [PATCH 3/4] ARM: davinci: fix GPIO lookup for I2C
In-Reply-To: <2a6e2e81-05f9-1759-c921-3891adcfb854@lechnology.com>
References: <20180424143506.25793-1-nsekhar@ti.com>
 <20180424143506.25793-4-nsekhar@ti.com>
 <2a6e2e81-05f9-1759-c921-3891adcfb854@lechnology.com>
Message-ID: <6e63c820-efae-c94e-fab6-52980ee978f2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 07:13 AM, David Lechner wrote:
> On 04/24/2018 09:35 AM, Sekhar Nori wrote:
>> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
>> I2C can correctly lookup the recovery gpios.
>>
>> Note that it is the gpio-davinci driver that sets the gpiochip label to
>> davinci_gpio.0.
>>
>> Also, the I2C device uses an id of 1 on DM644x and DM355.
>>
>> Fixes: e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C
>> recovery")
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> ? arch/arm/mach-davinci/board-dm355-evm.c? | 6 +++---
>> ? arch/arm/mach-davinci/board-dm644x-evm.c | 6 +++---
>> ? 2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c
>> b/arch/arm/mach-davinci/board-dm355-evm.c
>> index cb30637d9eaf..14557f893798 100644
>> --- a/arch/arm/mach-davinci/board-dm355-evm.c
>> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
>> @@ -110,11 +110,11 @@ static struct platform_device
>> davinci_nand_device = {
>> ? };
>> ? ? static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
>> -??? .dev_id = "i2c_davinci",
>> +??? .dev_id = "i2c_davinci.1",
>> ????? .table = {
>> -??????? GPIO_LOOKUP("davinci_gpio", 15, "sda",
>> +??????? GPIO_LOOKUP("davinci_gpio.0", 15, "sda",
>> ????????????????? GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>> -??????? GPIO_LOOKUP("davinci_gpio", 14, "scl",
>> +??????? GPIO_LOOKUP("davinci_gpio.0", 14, "scl",
>> ????????????????? GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>> ????? },
>> ? };
>> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
>> b/arch/arm/mach-davinci/board-dm644x-evm.c
>> index 5bf024784738..5b0b95e04cac 100644
>> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
>> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
>> @@ -597,11 +597,11 @@ static struct i2c_board_info __initdata
>> i2c_info[] =? {
>> ? };
>> ? ? static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
>> -??? .dev_id = "i2c_davinci",
>> +??? .dev_id = "i2c_davinci.1",
>> ????? .table = {
>> -??????? GPIO_LOOKUP("davinci_gpio", 44, "sda",
>> +??????? GPIO_LOOKUP("davinci_gpio.0", 44, "sda",
>> ????????????????? GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>> -??????? GPIO_LOOKUP("davinci_gpio", 43, "scl",
>> +??????? GPIO_LOOKUP("davinci_gpio.0", 43, "scl",
>> ????????????????? GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
>> ????? },
>> ? };
>>
> 
> Why not use the GPIO_TO_PIN() macro like the previous patches?

I was just following the existing style. But, yes, I can fix that up.

Thanks,,
Sekhar
