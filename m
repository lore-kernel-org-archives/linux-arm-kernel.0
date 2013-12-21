From: syin@broadcom.com (Sherman Yin)
Date: Fri, 20 Dec 2013 18:31:42 -0800
Subject: [PATCH v3 5/6] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <52B23618.2040508@broadcom.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>	<1386787041-6035-1-git-send-email-syin@broadcom.com>	<1386787041-6035-6-git-send-email-syin@broadcom.com>
 <CACRpkdaeZCodKv6R+4ZS3o-5u=QQuV3JidEp7uaLsN9aYG7bqA@mail.gmail.com>
 <52B23618.2040508@broadcom.com>
Message-ID: <52B4FD8E.1010009@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-18 03:56 PM, Sherman Yin wrote:
> On 13-12-12 12:54 PM, Linus Walleij wrote:

>>> +/*
>>> + * Write to the register using the value and mask if current value
>>> is different
>>> + */
>>> +static void capri_reg_write(struct pinctrl_dev *pctldev,
>>> +                           void __iomem *reg,
>>> +                           u32 val,
>>> +                           u32 mask)
>>> +{
>>> +       u32 old_val;
>>> +       u32 new_val;
>>> +
>>> +       old_val = readl(reg);
>>> +       new_val = (old_val & ~mask) | (val & mask);
>>> +
>>> +       if (new_val == old_val) {
>>> +               dev_dbg(pctldev->dev,
>>> +                       "Reg 0x%p=0x%x (no change)\n",
>>> +                       reg, old_val);
>>> +               return;
>>> +       }
>>> +
>>> +       dev_dbg(pctldev->dev,
>>> +               "Reg 0x%p change from 0x%x to 0x%x\n",
>>> +               reg, old_val, new_val);
>>> +       writel(new_val, reg);
>>> +}
>>
>> This is a reimplementation of regmap for MMIO.
>> See drivers/base/regmap/regmap-mmio.c
>> Notice how regmap_update_bits() is used throughout the
>> kernel.
>>
>> If you want to do this, use regmap.
>
> Ok.

As you can see in v4 of my patchset, I've changed my driver to use the 
mmio regmap.  However, as I was tracing through regmap_update_bits(), it 
looks like I have to go through a lot of checks and function pointers 
just to do a simple write to a register.  Also, I have to select 
REGMAP_MMIO which brings in a bunch of code as well.

I understand the benefits of using common code, but in this case it 
seems there is a lot of extra code and run-time overhead to use regmap. 
  In the end it also doesn't buy much in terms of functionality.

Just a quick note - it looks like the 2nd parameter of 
regmap_update_bits() wants the offset of a register (offset from 
regmap_mmio_context.regs).  So calling the parameter "reg" is a little 
confusing, at least in the MMIO case.

Regards,
Sherman
