From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Apr 2012 11:11:56 +0800
Subject: [PATCH 1/9] ARM: mmp: fix build issue on mmp with device tree
In-Reply-To: <201204272015.49611.arnd@arndb.de>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <1335515957-1798-2-git-send-email-haojian.zhuang@gmail.com>
 <201204272015.49611.arnd@arndb.de>
Message-ID: <CAN1soZzETeCa7zVVpXC3y6Pa+nUMJLgbPAYpCBEfNsTTPF=XTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 4:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 27 April 2012, Haojian Zhuang wrote:
>> Since irq_domain_add_simple() is removed, remove it in mmp-dt.c also.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>
> This should also be fixed for v3.4, right?
>
Since I have more code updated in irq, I update them together to avoid
dependency issue.
>
>> diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
>> index 6707539..ca22e3c0 100644
>> --- a/arch/arm/mach-mmp/mmp-dt.c
>> +++ b/arch/arm/mach-mmp/mmp-dt.c
>> @@ -32,31 +32,9 @@ static const struct of_dev_auxdata mmp_auxdata_lookup[] __initconst = {
>> ? ? ? ? {}
>> ?};
>>
>> -static int __init mmp_intc_add_irq_domain(struct device_node *np,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device_node *parent)
>> -{
>> - ? ? ? irq_domain_add_simple(np, 0);
>> - ? ? ? return 0;
>> -}
>> -
>> -static int __init mmp_gpio_add_irq_domain(struct device_node *np,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device_node *parent)
>> -{
>> - ? ? ? irq_domain_add_simple(np, IRQ_GPIO_START);
>> - ? ? ? return 0;
>> -}
>> -
>> -static const struct of_device_id mmp_irq_match[] __initconst = {
>> - ? ? ? { .compatible = "mrvl,mmp-intc", .data = mmp_intc_add_irq_domain, },
>> - ? ? ? { .compatible = "mrvl,mmp-gpio", .data = mmp_gpio_add_irq_domain, },
>> - ? ? ? {}
>> -};
>> -
>> ?static void __init mmp_dt_init(void)
>> ?{
>>
>> - ? ? ? of_irq_init(mmp_irq_match);
>> -
>> ? ? ? ? of_platform_populate(NULL, of_default_bus_match_table,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?mmp_auxdata_lookup, NULL);
>> ?}
>
> Shouldn't you be calling irq_domain_add_legacy now?
>
irq_domain_add_legacy() is used in irq.c. It's in another patch in this series.
