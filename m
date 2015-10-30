From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Fri, 30 Oct 2015 12:42:44 -0300
Subject: [PATCH v2 2/4] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <562E377A.3040604@linaro.org>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1445275946-32653-3-git-send-email-ariel@vanguardiasur.com.ar>
 <562E377A.3040604@linaro.org>
Message-ID: <56338FF4.8050102@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas,

El 26/10/15 a las 11:23, Srinivas Kandagatla escribi?:
> 
> 
> On 19/10/15 18:32, Ariel D'Alessandro wrote:
>> This commit adds support for NXP LPC18xx EEPROM memory found in NXP
> s/commit/patch

OK.

> 
>> LPC185x/3x and LPC435x/3x/2x/1x devices.
>>
>> EEPROM size is 16384 bytes and it can be entirely read and
>> written/erased with 1 word (4 bytes) granularity. The last page
>> (128 bytes) contains the EEPROM initialization data and is not writable.
>>
>> Erase/program time is less than 3ms. The EEPROM device requires a
>> ~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
>> the system bus clock by the division factor, contained in the divider
>> register (minus 1 encoded).
>>
>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>> ---
>>   drivers/nvmem/Kconfig          |   9 ++
>>   drivers/nvmem/Makefile         |   2 +
>>   drivers/nvmem/lpc18xx_eeprom.c | 266
>> +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 277 insertions(+)
>>   create mode 100644 drivers/nvmem/lpc18xx_eeprom.c
>>
[snip]
>> diff --git a/drivers/nvmem/lpc18xx_eeprom.c
>> b/drivers/nvmem/lpc18xx_eeprom.c
>> new file mode 100644
>> index 0000000..ccdda66
>> --- /dev/null
>> +++ b/drivers/nvmem/lpc18xx_eeprom.c
>> @@ -0,0 +1,266 @@
>> +/*
>> + * NXP LPC18xx/LPC43xx EEPROM memory NVMEM driver
>> + *
>> + * Copyright (c) 2015 Ariel D'Alessandro <ariel@vanguardiasur.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> modify it
>> + * under the terms of the GNU General Public License version 2 as
>> published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/of_device.h>
> Why do you need above?
> 
> Also you should probably include
> 
>  #include <linux/platform_device.h>

You're right. No need for of_device.h, only platform_device.h.

> 
> 
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +
>> +/* Registers */
>> +#define LPC18XX_EEPROM_AUTOPROG        0x00c
>> +#define LPC18XX_EEPROM_AUTOPROG_WORD    0x1
>> +
>> +#define LPC18XX_EEPROM_CLKDIV        0x014
>> +
>> +#define LPC18XX_EEPROM_PWRDWN        0x018
>> +#define LPC18XX_EEPROM_PWRDWN_NO    0x0
>> +#define LPC18XX_EEPROM_PWRDWN_YES    0x1
>> +
>> +/* Fixed page size (bytes) */
>> +#define LPC18XX_EEPROM_PAGE_SIZE    0x80
>> +
>> +/* EEPROM device requires a ~1500 kHz clock (min 800 kHz, max 1600
>> kHz) */
>> +#define LPC18XX_EEPROM_CLOCK_HZ        1500000
>> +
>> +struct lpc18xx_eeprom_dev {
>> +    struct clk *clk;
>> +    void __iomem *reg_base;
>> +    void __iomem *mem_base;
>> +    struct nvmem_device *nvmem;
>> +    unsigned reg_bytes;
>> +    unsigned val_bytes;
>> +};
>> +
>> +static inline void lpc18xx_eeprom_writel(struct lpc18xx_eeprom_dev
>> *eeprom,
>> +                     u32 reg, u32 val)
>> +{
>> +    writel(val, eeprom->reg_base + reg);
>> +}
> I don't have a strong feeling but, I see no point to have a wrapper for
> writel which is only used in probe function.

Well, to be correct it's also used in remove function. And I might call
it in read()/write() functions to allow dynamic power on/off.
I'd prefer keeping the wrapper.

