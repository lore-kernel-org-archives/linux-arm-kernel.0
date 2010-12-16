From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 16 Dec 2010 17:00:01 +0800
Subject: [PATCH 11/16] ARM: mxc: Switch over to gpiolib ->to_irq() and
	__gpio_to_irq().
In-Reply-To: <20101215142232.GC29833@pengutronix.de>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020345.GD15575@mail.wantstofly.org>
	<20101215142232.GC29833@pengutronix.de>
Message-ID: <AANLkTinPBJuhUFRNWzVXZBnqEUY-nsardOM046Ad-pnY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Do I need to pick this up in my v7 of mxs patch-set?

On Wed, Dec 15, 2010 at 10:22 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Lennert,
>
> [added Eric B?nard to Cc]
>
> On Wed, Dec 15, 2010 at 03:03:45AM +0100, Lennert Buytenhek wrote:
>> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
>
> Generally Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> We have some static initializers in the tree though which do not work
> with this patch:
>
> arch/arm/mach-mx3/mach-cpuimx35.c:71: ? ? ? ? ? .irq ? ? ? ? ? ?= gpio_to_irq(TSC2007_IRQGPIO),
> arch/arm/mach-mx5/board-cpuimx51sd.c:139: ? ? ? ? ? ? ? .irq = gpio_to_irq(TSC2007_IRQGPIO),
> arch/arm/mach-mx5/board-cpuimx51sd.c:250: ? ? ? ? ? ? ? .irq = gpio_to_irq(CAN_IRQGPIO)
>
> Sascha
>
>> ---
>> ?arch/arm/plat-mxc/gpio.c ? ? ? ? ? ? ?| ? ?9 +++++++++
>> ?arch/arm/plat-mxc/include/mach/gpio.h | ? ?2 +-
>> ?2 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
>> index 9c3e362..8e97976 100644
>> --- a/arch/arm/plat-mxc/gpio.c
>> +++ b/arch/arm/plat-mxc/gpio.c
>> @@ -272,6 +272,14 @@ static void mxc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>> ? ? ? spin_unlock_irqrestore(&port->lock, flags);
>> ?}
>>
>> +static int mxc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>> +{
>> + ? ? struct mxc_gpio_port *port =
>> + ? ? ? ? ? ? container_of(chip, struct mxc_gpio_port, chip);
>> +
>> + ? ? return port->virtual_irq_start + offset;
>> +}
>> +
>> ?static int mxc_gpio_get(struct gpio_chip *chip, unsigned offset)
>> ?{
>> ? ? ? struct mxc_gpio_port *port =
>> @@ -320,6 +328,7 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
>> ? ? ? ? ? ? ? port[i].chip.direction_output = mxc_gpio_direction_output;
>> ? ? ? ? ? ? ? port[i].chip.get = mxc_gpio_get;
>> ? ? ? ? ? ? ? port[i].chip.set = mxc_gpio_set;
>> + ? ? ? ? ? ? port[i].chip.to_irq = mxc_gpio_to_irq;
>> ? ? ? ? ? ? ? port[i].chip.base = i * 32;
>> ? ? ? ? ? ? ? port[i].chip.ngpio = 32;
>>
>> diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
>> index af33b74..9062fe3 100644
>> --- a/arch/arm/plat-mxc/include/mach/gpio.h
>> +++ b/arch/arm/plat-mxc/include/mach/gpio.h
>> @@ -27,8 +27,8 @@
>> ?#define gpio_get_value ? ? ? ? ? ? ? __gpio_get_value
>> ?#define gpio_set_value ? ? ? ? ? ? ? __gpio_set_value
>> ?#define gpio_cansleep ? ? ? ? ? ? ? ?__gpio_cansleep
>> +#define gpio_to_irq ? ? ? ? ?__gpio_to_irq
>>
>> -#define gpio_to_irq(gpio) ? ?(MXC_GPIO_IRQ_START + (gpio))
>> ?#define irq_to_gpio(irq) ? ? ((irq) - MXC_GPIO_IRQ_START)
>>
>> ?struct mxc_gpio_port {
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Regards,
Shawn
