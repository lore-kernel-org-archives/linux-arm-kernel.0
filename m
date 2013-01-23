From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Wed, 23 Jan 2013 12:28:30 +0100
Subject: [PATCH] [ARM] spitz/pxa: Refactor i2c init code in spitz.c
In-Reply-To: <CAN1soZy4zXmZKUK0CAi-DndYvZhJqeJTkP1rfpti=v8Ns=HNVg@mail.gmail.com>
References: <1355257645-27888-1-git-send-email-dromede@gmail.com>
 <CAN1soZy4zXmZKUK0CAi-DndYvZhJqeJTkP1rfpti=v8Ns=HNVg@mail.gmail.com>
Message-ID: <CAHod+GcZEhRhh+ULHGZjDf6-bqn4UtfeM2oa55Z_4kpoHRqdQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 10:00 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Wed, Dec 12, 2012 at 4:27 AM,  <dromede@gmail.com> wrote:
>> From: Marko Katic <dromede.gmail.com>
>>
>> This patch changes the way i2c devices are defined
>> and registered.
>>
>> I2c devices that are present in all spitz
>> variants are always defined and registered while the max7310
>> gpio expander specific to the akita variant is defined
>> and registered only when building the kernel for akita variants.
>>
>> spitz_i2c_init() is simplified and is now more readable.
>>
>> Signed-off-by: Marko Katic <dromede@gmail.com>
>> ---
>>  arch/arm/mach-pxa/spitz.c |   38 ++++++++++++++++++--------------------
>>  1 file changed, 18 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
>> index 0cc9dc7..1c7dc2b 100644
>> --- a/arch/arm/mach-pxa/spitz.c
>> +++ b/arch/arm/mach-pxa/spitz.c
>> @@ -865,17 +865,6 @@ static struct pca953x_platform_data akita_pca953x_pdata = {
>>         .gpio_base              = AKITA_IOEXP_GPIO_BASE,
>>  };
>>
>> -static struct i2c_board_info spitz_i2c_devs[] = {
>> -       {
>> -               .type           = "wm8750",
>> -               .addr           = 0x1b,
>> -       }, {
>> -               .type           = "max7310",
>> -               .addr           = 0x18,
>> -               .platform_data  = &akita_pca953x_pdata,
>> -       },
>> -};
>> -
>>  static struct regulator_consumer_supply isl6271a_consumers[] = {
>>         REGULATOR_SUPPLY("vcc_core", NULL),
>>  };
>> @@ -894,26 +883,35 @@ static struct regulator_init_data isl6271a_info[] = {
>>         }
>>  };
>>
>> -static struct i2c_board_info spitz_pi2c_devs[] = {
>> +static struct i2c_board_info spitz_i2c_devs[2] = {
>>         {
>> +               .type           = "wm8750",
>> +               .addr           = 0x1b,
>> +       }, {
>>                 .type           = "isl6271a",
>>                 .addr           = 0x0c,
>>                 .platform_data  = &isl6271a_info,
>>         },
>>  };
>>
> spitz_i2c_devs[] are in i2c0 bus. spitz_pi2c_devs[] are in i2c1 bus.
> Why do you move wm8750 from i2c0 bus to i2c1 bus?

Only the isl6271a is located on the i2c1 bus. WM8750 and MAX7310 are
on i2c0 bus.
Please examine my patch again. You will find that WM8750 is correctly
registered on
i2c0 bus with this line:

 i2c_register_board_info(0, &spitz_i2c_devs[0], 1);
