From: david@lechnology.com (David Lechner)
Date: Mon, 25 Jun 2018 11:29:27 -0500
Subject: [PATCH 6/9] ARM: davinci: da830-evm: use aemif platform driver
In-Reply-To: <CAMpxmJXtH9ibXS55iP-aFGTgd19hSafZdb+hFhPyA8u9arOSfg@mail.gmail.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-7-brgl@bgdev.pl>
 <0e4bc2fb-15fc-6422-a4a3-0918adf0b1b3@lechnology.com>
 <CAMpxmJXtH9ibXS55iP-aFGTgd19hSafZdb+hFhPyA8u9arOSfg@mail.gmail.com>
Message-ID: <ac232c64-0efb-fd0a-740f-8d63178cdf95@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2018 11:23 AM, Bartosz Golaszewski wrote:
> 2018-06-25 18:20 GMT+02:00 David Lechner <david@lechnology.com>:
>> On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> We now support board files in the aemif driver. Register a platform
>>> device instead of using the handcrafted API in da830-evm.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>    arch/arm/mach-davinci/board-da830-evm.c | 56 +++++++++++++++++++------
>>>    1 file changed, 44 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/board-da830-evm.c
>>> b/arch/arm/mach-davinci/board-da830-evm.c
>>> index b2470141dba3..666db3cee08a 100644
>>> --- a/arch/arm/mach-davinci/board-da830-evm.c
>>> +++ b/arch/arm/mach-davinci/board-da830-evm.c
>>> @@ -28,6 +28,7 @@
>>>    #include <linux/platform_data/mtd-davinci-aemif.h>
>>>    #include <linux/platform_data/spi-davinci.h>
>>>    #include <linux/platform_data/usb-davinci.h>
>>> +#include <linux/platform_data/ti-aemif.h>
>>>    #include <linux/regulator/machine.h>
>>>      #include <asm/mach-types.h>
>>> @@ -333,14 +334,48 @@ static struct resource da830_evm_nand_resources[] =
>>> {
>>>          },
>>>    };
>>>    -static struct platform_device da830_evm_nand_device = {
>>> -       .name           = "davinci_nand",
>>> -       .id             = 1,
>>> -       .dev            = {
>>> -               .platform_data  = &da830_evm_nand_pdata,
>>> +static struct platform_device da830_evm_aemif_devices[] = {
>>> +       {
>>> +               .name           = "davinci_nand",
>>> +               .id             = 1,
>>
>>
>> Actually, now that I've thought about it some more. It probably
>> makes more sense to make all of the "davinci_nand" devices in this
>> series use id = -1 since there is only one per board. It looks like
>> da850 is the only one that has a lookup for "davinic_nand.0" already.
>>
>> I think that we are going to have to add clock lookups for the
>> "davinci_nand" devices as well. Although the driver doesn't do
>> clk_get() explicitly, I think some function it calls does get a
>> clock. I remember that we had to add a clock-ranges property to
>> device tree to get the davinci_nand driver working, which is why
>> I think we are going to need a clock lookup for these devices
>> as well.
>>
> 
> Seems like ever since commit a8e3923ab571 ("mtd: rawnand: davinci:
> don't acquire and enable clock") we no longer need to worry about the
> clock entries for nand.
> 
> Thanks,
> Bart
> 

Sounds good. If you end up touching the da850 clock lookups, you can
probably drop the "davinci_nand.0" entry there.
