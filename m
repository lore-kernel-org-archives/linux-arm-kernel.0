From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 25 Aug 2016 23:41:04 +0900
Subject: [PATCH v2 3/7] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM for one pin-bank
In-Reply-To: <CA+Ln22Ew=8S382zn+M8Ys5vztqvzp1+3EOTKtd81WSfuSyvY6w@mail.gmail.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-4-git-send-email-cw00.choi@samsung.com>
 <CA+Ln22Ew=8S382zn+M8Ys5vztqvzp1+3EOTKtd81WSfuSyvY6w@mail.gmail.com>
Message-ID: <CA+Ln22Guw1LghdV64cSKjByDExr+2HnvEK7DNkYz+XPAmVuAzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-25 23:30 GMT+09:00 Tomasz Figa <tomasz.figa@gmail.com>:
>> +       }
>> +
>> +#define EXYNOS_PIN_BANK_EINTN_EXT(pins, reg, id, pctl_idx, eint_idx)   \
>> +       {                                               \
>> +               .type           = &bank_type_off,       \
>> +               .pctl_offset    = reg,                  \
>> +               .nr_pins        = pins,                 \
>> +               .eint_type      = EINT_TYPE_NONE,       \
>> +               .name           = id,                   \
>> +               .pctl_res_idx   = pctl_idx,             \
>> +               .eint_res_idx   = eint_dix              \
>> +       }
>
> Your patch 4/7 doesn't seem to use this one, so this is dead code for
> the time being. Please add when there is real need for it.
>
> Also it doesn't really make much sense to have index for both pctl and
> eint. Please define first entry of regs property as always pointing to
> pctl registers and by also eint registers for usual controllers. Then
> second regs entry would be eint registers for controllers with
> separate register blocks. Then there is only a need to have
> eint_res_idx in the driver and no need for pctl_res_idx, because it
> would be always 0.

Ah, sorry, I got confused again by which registers are where in these
GPF banks. Let's make it the other way around and make DT contain eint
registers in first regs entry and hardcode eint_res_idx to 0 for the
time being. However it should be still beneficial to refactor the code
and calculate per-bank eint_base to avoid adding the offset every
time, similarly to pctl_base/offset, from my suggestion below.

>> @@ -345,7 +346,8 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
>>                         ((b->pin_base + b->nr_pins - 1) < pin))
>>                 b++;
>>
>> -       *reg = drvdata->virt_base + b->pctl_offset;
>> +       pctl_res_idx = b->pctl_res_idx;
>> +       *reg = drvdata->virt_base[pctl_res_idx] + b->pctl_offset;
>
> I suggested something slightly different. Instead of
> bank::pctl_res_idx, I proposed bank::pctl_base.
> bank_info::pctl_res_idx would be specified only in init driver data
> and bank::pctl_base would be calculated at probe time as
> drvdata->virt_base[bank_info->pctl_res_idx] + bank_info->pctl_offset.
> This would eliminate the need to do any indexing and adding further in
> the code and make things simpler.
>
> Taking my other comments above, pctl part would be unchanged and only
> eint addresses and offsets would be affected.

Ah, scratch this one sentence. I got confused with the register layout
again, sorry. Please refactor both eint and pctl as I suggested in the
upper paragraph.

Best regards,
Tomasz
