From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 7 Sep 2011 10:34:43 +0530
Subject: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
In-Reply-To: <87ehztxmcg.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
Message-ID: <CAC83Zv+sX1G4saFsU=bOUYjedcM6eYEOCVMKqMZ-5pxkBc6x2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
>> + ? ? /*
>> + ? ? ?* If this is the first gpio_request for the bank,
>> + ? ? ?* enable the bank module.
>> + ? ? ?*/
>> + ? ? if (!bank->mod_usage)
>> + ? ? ? ? ? ? if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
>
> All of the IS_ERR_VALUE() usage is wrong here. ?You're checking if the
> result of IS_ERR_VALUE() is < 0 which will never happen.
No.
IS_ERR_VALUE is applied on the return value of pm_runtime_get_sync
which is <  0.

>
>> + ? ? ? ? ? ? ? ? ? ? dev_err(bank->dev, "%s: GPIO bank %d "
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "pm_runtime_get_sync failed\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, bank->id);
>> + ? ? ? ? ? ? ? ? ? ? spin_unlock_irqrestore(&bank->lock, flags);
>
> Rather than take the lock and have to unlock it here, just move the
> get_sync before the spinlock. ?There's no reason to hold the spinlock
> across the get_sync.
>
> In fact, holding the spinlock across a get sync means that the
> ->runtime_resume callback does not have proper locking around register
> access, which is also probably wrong.
>
> The locking in this driver is only around device register accesses, and
> should be kept minimal and to very small critical sections.
You are right! I will move *_get_sync() outside spinlock.

>
>> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? ? ? ? ? }
>> +
>> ? ? ? /* Set trigger to none. You need to enable the desired trigger with
>> ? ? ? ?* request_irq() or set_irq_type().
>> ? ? ? ?*/
>> @@ -530,6 +545,19 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>> ? ? ? }
>>
>> ? ? ? _reset_gpio(bank, bank->chip.base + offset);
>> +
>> + ? ? /*
>> + ? ? ?* If this is the last gpio to be freed in the bank,
>> + ? ? ?* disable the bank module.
>> + ? ? ?*/
>> + ? ? if (!bank->mod_usage) {
>> + ? ? ? ? ? ? if (IS_ERR_VALUE(pm_runtime_put_sync(bank->dev) < 0)) {
>> + ? ? ? ? ? ? ? ? ? ? dev_err(bank->dev, "%s: GPIO bank %d "
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "pm_runtime_put_sync failed\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, bank->id);
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>
> same here, this should be after unlocking the spinlock, and register
> accesses inside the ->runtime_resume() callback need their own
> protection.
Ok.

>
>> ? ? ? spin_unlock_irqrestore(&bank->lock, flags);
>> ?}
>>
>> @@ -556,6 +584,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>>
>> ? ? ? bank = irq_get_handler_data(irq);
>> ? ? ? isr_reg = bank->base + bank->regs->irqstatus;
>> + ? ? pm_runtime_get_sync(bank->dev);
>>
>> ? ? ? if (WARN_ON(!isr_reg))
>> ? ? ? ? ? ? ? goto exit;
>> @@ -617,6 +646,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>> ?exit:
>> ? ? ? if (!unmasked)
>> ? ? ? ? ? ? ? chained_irq_exit(chip, desc);
>> + ? ? pm_runtime_put_sync_suspend(bank->dev);
>
> Why use _put_sync_suspend()?
>
> Why does this need to be synchronous? ?I think it should use the
> asynchronous pm_runtime_put().
I will change it to pm_runtime_put().

>
[...]
>>
>> @@ -1258,10 +1310,16 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>> ?}
>> ?#endif
>>
>> +static const struct dev_pm_ops gpio_pm_ops = {
>> + ? ? .suspend ? ? ? ? ? ? ? ?= omap_gpio_suspend,
>> + ? ? .resume ? ? ? ? ? ? ? ? = omap_gpio_resume,
>> +};
>
> Please use SET_SYSTEM_SLEEP_PM_OPS(). ?See <linux/pm.h>
Ok.

>
>> ?static struct platform_driver omap_gpio_driver = {
>> ? ? ? .probe ? ? ? ? ?= omap_gpio_probe,
>> ? ? ? .driver ? ? ? ? = {
>> ? ? ? ? ? ? ? .name ? = "omap_gpio",
>> + ? ? ? ? ? ? .pm ? ? = &gpio_pm_ops,
>> ? ? ? },
>> ?};
>>
>> @@ -1275,16 +1333,3 @@ static int __init omap_gpio_drv_reg(void)
>> ? ? ? return platform_driver_register(&omap_gpio_driver);
>> ?}
>> ?postcore_initcall(omap_gpio_drv_reg);
>> -
>> -static int __init omap_gpio_sysinit(void)
>> -{
>> -
>> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
>> - ? ? if (cpu_is_omap16xx() || cpu_class_is_omap2())
>> - ? ? ? ? ? ? register_syscore_ops(&omap_gpio_syscore_ops);
>> -#endif
>> -
>> - ? ? return 0;
>> -}
>> -
>> -arch_initcall(omap_gpio_sysinit);
>
> Kevin
>
