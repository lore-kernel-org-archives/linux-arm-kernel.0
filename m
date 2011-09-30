From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Sep 2011 15:36:44 +0800
Subject: [PATCH 5/5] ARM: pxa: move gpio driver into drivers directory
In-Reply-To: <20110929222723.GI10886@ponder.secretlab.ca>
References: <1317309546-19682-5-git-send-email-haojian.zhuang@marvell.com>
	<20110929222723.GI10886@ponder.secretlab.ca>
Message-ID: <CAN1soZzw0dkZm2rmwGJk3Pmmxv+6dfyWYQ=pPJnY8cD6wHab6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 6:27 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Sep 29, 2011 at 11:19:06PM +0800, Haojian Zhuang wrote:
>> Move gpio driver from plat-pxa to drivers/gpio directory. Only leave
>> gpio number macro in mach/gpio.h.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> +static int __init mmp_gpio_init(void)
>> +{
>> +     [...]
>> + ? ? platform_device_add_data(&mmp_gpio, &mmp_gpio_config, size);
>> + ? ? platform_device_register(&mmp_gpio);
>> + ? ? return 0;
>> +}
>> +postcore_initcall(mmp_gpio_init);
>
> You'll also want to bail on this init function if a DT is passed to
> the kernel. ?Otherwise it looks okay.
>
I can avoid to use this init function. So platform driver will
register gpio directly.

>> -#define GPIO_REG(x) ?(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))
>> +#define GPIO_REGS_VIRT ? ? ? ? ? ? ? (APB_VIRT_BASE + 0x19000)
>
> Nit: don't change the whitespace on this line because it isn't
> actually changing functionally, but diff makes it look like it is.
>
> I assume these remaining macros will be removed/reworked in a future
> patch?
>
Do you mean that abandon APB_VIRT_BASE?

>> +static int __init pxa_gpio_init(void)
>> +{
>> + ? ? int size = sizeof(struct pxa_gpio_platform_data);
>> + ? ? u32 reg_base = io_p2v(0x40E00000);
>> +
>> + ? ? if (cpu_is_pxa25x()) {
>> +#ifdef CONFIG_PXA26x
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_type = PXA26X_GPIO;
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_end = 89;
>> +#else
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_type = PXA25X_GPIO;
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_end = 84;
>> +#endif
>
> Not multiplatform friendly. ?The subarch may not support
> multiplatform, but that's no excuse for adding either/or #ifdef
> blocks. ?I'd rather see one #ifdef for PXA26x and another for PXA25x,
> and the code organizes so that they can peacefully co-exist.
>
OK.

>> + ? ? } else if (cpu_is_pxa27x()) {
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_type = PXA27X_GPIO;
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_end = 120;
>> + ? ? } else if (cpu_is_pxa93x() || cpu_is_pxa95x()) {
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_type = PXA93X_GPIO;
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_end = 191;
>> + ? ? } else if (cpu_is_pxa3xx()) {
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_type = PXA3XX_GPIO;
>> + ? ? ? ? ? ? pxa_gpio_config.gpio_end = 127;
>> + ? ? } else
>> + ? ? ? ? ? ? return 0;
>> +
>> + ? ? pxa_gpio_regs.gplr = reg_base + GPLR_OFFSET;
>> + ? ? pxa_gpio_regs.gpdr = reg_base + GPDR_OFFSET;
>> + ? ? pxa_gpio_regs.gpsr = reg_base + GPSR_OFFSET;
>> + ? ? pxa_gpio_regs.gpcr = reg_base + GPCR_OFFSET;
>> + ? ? pxa_gpio_regs.grer = reg_base + GRER_OFFSET;
>> + ? ? pxa_gpio_regs.gfer = reg_base + GFER_OFFSET;
>> + ? ? pxa_gpio_regs.gedr = reg_base + GEDR_OFFSET;
>> + ? ? pxa_gpio_regs.gafr = reg_base + GAFR_OFFSET;
>
> I'd rather have this layout knowledge as part of the driver
> rather than using platform data to pass stuff. ?The driver can make
> the selection either based on device name, or by testing
> cpio_is_pxa*() directly. ?We already have the mechanisms needed for
> this.
>
> Same goes for mmp_gpio_init().
>
OK. I'll move these code into drivers/gpio/gpio-pxa.c.

>> +
>> + ? ? platform_device_add_data(&pxa_gpio, &pxa_gpio_config, size);
>> + ? ? platform_device_register(&pxa_gpio);
>> + ? ? return 0;
>> +}
>> +postcore_initcall(pxa_gpio_init);
>
> Same as mmp_gpio_init, this function needs to be skipped if a DT is
> passed to the kernel.
>
OK

>> @@ -282,7 +281,6 @@ static int __init pxa95x_init(void)
>> ? ? ? ? ? ? ? ? ? ? ? return ret;
>>
>> ? ? ? ? ? ? ? register_syscore_ops(&pxa_irq_syscore_ops);
>> - ? ? ? ? ? ? register_syscore_ops(&pxa_gpio_syscore_ops);
>> ? ? ? ? ? ? ? register_syscore_ops(&pxa3xx_clock_syscore_ops);
>>
>> ? ? ? ? ? ? ? ret = platform_add_devices(devices, ARRAY_SIZE(devices));

>
> Instead of encoding it into pdata, it would be simpler to select the
> type by assiging an (platform_driver*)->id_table and using the .data
> member in the table to select the correct initialization data. ?That
> means using the name of the device to select the correct
> initialization.
>
Yes, you're right. I'll change it to id_table.
>>
>> +
>> +static int __init pxa_gpio_probe(struct platform_device *pdev)
>
> This needs to be __devinit for correctness.
>
OK
>>
>> +#define GPLR(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.gplr + BANK_OFF((x >> 5))))
>> +#define GPDR(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.gpdr + BANK_OFF((x >> 5))))
>> +#define GPSR(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.gpsr + BANK_OFF((x >> 5))))
>> +#define GPCR(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.gpcr + BANK_OFF((x >> 5))))
>> +#define GRER(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.grer + BANK_OFF((x >> 5))))
>> +#define GFER(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.gfer + BANK_OFF((x >> 5))))
>> +#define GEDR(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.gedr + BANK_OFF((x >> 5))))
>> +#define GAFR(x) ? ? ? ? ? ? ?(*(volatile u32 *)(pxa_gpio_regs.gafr + (((x) & 0x70) >> 2)))
>> +
>> +#define GPIO_BANK(n) (pxa_gpio_regs.gplr + BANK_OFF(n))
>
> All these macros really need a pxa_gpio prefix, but that can be done
> in a separate patch.
>
OK
