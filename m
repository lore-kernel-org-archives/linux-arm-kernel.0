From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 20 Sep 2016 10:03:30 +0900
Subject: [PATCH v2 3/7] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM for one pin-bank
In-Reply-To: <57CD27FC.2020201@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-4-git-send-email-cw00.choi@samsung.com>
 <CA+Ln22Ew=8S382zn+M8Ys5vztqvzp1+3EOTKtd81WSfuSyvY6w@mail.gmail.com>
 <CGME20160825144434epcas1p42890a972743a8c8787444651f91a4fa6@epcas1p4.samsung.com>
 <CA+Ln22Guw1LghdV64cSKjByDExr+2HnvEK7DNkYz+XPAmVuAzA@mail.gmail.com>
 <57CD27FC.2020201@samsung.com>
Message-ID: <CA+Ln22EDpYMyZ=oKvoa2msuEx3JAKcAhGpWSW3Mg73aKOJOFhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

Sorry for late reply. Yours was quick compared to mine. ;(

2016-09-05 17:08 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
> Hi Tomasz,
>
> I'm sorry for late reply.
>
> On 2016? 08? 25? 23:41, Tomasz Figa wrote:
>> 2016-08-25 23:30 GMT+09:00 Tomasz Figa <tomasz.figa@gmail.com>:
>>>> +       }
>>>> +
>>>> +#define EXYNOS_PIN_BANK_EINTN_EXT(pins, reg, id, pctl_idx, eint_idx)   \
>>>> +       {                                               \
>>>> +               .type           = &bank_type_off,       \
>>>> +               .pctl_offset    = reg,                  \
>>>> +               .nr_pins        = pins,                 \
>>>> +               .eint_type      = EINT_TYPE_NONE,       \
>>>> +               .name           = id,                   \
>>>> +               .pctl_res_idx   = pctl_idx,             \
>>>> +               .eint_res_idx   = eint_dix              \
>>>> +       }
>>>
>>> Your patch 4/7 doesn't seem to use this one, so this is dead code for
>>> the time being. Please add when there is real need for it.
>>>
>>> Also it doesn't really make much sense to have index for both pctl and
>>> eint. Please define first entry of regs property as always pointing to
>>> pctl registers and by also eint registers for usual controllers. Then
>>> second regs entry would be eint registers for controllers with
>>> separate register blocks. Then there is only a need to have
>>> eint_res_idx in the driver and no need for pctl_res_idx, because it
>>> would be always 0.
>>
>> Ah, sorry, I got confused again by which registers are where in these
>> GPF banks. Let's make it the other way around and make DT contain eint
>> registers in first regs entry and hardcode eint_res_idx to 0 for the
>> time being.
>
> I got with slight confusion.
> Do you mean that you want to remove the 'eint_res_idx' because
> it is always zero(0) as your comment. And do you agree to add 'pctl_res_idx'?
>
> Also, as you commented, the eint_res_idx for both GPA and GPFx is zero(0).
>
> Example:
>         pinctrl_alive: pinctrl at 10580000 {
>                 compatible = "samsung,exynos5433-pinctrl";
>                       /* ALIVE domain    ,  IMEM domain  */
>                 reg = <0x10580000 0x1a20>, <0x11090000 0x100>;
>
>                 wakeup-interrupt-controller {
>                         compatible = "samsung,exynos7-wakeup-eint";
>                         interrupts = <GIC_SPI 16 0>;
>                 };
>         };
>
>         GPA's eint_res_idx is 0
>         GPA's pctl_res_idx is 0
>
>         GPFx's eint_res_idx is 0
>         GPFx's pctl_res_idx is 1

Yeah, that's right. I just want to avoid adding eint_res_idx until it
is found to be really needed.

>
>
>  However it should be still beneficial to refactor the code
>> and calculate per-bank eint_base to avoid adding the offset every
>> time, similarly to pctl_base/offset, from my suggestion below.
>
> I agree. I'll modify it according to your comment.

Thanks. Looking forward to the patch.

Best regards,
Tomasz
