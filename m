From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Mon, 16 Nov 2015 12:24:09 -0300
Subject: [PATCH v2 2/4] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <563384CB.3070607@vanguardiasur.com.ar>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1445275946-32653-3-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9Vyg6sScq7yM=7judsMPHOc5VF2zf=7LPxmbmL7wF=vvgw@mail.gmail.com>
 <563384CB.3070607@vanguardiasur.com.ar>
Message-ID: <5649F519.4050401@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joachim,

Sorry for the delay, I finally got the hardware again.

El 30/10/15 a las 11:55, Ariel D'Alessandro escribi?:
> Joachim,
> 
> El 24/10/15 a las 19:04, Joachim Eastwood escribi?:
>> Hi Ariel,
>>
>> On 19 October 2015 at 19:32, Ariel D'Alessandro
>> <ariel@vanguardiasur.com.ar> wrote:
>>> This commit adds support for NXP LPC18xx EEPROM memory found in NXP
>>> LPC185x/3x and LPC435x/3x/2x/1x devices.
>>>
>>> EEPROM size is 16384 bytes and it can be entirely read and
>>> written/erased with 1 word (4 bytes) granularity. The last page
>>> (128 bytes) contains the EEPROM initialization data and is not writable.
>>>
>>> Erase/program time is less than 3ms. The EEPROM device requires a
>>> ~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
>>> the system bus clock by the division factor, contained in the divider
>>> register (minus 1 encoded).
>>>
>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>> ---
>>>  drivers/nvmem/Kconfig          |   9 ++
>>>  drivers/nvmem/Makefile         |   2 +
>>>  drivers/nvmem/lpc18xx_eeprom.c | 266 +++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 277 insertions(+)
>>>  create mode 100644 drivers/nvmem/lpc18xx_eeprom.c
>>
>>> +static int lpc18xx_eeprom_gather_write(void *context, const void *reg,
>>> +                                      size_t reg_size, const void *val,
>>> +                                      size_t val_size)
>>> +{
>>> +       struct lpc18xx_eeprom_dev *eeprom = context;
>>> +       unsigned int offset = *(u32 *)reg;
>>> +
>>> +       /* 3 ms of erase/program time between each writing */
>>> +       while (val_size) {
>>> +               writel(*(u32 *)val, eeprom->mem_base + offset);
>>> +               usleep_range(3000, 4000);
>>> +               val_size -= eeprom->val_bytes;
>>> +               val += eeprom->val_bytes;
>>> +               offset += eeprom->val_bytes;
>>> +       }
>>
>> What happens here if 'val_size' is less than 4 or not dividable by 4?
> 
> AFAIK, before calling to gather_write, the caller ensures that
> 'val_size' % map->format.val_bytes == 0
> 
> Like nvmem_device_write() do this in
> drivers/base/regmap/regmap.c:regmap_raw_write()
> 
> Then, if val_size == 0, nothing will happen.
> 
>> Same thing for 'offset'.
> 
> Let me check this one.

As I said regmap will ensure that
  val_len % map->format.val_bytes == 0
in both read and write.

However, it will only ensure that
  reg % map->reg_stride == 0
in read calls, not in write.
A non-word aligned write to the EEPROM will fail, so I'm adding a check
for this.

Thanks for pointing this out.

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
