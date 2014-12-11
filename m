From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 11 Dec 2014 21:30:04 +0530
Subject: [PATCH 5/9] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <CAAVeFuL+RKOt1b=JiRTiajGq159_W0kJ2KOiiHa7ZwMBwuk3qg@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416487023-25426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CAAVeFuL+RKOt1b=JiRTiajGq159_W0kJ2KOiiHa7ZwMBwuk3qg@mail.gmail.com>
Message-ID: <CAJe_ZhejjL+bgNE401-_MTQYMwZvCjzmLHqqudETzP1Ds-_L+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2014 at 13:03, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Thu, Nov 20, 2014 at 9:37 PM, Vincent Yang
> <vincent.yang.fujitsu@gmail.com> wrote:
>> Driver for Fujitsu MB86S7x SoCs that have a memory mapped GPIO controller.
>>
>> Signed-off-by: Andy Green <andy.green@linaro.org>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
>> ---
>>  .../bindings/gpio/fujitsu,mb86s70-gpio.txt         |  18 ++
>>  drivers/gpio/Kconfig                               |   6 +
>>  drivers/gpio/Makefile                              |   1 +
>>  drivers/gpio/gpio-mb86s7x.c                        | 211 +++++++++++++++++++++
>>  4 files changed, 236 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
>>  create mode 100644 drivers/gpio/gpio-mb86s7x.c
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
>> new file mode 100644
>> index 0000000..38300ee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
>> @@ -0,0 +1,18 @@
>> +Fujitsu MB86S7x GPIO Controller
>> +-------------------------------
>> +
>> +Required properties:
>> +- compatible: Should be "fujitsu,mb86s70-gpio"
>> +- gpio-controller: Marks the device node as a gpio controller.
>> +- #gpio-cells: Should be <2>. The first cell is the pin number and the
>> +  second cell is used to specify optional parameters:
>> +   - bit 0 specifies polarity (0 for normal, 1 for inverted).
>
> According to the example below and the code, "reg" and "clocks" are
> also required properties.
>
OK, will add them as well.

>> +
>> +Examples:
>> +       gpio0: gpio at 31000000 {
>> +               compatible = "fujitsu,mb86s70-gpio";
>> +               reg = <0 0x31000000 0x10000>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +               clocks = <&clk_alw_2_1>;
>
> Maybe add a "clocks-names" property so the clock can be given a meaningful name?
>
Other mb86s7x drivers don't use that either and we do just fine :)

>> +
>> +#define PDR(x) (0x0 + x)
>> +#define DDR(x) (0x10 + x)
>> +#define PFR(x) (0x20 + x)
>
> Everytime these macros are used in the code, they are called in the
> form PFR(offset / 8 * 4). How about doing this operation in the macros
> instead of repeating it at every call?
>
OK

>> +
>> +struct mb86s70_gpio_chip {
>> +       spinlock_t lock;
>> +       struct clk *clk;
>> +       void __iomem *base;
>> +       struct gpio_chip gc;
>> +};
>> +
>> +static int mb86s70_gpio_request(struct gpio_chip *gc, unsigned offset)
>> +{
>> +       struct mb86s70_gpio_chip *gchip = container_of(gc,
>> +                                       struct mb86s70_gpio_chip, gc);
>
> Please have a chip_to_mb86s70() macro to avoid that cumbersome call to
> container_of in every function. Also I suggest you move the gpio_chip
> to the top of your mb86s70_gpio_chip structure so the container_of
> translates to a simple recast without any arithmetic.
>
OK

>> +       unsigned long flags;
>> +       u32 val;
>> +
>> +       spin_lock_irqsave(&gchip->lock, flags);
>> +       val = readl(gchip->base + PFR(offset / 8 * 4));
>
> Same, having mb86s70_readl()/mb86s70_writel() functions would prevent
> you from explicitly doing pointer arithmetic every time you write a
> register.
>
This becomes trivial after updating macros.

>> +       val &= ~(1 << (offset % 8)); /* as gpio-port */
>
> val &= ~BIT(offset % 8); ? Same everywhere it applies.
>
OK

>> +
>> +static int mb86s70_gpio_get(struct gpio_chip *gc, unsigned offset)
>> +{
>> +       struct mb86s70_gpio_chip *gchip =
>> +                       container_of(gc, struct mb86s70_gpio_chip, gc);
>> +       unsigned char val;
>> +
>> +       val = readl(gchip->base + PDR(offset / 8 * 4));
>> +       val &= (1 << (offset % 8));
>> +       return val ? 1 : 0;
>
> Shouldn't this function be protected by the spin lock as well?
>
hmm... then we need to fix most other drivers as well :)

> These minor comments aside, the driver looks nice and simple.

Thanks for the review.
-Jassi
