From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Fri, 30 Oct 2015 11:58:58 -0300
Subject: [PATCH v2 2/4] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <562E2CB1.80706@linaro.org>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1445275946-32653-3-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9Vyg6sScq7yM=7judsMPHOc5VF2zf=7LPxmbmL7wF=vvgw@mail.gmail.com>
 <562E2CB1.80706@linaro.org>
Message-ID: <563385B2.90403@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas,

El 26/10/15 a las 10:37, Srinivas Kandagatla escribi?:
> 
> 
> On 24/10/15 23:04, Joachim Eastwood wrote:
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
>>>   drivers/nvmem/Kconfig          |   9 ++
>>>   drivers/nvmem/Makefile         |   2 +
>>>   drivers/nvmem/lpc18xx_eeprom.c | 266
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 277 insertions(+)
>>>   create mode 100644 drivers/nvmem/lpc18xx_eeprom.c
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
>> Same thing for 'offset'.
>>
>> I tested the driver from sysfs by writing strings into the nvmem-file
>> with echo. Writing a string not dividable by 4 seems to hang the
>> system.
>>
> 
> I think I know the issue here:
> Could you try this patch:
> 
> -------------------------------->cut<----------------------------------
> From 8cae10eff8ea8da9c5a8058ff75abeeddd8a8224 Mon Sep 17 00:00:00 2001
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date: Mon, 26 Oct 2015 13:30:24 +0000
> Subject: [PATCH] nvmem: core: return error for non word aligned bytes
> 
> nvmem providers have restrictions on register strides, so return error
> code when users attempt to read/write buffers with sizes which are not
> aligned to the word boundary.
> 
> Without this patch the userspace would continue to try as it does not
> get any error from the nvmem core, resulting in a hang.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6fd4e5a..9d11d98 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -70,6 +70,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp,
> struct kobject *kobj,
>      if (pos >= nvmem->size)
>          return 0;
> 
> +    if (count < nvmem->word_size)
> +        return -EINVAL;
> +
>      if (pos + count > nvmem->size)
>          count = nvmem->size - pos;
> 
> @@ -95,6 +98,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp,
> struct kobject *kobj,
>      if (pos >= nvmem->size)
>          return 0;
> 
> +    if (count < nvmem->word_size)
> +        return -EINVAL;
> +
>      if (pos + count > nvmem->size)
>          count = nvmem->size - pos;
> 

Patch looks good to me. I think that it solves the issue.
I don't have the board here right now, so I'll check it ASAP and give
some feedback.

Thanks!

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
