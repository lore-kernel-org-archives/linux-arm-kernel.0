From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 26 Oct 2015 13:37:53 +0000
Subject: [PATCH v2 2/4] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <CAGhQ9Vyg6sScq7yM=7judsMPHOc5VF2zf=7LPxmbmL7wF=vvgw@mail.gmail.com>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>	<1445275946-32653-3-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9Vyg6sScq7yM=7judsMPHOc5VF2zf=7LPxmbmL7wF=vvgw@mail.gmail.com>
Message-ID: <562E2CB1.80706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/10/15 23:04, Joachim Eastwood wrote:
> Hi Ariel,
>
> On 19 October 2015 at 19:32, Ariel D'Alessandro
> <ariel@vanguardiasur.com.ar> wrote:
>> This commit adds support for NXP LPC18xx EEPROM memory found in NXP
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
>>   drivers/nvmem/lpc18xx_eeprom.c | 266 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 277 insertions(+)
>>   create mode 100644 drivers/nvmem/lpc18xx_eeprom.c
>
>> +static int lpc18xx_eeprom_gather_write(void *context, const void *reg,
>> +                                      size_t reg_size, const void *val,
>> +                                      size_t val_size)
>> +{
>> +       struct lpc18xx_eeprom_dev *eeprom = context;
>> +       unsigned int offset = *(u32 *)reg;
>> +
>> +       /* 3 ms of erase/program time between each writing */
>> +       while (val_size) {
>> +               writel(*(u32 *)val, eeprom->mem_base + offset);
>> +               usleep_range(3000, 4000);
>> +               val_size -= eeprom->val_bytes;
>> +               val += eeprom->val_bytes;
>> +               offset += eeprom->val_bytes;
>> +       }
>
> What happens here if 'val_size' is less than 4 or not dividable by 4?
> Same thing for 'offset'.
>
> I tested the driver from sysfs by writing strings into the nvmem-file
> with echo. Writing a string not dividable by 4 seems to hang the
> system.
>

I think I know the issue here:
Could you try this patch:

-------------------------------->cut<----------------------------------
 From 8cae10eff8ea8da9c5a8058ff75abeeddd8a8224 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 26 Oct 2015 13:30:24 +0000
Subject: [PATCH] nvmem: core: return error for non word aligned bytes

nvmem providers have restrictions on register strides, so return error
code when users attempt to read/write buffers with sizes which are not
aligned to the word boundary.

Without this patch the userspace would continue to try as it does not
get any error from the nvmem core, resulting in a hang.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  drivers/nvmem/core.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6fd4e5a..9d11d98 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -70,6 +70,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, 
struct kobject *kobj,
  	if (pos >= nvmem->size)
  		return 0;

+	if (count < nvmem->word_size)
+		return -EINVAL;
+
  	if (pos + count > nvmem->size)
  		count = nvmem->size - pos;

@@ -95,6 +98,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, 
struct kobject *kobj,
  	if (pos >= nvmem->size)
  		return 0;

+	if (count < nvmem->word_size)
+		return -EINVAL;
+
  	if (pos + count > nvmem->size)
  		count = nvmem->size - pos;

-- 
1.9.1

-------------------------------->cut<----------------------------------


--srini


>
>> +static int lpc18xx_eeprom_read(void *context, const void *reg, size_t reg_size,
>> +                              void *val, size_t val_size)
>> +{
>> +       struct lpc18xx_eeprom_dev *eeprom = context;
>> +       unsigned int offset = *(u32 *)reg;
>> +
>> +       while (val_size) {
>> +               *(u32 *)val = readl(eeprom->mem_base + offset);
>> +               val_size -= eeprom->val_bytes;
>> +               val += eeprom->val_bytes;
>> +               offset += eeprom->val_bytes;
>> +       }
>> +
>> +       return 0;
>> +}
>
> Same comments as for lpc18xx_eeprom_gather_write().
>
>
>> +static const struct of_device_id lpc18xx_eeprom_of_match[] = {
>> +       { .compatible = "nxp,lpc1857-eeprom" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, lpc18xx_eeprom_of_match);
>
> nit: It's usual to place of_device_id struct just above the
> platform_driver struct.
>
>
>> +       eeprom->val_bytes = lpc18xx_regmap_config.val_bits / 8;
>> +       eeprom->reg_bytes = lpc18xx_regmap_config.reg_bits / 8;
>
> There is a BITS_PER_BYTE define in bitops.h that you might want to use here.
>
>
>> +       /*
>> +        * Clock rate is generated by dividing the system bus clock by the
>> +        * division factor, contained in the divider register (minus 1 encoded).
>> +        */
>> +       clk_rate = clk_get_rate(eeprom->clk);
>> +       clk_rate = DIV_ROUND_UP(clk_rate, LPC18XX_EEPROM_CLOCK_HZ) - 1;
>> +       lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_CLKDIV, clk_rate);
>> +
>> +       /*
>> +        * Writing a single word to the page will start the erase/program cycle
>> +        * automatically
>> +        */
>> +       lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_AUTOPROG,
>> +                             LPC18XX_EEPROM_AUTOPROG_WORD);
>> +
>> +       lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
>> +                             LPC18XX_EEPROM_PWRDWN_NO);
>> +
>> +       lpc18xx_regmap_config.max_register = resource_size(res) - 1;
>> +       lpc18xx_regmap_config.writeable_reg = lpc18xx_eeprom_writeable_reg;
>> +       lpc18xx_regmap_config.readable_reg = lpc18xx_eeprom_readable_reg;
>> +
>> +       regmap = devm_regmap_init(dev, &lpc18xx_eeprom_bus, eeprom,
>> +                                 &lpc18xx_regmap_config);
>> +       if (IS_ERR(regmap)) {
>> +               dev_err(dev, "regmap init failed: %ld\n", PTR_ERR(regmap));
>> +               ret = PTR_ERR(regmap);
>> +               goto err_clk;
>> +       }
>> +
>> +       lpc18xx_nvmem_config.dev = dev;
>> +
>> +       eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
>> +       if (IS_ERR(eeprom->nvmem)) {
>> +               ret = PTR_ERR(eeprom->nvmem);
>> +               goto err_clk;
>> +       }
>> +
>> +       platform_set_drvdata(pdev, eeprom);
>> +
>> +       return 0;
>> +
>> +err_clk:
>> +       clk_disable_unprepare(eeprom->clk);
>> +
>> +       return ret;
>> +}
>> +
>> +static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>> +{
>> +       struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
>> +
>> +       lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
>> +                             LPC18XX_EEPROM_PWRDWN_YES);
>> +
>> +       clk_disable_unprepare(eeprom->clk);
>> +
>> +       return nvmem_unregister(eeprom->nvmem);
>
> Normally you do tear down in the reverse order of initialization.
>
> Consider what happens here when you power down and disable the clock
> while there still are nvmem users of the eeprom.
>
>
> regards,
> Joachim Eastwood
>
