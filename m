From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 26 May 2011 15:06:47 +0530
Subject: [PATCH 12/15] OMAP: GPIO: Fix: use wake set/clear regs
In-Reply-To: <87zkmal6f5.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-13-git-send-email-tarun.kanti@ti.com>
	<87zkmal6f5.fsf@ti.com>
Message-ID: <BANLkTikbUDJ1MY+eGODZm2QM-_GM1v2X6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 04:44, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> In set_24xx_gpio_triggering(), for OMAP4, GPIO wakeup request
>> is set for all type of GPIO triggers whereas as per TRM the GPIO
>> wakeup request can only be generated on edge transitions. Fix this.
>
> OK. ?Please make a dedicated patch for this part.

Okay.

>
> Subject: GPIO: OMAP: IRQ triggering: use wake set/clear regs

Okay.

>
>> In set_24xx_gpio_triggering(), OMAP4_GPIO_IRQWAKEN0 register
>> is used for wakeup request and the GPIO set/clear wakeup registers
>> are not used in OMAP4 but is handled without retaining it's old
>> value. This would corrupt the contents of OMAP4_GPIO_IRQWAKEN0
>> register by writing the value of the last requested GPIO pin in
>> a given bank. This can be avoided by making use of GPIO set/clear
>> wakeup registers.
>
> And this should be a separate patch too, or probably folded into PATCH
> 09/15 with an updated changelog of course.

Okay.

>
> Kevin
>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> ---
>> ?arch/arm/mach-omap2/gpio.c | ? ?4 ++--
>> ?drivers/gpio/gpio_omap.c ? | ? 32 ++++++++++----------------------
>> ?2 files changed, 12 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 5c888dd..fbedbbb 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -142,8 +142,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>> ? ? ? ? ? ? ? pdata->regs->risingdetect = OMAP4_GPIO_RISINGDETECT;
>> ? ? ? ? ? ? ? pdata->regs->fallingdetect = OMAP4_GPIO_FALLINGDETECT;
>> ? ? ? ? ? ? ? pdata->regs->wkupstatus = OMAP4_GPIO_IRQWAKEN0;
>> - ? ? ? ? ? ? pdata->regs->wkupclear = OMAP4_GPIO_IRQWAKEN0;
>> - ? ? ? ? ? ? pdata->regs->wkupset = OMAP4_GPIO_IRQWAKEN0;
>> + ? ? ? ? ? ? pdata->regs->wkupclear = OMAP4_GPIO_CLEARWKUENA;
>> + ? ? ? ? ? ? pdata->regs->wkupset = OMAP4_GPIO_SETWKUENA;
>> ? ? ? ? ? ? ? break;
>> ? ? ? default:
>> ? ? ? ? ? ? ? WARN(1, "Invalid gpio bank_type\n");
>> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
>> index 05c2857..762d73c 100644
>> --- a/drivers/gpio/gpio_omap.c
>> +++ b/drivers/gpio/gpio_omap.c
>> @@ -229,30 +229,18 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>> ? ? ? ? ? ? ? MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
>> ? ? ? ? ? ? ? ? ? ? ? trigger & IRQ_TYPE_EDGE_FALLING);
>> ? ? ? }
>> +
>> ? ? ? if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>> - ? ? ? ? ? ? if (cpu_is_omap44xx()) {
>> - ? ? ? ? ? ? ? ? ? ? if (trigger != 0)
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? __raw_writel(1 << gpio, bank->base+
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP4_GPIO_IRQWAKEN0);
>> - ? ? ? ? ? ? ? ? ? ? else {
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? val = __raw_readl(bank->base +
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP4_GPIO_IRQWAKEN0);
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? __raw_writel(val & (~(1 << gpio)), bank->base +
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP4_GPIO_IRQWAKEN0);
>> - ? ? ? ? ? ? ? ? ? ? }
>> - ? ? ? ? ? ? } else {
>> - ? ? ? ? ? ? ? ? ? ? /*
>> - ? ? ? ? ? ? ? ? ? ? ?* GPIO wakeup request can only be generated on edge
>> - ? ? ? ? ? ? ? ? ? ? ?* transitions
>> - ? ? ? ? ? ? ? ? ? ? ?*/
>> - ? ? ? ? ? ? ? ? ? ? if (trigger & IRQ_TYPE_EDGE_BOTH)
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? __raw_writel(1 << gpio, bank->base
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP24XX_GPIO_SETWKUENA);
>> - ? ? ? ? ? ? ? ? ? ? else
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? __raw_writel(1 << gpio, bank->base
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? + OMAP24XX_GPIO_CLEARWKUENA);
>> - ? ? ? ? ? ? }
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* GPIO wakeup request can only be generated on edge
>> + ? ? ? ? ? ? ?* transitions
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? if (trigger & IRQ_TYPE_EDGE_BOTH)
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(1 << gpio, bank->wake_set);
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? __raw_writel(1 << gpio, bank->wake_clear);
>> ? ? ? }
>> +
>> ? ? ? /* This part needs to be executed always for OMAP34xx */
>> ? ? ? if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
>> ? ? ? ? ? ? ? /*
>
