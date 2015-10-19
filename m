From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Mon, 19 Oct 2015 13:35:26 -0300
Subject: [PATCH 1/2] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <CAGhQ9VzYbG++UQdx-Ljouc+w3Z_K0WWvNOe0HQpNZ8JnphCDCw@mail.gmail.com>
References: <1445004426-6271-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1445004426-6271-2-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9VzYbG++UQdx-Ljouc+w3Z_K0WWvNOe0HQpNZ8JnphCDCw@mail.gmail.com>
Message-ID: <56251BCE.8090009@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joachim,

El 18/10/15 a las 18:47, Joachim Eastwood escribi?:
> Hi Ariel,
> 
> Thanks for working on this.
> 
> On 16 October 2015 at 16:07, Ariel D'Alessandro
> <ariel@vanguardiasur.com.ar> wrote:
>> This commit adds support for NXP LPC18xx EEPROM memory found in NXP LPC
>> SoCs family, which includes LPC18xx/LPC43xx. Other SoCs in that family
>> may share the same watchdog hardware.
> 
> Only LPC185x/3x and LPC435x/3x/2x/1x devices have the EEPROM.

Will fix that.

> 
> 
>> EEPROM size is 16384 bytes and it can be entirely read and
>> written/erased with 1 word (4 bytes) granularity. The last page
>> (128 bytes) contains the EEPROM initialization data and is not writable.
>>
>> Erase/program time is less than 3ms. The EEPROM device requires a
>> ~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
>> the system bus clock by the division factor, contained in the divider
>> register (minus 1 encoded).
> 
> Nice description of the device.
> 
> 
>> +static inline void lpc18xx_eeprom_writel(struct lpc18xx_eeprom_dev *eeprom,
>> +                                        u32 reg, u32 val)
>> +{
>> +       writel(val, eeprom->reg_base + reg);
>> +}
>> +
>> +static inline u32 lpc18xx_eeprom_readl(struct lpc18xx_eeprom_dev *eeprom,
>> +                                      u32 reg)
>> +{
>> +       return readl(eeprom->reg_base + reg);
>> +}
> 
> Read function seems to be unused.

That's true, I'll remove readl.

> 
> Are these two wrappers really useful?

Well, we don't gain much in this case, but I usually prefer using the
wrappers to read/write to from/to registers and avoid having to write
'base + reg' every time.

> 
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
>> +               mdelay(3);
> 
> That's a long mdelay. Is it possible to sleep instead?

Yes, it's long. I'll sleep instead.

> 
> 
>> +               val_size -= eeprom->val_bytes;
>> +               val += eeprom->val_bytes;
>> +               offset += eeprom->val_bytes;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int lpc18xx_eeprom_write(void *context, const void *data, size_t count)
>> +{
>> +       struct lpc18xx_eeprom_dev *eeprom = context;
>> +       unsigned int offset = eeprom->reg_bytes;
>> +
>> +       BUG_ON(count <= offset);
> 
> BUG_ON seems a bit harsh. Could you return an error instead?

I based this part of the code on:
	drivers/base/regmap/regmap-mmio.c:regmap_mmio_write()
where there's a BUG_ON().
Anyway, I think you're right, so I'll return some error instead.

> 
> 
>> +       return lpc18xx_eeprom_gather_write(context, data, eeprom->reg_bytes,
>> +                                          data + offset, count - offset);
>> +}
> ...
>> +static bool lpc18xx_eeprom_writeable_reg(struct device *dev, unsigned int reg)
>> +{
>> +       /*
>> +        * The last page contains the EEPROM initialization data and is not
>> +        * writable.
>> +        */
>> +       return (reg <= lpc18xx_regmap_config.max_register -
>> +                                               LPC18XX_EEPROM_PAGE_SIZE);
> 
> Unnecessary  parenthesis.

ACK.

> 
>> +}
>> +
>> +static bool lpc18xx_eeprom_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +       return (reg <= lpc18xx_regmap_config.max_register);
>> +}
> 
> Unnecessary  parenthesis.

ACK.

> 
>> +
>> +static struct nvmem_config lpc18xx_nvmem_config = {
>> +       .name = "lpc18xx-eeprom",
>> +       .owner = THIS_MODULE,
>> +};
>> +
>> +static const struct of_device_id lpc18xx_eeprom_of_match[] = {
>> +       { .compatible = "nxp,lpc1850-eeprom" },
> 
> Use lpc1857 as noted in the other thread.

ACK.

> 
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, lpc18xx_eeprom_of_match);
> 

Thanks!

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