> 
>> +
>> +static int lpc18xx_eeprom_gather_write(void *context, const void *reg,
>> +                       size_t reg_size, const void *val,
>> +                       size_t val_size)
>> +{
>> +    struct lpc18xx_eeprom_dev *eeprom = context;
>> +    unsigned int offset = *(u32 *)reg;
>> +
>> +    /* 3 ms of erase/program time between each writing */
>> +    while (val_size) {
>> +        writel(*(u32 *)val, eeprom->mem_base + offset);
>> +        usleep_range(3000, 4000);
>> +        val_size -= eeprom->val_bytes;
>> +        val += eeprom->val_bytes;
>> +        offset += eeprom->val_bytes;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int lpc18xx_eeprom_write(void *context, const void *data,
>> size_t count)
>> +{
>> +    struct lpc18xx_eeprom_dev *eeprom = context;
>> +    unsigned int offset = eeprom->reg_bytes;
>> +
>> +    if (count <= offset)
>> +        return -EINVAL;
>> +
>> +
> unnecessary new line.

ACK.

> 
>> +    return lpc18xx_eeprom_gather_write(context, data, eeprom->reg_bytes,
>> +                       data + offset, count - offset);
>> +}
>> +
[snip]
>> +
>> +static int lpc18xx_eeprom_probe(struct platform_device *pdev)
>> +{
>> +    struct lpc18xx_eeprom_dev *eeprom;
>> +    struct device *dev = &pdev->dev;
>> +    struct reset_control *rst;
>> +    unsigned long clk_rate;
>> +    struct regmap *regmap;
>> +    struct resource *res;
>> +    int ret;
>> +
>> +    eeprom = devm_kzalloc(dev, sizeof(*eeprom), GFP_KERNEL);
>> +    if (!eeprom)
>> +        return -ENOMEM;
>> +
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
>> +    eeprom->reg_base = devm_ioremap_resource(dev, res);
>> +    if (IS_ERR(eeprom->reg_base))
>> +        return PTR_ERR(eeprom->reg_base);
>> +
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
>> +    eeprom->mem_base = devm_ioremap_resource(dev, res);
>> +    if (IS_ERR(eeprom->mem_base))
>> +        return PTR_ERR(eeprom->mem_base);
>> +
>> +    eeprom->clk = devm_clk_get(&pdev->dev, "eeprom");
>> +    if (IS_ERR(eeprom->clk)) {
>> +        dev_err(&pdev->dev, "failed to get eeprom clock\n");
>> +        return PTR_ERR(eeprom->clk);
>> +    }
>> +
>> +    ret = clk_prepare_enable(eeprom->clk);
>> +    if (ret < 0) {
>> +        dev_err(dev, "failed to prepare/enable eeprom clk: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    rst = devm_reset_control_get(dev, NULL);
>> +    if (IS_ERR(rst)) {
>> +        dev_err(dev, "failed to get reset: %ld\n", PTR_ERR(rst));
>> +        ret = PTR_ERR(rst);
>> +        goto err_clk;
>> +    }
>> +
>> +    ret = reset_control_deassert(rst);
>> +    if (ret < 0) {
>> +        dev_err(dev, "failed to deassert reset: %d\n", ret);
>> +        goto err_clk;
>> +    }
>> +
>> +    eeprom->val_bytes = lpc18xx_regmap_config.val_bits / 8;
>> +    eeprom->reg_bytes = lpc18xx_regmap_config.reg_bits / 8;
>> +
>> +    /*
>> +     * Clock rate is generated by dividing the system bus clock by the
>> +     * division factor, contained in the divider register (minus 1
>> encoded).
>> +     */
>> +    clk_rate = clk_get_rate(eeprom->clk);
>> +    clk_rate = DIV_ROUND_UP(clk_rate, LPC18XX_EEPROM_CLOCK_HZ) - 1;
>> +    lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_CLKDIV, clk_rate);
>> +
>> +    /*
>> +     * Writing a single word to the page will start the erase/program
>> cycle
>> +     * automatically
>> +     */
>> +    lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_AUTOPROG,
>> +                  LPC18XX_EEPROM_AUTOPROG_WORD);
>> +
>> +    lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
>> +                  LPC18XX_EEPROM_PWRDWN_NO);
> 
> Any reason not power up/dowm dynamically in
> lpc18xx_eeprom_write()/lpc18xx_eeprom_read().
> 
> This can potentially save some power.

That sounds good. I'll add this feature and check that it works properly.

> 
>> +
>> +    lpc18xx_regmap_config.max_register = resource_size(res) - 1;
>> +    lpc18xx_regmap_config.writeable_reg = lpc18xx_eeprom_writeable_reg;
>> +    lpc18xx_regmap_config.readable_reg = lpc18xx_eeprom_readable_reg;
>> +
>> +    regmap = devm_regmap_init(dev, &lpc18xx_eeprom_bus, eeprom,
>> +                  &lpc18xx_regmap_config);
>> +    if (IS_ERR(regmap)) {
>> +        dev_err(dev, "regmap init failed: %ld\n", PTR_ERR(regmap));
>> +        ret = PTR_ERR(regmap);
>> +        goto err_clk;
>> +    }
>> +
>> +    lpc18xx_nvmem_config.dev = dev;
>> +
>> +    eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
>> +    if (IS_ERR(eeprom->nvmem)) {
>> +        ret = PTR_ERR(eeprom->nvmem);
>> +        goto err_clk;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, eeprom);
>> +
>> +    return 0;
>> +
>> +err_clk:
> 
> Should this error path also include power down/reset assert the eeprom?

Yes, I'll add another cleanup routine.

> 
>> +    clk_disable_unprepare(eeprom->clk);
>> +
>> +    return ret;
>> +}
>> +
>> +static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>> +{
>> +    struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
>> +
>> +    lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
>> +                  LPC18XX_EEPROM_PWRDWN_YES);
>> +
>> +    clk_disable_unprepare(eeprom->clk);
>> +
>> +    return nvmem_unregister(eeprom->nvmem);
> 
> Same comment as Joachim, should the reset be asserted too?

No. That would cause a reset, disabling EEPROM power down mode.

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
