From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 7 Sep 2011 11:46:43 +0530
Subject: [PATCH v6 22/25] gpio/omap: save and restore debounce registers
In-Reply-To: <877h5lw75t.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-23-git-send-email-tarun.kanti@ti.com>
	<877h5lw75t.fsf@ti.com>
Message-ID: <CAC83ZvKQ_Nrekoet6gnPuHTQ9pXSFpZaYAxJ5O8nsYetBxd6dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2011 at 5:33 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Nishant Menon <nm@ti.com>
>
> Check spelling of first name (I believe version in signed-off-by below
> is the correct one.)
Yes, it should haven been "Nishanth".

>
>> GPIO debounce registers need to be saved and restored for proper functioning
>> of driver. To save the registers, we cannot cut the clock before the save,
>> hence move the clk disable after the save.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> ?drivers/gpio/gpio-omap.c | ? 22 +++++++++++++++++++---
>> ?1 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index dc382f6..67e08e9 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -41,6 +41,8 @@ struct gpio_regs {
>> ? ? ? u32 risingdetect;
>> ? ? ? u32 fallingdetect;
>> ? ? ? u32 dataout;
>> + ? ? u32 debounce;
>> + ? ? u32 debounce_en;
>> ?};
>>
>> ?struct gpio_bank {
>> @@ -1158,9 +1160,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
>> ? ? ? u32 l1 = 0, l2 = 0;
>> ? ? ? int j;
>>
>> - ? ? for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
>> - ? ? ? ? ? ? clk_disable(bank->dbck);
>> -
>> ? ? ? if (!bank->mod_usage)
>> ? ? ? ? ? ? ? return 0;
>>
>> @@ -1192,6 +1191,16 @@ update_gpio_context_count:
>> ? ? ? ? ? ? ? bank->context_loss_count =
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->get_context_loss_count(bank->dev);
>>
>> + ? ? if (bank->dbck_enable_mask) {
>> + ? ? ? ? ? ? bank->context.debounce = __raw_readl(bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->regs->debounce);
>> + ? ? ? ? ? ? bank->context.debounce_en = __raw_readl(bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->regs->debounce_en);
>
> Here you're taking a step backwards from the goal of not having to read
> registers in the runtime suspend callback.
>
> Rather than reading the registers here, the values should be saved into
> bank->context when they are initially written (_set_gpio_debounce()), so
> you don't have the overhead of reading the registers in ->runtime_suspend.
Good catch! Thanks.
--
Tarun
>
>> + ? ? }
>> +
>> + ? ? for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
>> + ? ? ? ? ? ? clk_disable(bank->dbck);
>> +
>> ? ? ? return 0;
>> ?}
>>
>> @@ -1331,6 +1340,13 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>> ? ? ? __raw_writel(bank->context.fallingdetect,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->base + bank->regs->fallingdetect);
>> ? ? ? __raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
>> +
>> + ? ? if (bank->dbck_enable_mask) {
>> + ? ? ? ? ? ? __raw_writel(bank->context.debounce, bank->base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->regs->debounce);
>> + ? ? ? ? ? ? __raw_writel(bank->context.debounce_en,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->base + bank->regs->debounce_en);
>> + ? ? }
>> ?}
>> ?#else
>> ?#define omap_gpio_runtime_suspend NULL
>
> Kevin
>
