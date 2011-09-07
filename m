From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Sep 2011 10:11:42 +0200
Subject: [PATCH] gpio: rewrite U300 GPIO to use gpiolib
In-Reply-To: <87vct65782.fsf@lebrac.rtp-net.org>
References: <1315297950-12720-1-git-send-email-linus.walleij@stericsson.com>
	<87vct65782.fsf@lebrac.rtp-net.org>
Message-ID: <CACRpkdZx+7cEq+xRFWsFuoVCUDWauyAZbZohypNVzCTTFV6tog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2011 at 11:51 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> [Me]
>> -#ifdef U300_COH901571_3
>> +#if defined(CONFIG_MACH_U300_BS365) || defined(CONFIG_MACH_U300_BS335)
>> ? ? ? {
>> ? ? ? ? ? ? ? .name ?= "gpio3",
>> ? ? ? ? ? ? ? .start = IRQ_U300_GPIO_PORT3,
>> @@ -236,6 +237,7 @@ static struct resource gpio_resources[] = {
>> ? ? ? ? ? ? ? .end ? = IRQ_U300_GPIO_PORT4,
>> ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
>> ? ? ? },
>> +#endif
>
> hmm.. silly question: Now that u300 gpios can/will be added through
> gpiochip_add, is it still required to used #ifdef instead of
> machine_is_foo() or use some different platform devices for that like it
> was done on mxc ?

Yes unfortunately all of these systems share a single
MACHINE_TYPE. I will surely try to fix that and maybe
just delete unsupported old hardware, or try to make this
dynamically decided from the platform atleast.

As far as I can tell this patch does not make the situation
worse atleast :-/

>> +struct u300_gpio {
>> + ? ? struct gpio_chip chip;
>> + ? ? struct list_head port_list;
>> + ? ? struct clk *clk;
>> + ? ? struct resource *memres;
>> + ? ? void __iomem *base;
>> + ? ? struct device *dev;
>> + ? ? int irq_base;
>> + ? ? int users;
>> + ? ? u32 stride;
>> + ? ? /* Register offsets */
>> + ? ? u32 pcr;
>> + ? ? u32 dor;
>> + ? ? u32 dir;
>> + ? ? u32 per;
>> + ? ? u32 icr;
>> + ? ? u32 ien;
>> + ? ? u32 iev;
>> +};
>
> Do you really need all theses ? I'm thinking of the 'users' field but
> there are maybe others ?

You're absolutley right about users, I've deleted it.

The rest are needed I think.

The stride+register offsets are needed to handle different
HW variants at runtime, for example.

>> ?/* Initial configuration */
>> -const struct u300_gpio_configuration_data
>> -u300_gpio_config[U300_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
>> -#ifdef CONFIG_MACH_U300_BS335
>> +static struct __initdata u300_gpio_confdata
>> +bs335_gpio_config[BS335_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
>
> looks like const has been lost ?

You're right, fixed it up by re-constifying and adding a few
alterations here and there to handle the const * pointers.

Thanks a lot Arnaud!
Linus Walleij
