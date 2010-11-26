From: charu@ti.com (Varadarajan, Charulatha)
Date: Fri, 26 Nov 2010 10:33:33 +0530
Subject: [PATCH v7 01/11] OMAP: GPIO: prepare for platform driver
In-Reply-To: <20101126043829.GB6598@lixom.net>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<1290524213-395-2-git-send-email-charu@ti.com>
	<20101126043829.GB6598@lixom.net>
Message-ID: <AANLkTi=9RpAw4gi92M_7JLkS+VHPUp_YPdwRRin0u8Jx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson,

On Fri, Nov 26, 2010 at 10:08, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Tue, Nov 23, 2010 at 08:26:43PM +0530, Varadarajan, Charulatha wrote:
>> +static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>> +{
>> + ? ? if (cpu_class_is_omap2()) {
>
> Why check class when you're checking for all possible variants anyway?

This is only a movement of code as I mentioned in the patch description
and I am not trying to modify anything newly. All these would be removed while
doing GPIO driver cleanup (please see below).

>
>> + ? ? ? ? ? ? if (cpu_is_omap44xx()) {
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(0xffffffff, bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP4_GPIO_IRQSTATUSCLR0);
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(0x00000000, bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP4_GPIO_DEBOUNCENABLE);
>> + ? ? ? ? ? ? ? ? ? ? /* Initialize interface clk ungated, module enabled */
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
>> + ? ? ? ? ? ? } else if (cpu_is_omap34xx()) {
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(0x00000000, bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP24XX_GPIO_IRQENABLE1);
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(0xffffffff, bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP24XX_GPIO_IRQSTATUS1);
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(0x00000000, bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP24XX_GPIO_DEBOUNCE_EN);
>> +
>> + ? ? ? ? ? ? ? ? ? ? /* Initialize interface clk ungated, module enabled */
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
>> + ? ? ? ? ? ? } else if (cpu_is_omap24xx()) {
>> + ? ? ? ? ? ? ? ? ? ? static const u32 non_wakeup_gpios[] = {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0xe203ffc0, 0x08700040
>> + ? ? ? ? ? ? ? ? ? ? };
>> + ? ? ? ? ? ? ? ? ? ? if (id < ARRAY_SIZE(non_wakeup_gpios))
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->non_wakeup_gpios = non_wakeup_gpios[id];
>> + ? ? ? ? ? ? }
>> + ? ? } else if (cpu_class_is_omap1()) {
>> + ? ? ? ? ? ? if (bank_is_mpuio(bank))
>> + ? ? ? ? ? ? ? ? ? ? __raw_writew(0xffff, bank->base
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP_MPUIO_GPIO_MASKIT);
>
> Above is using else if, this is using if. I don't see how you can ever
> hit more than one of these anyway.
>
> Besides, why check for both cpu and method? When do they ever
> diverge? (same goes for other places)
>
> The plat-omap/gpio.c driver is pretty hard to read because of all the
> ifdeffing and tests for platforms. It would make sense to abstract out
> some of the operations into separate functions and use function pointers
> for them, IMHO. (Not an issue for this patch, just a reflection).

Yes. I also wondered why to have cpu_is checks, methods and #ifdefs and
it is quite confusing too.

This patch series is intended only for platform driver implementation of hwmod
and mainly using hwmod for OMAP2+. If I include cleaning up of GPIO driver
also in this patch series, it would become too huge. This was discussed long ago
and it was agreed to have GPIO driver cleanup as a separate series.
Hence this is
mentioned in the TODOs (please see patch 10 description for the list of TODOs as
that is main patch where the actual platform driver implementation is
being done for
GPIO)

Thanks.
