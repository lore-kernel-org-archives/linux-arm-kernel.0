From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 20 May 2015 16:54:43 +0800
Subject: [PATCH v3] pinctrl: sirf: add sirf atlas7 pinctrl and gpio support
In-Reply-To: <CACRpkdYT8bti=8iRPs_21r15vB8XWMbUXCpkfScg_J+=werwdw@mail.gmail.com>
References: <1431934112-16132-1-git-send-email-21cnbao@gmail.com>
 <CACRpkdYT8bti=8iRPs_21r15vB8XWMbUXCpkfScg_J+=werwdw@mail.gmail.com>
Message-ID: <CAGsJ_4wSnJA+2B5_tbBJ3akwbBwiCjD+v3SXqyv-Cu7kkg0KSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-19 21:59 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, May 18, 2015 at 9:28 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Wei Chen <Wei.Chen@csr.com>
>>
>> The Pinctrl module (ioc) controls the Pad's function select
>> (each pad can have 8 functions), Pad's Drive Strength, Pad's
>> Pull Select and Pad's Input Disable status.
>>
>> The ioc has two modules, ioc_top & ioc_rtc. Both of these two
>> modules have function select/clear, Pull select and Drive
>> Strength registers. But only ioc_rtc has input-disable
>> registers. The Pads on ioc_top have to access ioc_rtc to set
>> their input-disable status and intpu-disable-value.
>>
>> So have to use one ioc driver instance to drive these two
>> ioc modules at the same time, and each ioc module will be
>> treat as one bank on the "IOC Device".
>>
>> The GPIO Controller controls the GPIO status if the Pad has
>> been config as GPIO by Pinctrl already. Includes the GPIO
>> Input/output, Interrupt type, Interrupt Status, and Set/Get
>> Values.
>> The GPIO pull up/down are controlled by Pinctrl.
>>
>> There are 7 GPIO Groups and splited into 3 MACROs in atlas7.
>> The GPIO Groups in one MACRO share one GPIO controllers, each
>> GPIO Group are treated as one GPIO bank.
>>
>> For example:
>> In VDIFM macro, there is one GPIO Controller, it has 3 banks
>> to control 3 gpio groups. Its gpio name space is from 0 to 95.
>>
>> The Device Tree can be written as following:
>>
>> gpio-ranges = <&pinctrl 0 0 0>,
>> <&pinctrl 32 0 0>,
>> <&pinctrl 64 0 0>;
>>
>> gpio-ranges-group-names = "gnss_gpio_grp",
>> "lcd_vip_gpio_grp",
>> "sdio_i2s_gpio_grp";
>>
>> bank#0 is from 0~31, the pins are from pinctrl's "gnss_gpio_grp".
>> bank#2 is from 32~63, the pins are from pinctrl's "lcd_vip_gpio_grp".
>> bank#3 is from 64~95, the pins are from pinctrl's "sdio_i2s_gpio_grp".
>>
>> Signed-off-by: Wei Chen <Wei.Chen@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -v3: use generic pinconf to replace self-defined APIs
>
> Awesome job Barry, well done.
>

thanks, Linus, for your hard review and good suggestions to improve
the codes. it is mainly a job of Chen Wei. i am only a s-o-b :-)

> Patch applied!

i sent the dts stuff just now.

>
> Yours,
> Linus Walleij

-barry
