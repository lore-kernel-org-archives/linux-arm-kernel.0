From: cywang@google.com (=?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?=)
Date: Fri, 11 Sep 2015 19:22:41 +0800
Subject: [PATCH v4] pinctrl: mediatek: Implement wake handler and suspend
 resume
In-Reply-To: <55EF11E6.7030307@arm.com>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
 <55DB4609.5040904@arm.com>
 <CAGS+omBnoitju07KQ1Y7JHTbce6+DO4WqWHTaKz5D+T157zEJA@mail.gmail.com>
 <1441535972.22230.5.camel@mhfsdcap03> <55EEAA24.6080706@arm.com>
 <55EF11E6.7030307@arm.com>
Message-ID: <CAM2ehZaDwQtckXcDQQh+XkYKXvVzy-6Tp+kdvRku0w2xVibPtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep and Maoguang,

   Please correct me if I am wrong. I think the wake_mask Maoguang
implemented is the wake-up configuration and it is how he disabled
other unwanted interrupt sources(e.g. audio jacket insertion) during
suspend.

  With Sudeep's patch which we had similar one before, the system got
waken up by audio jack insertion which we don't want. Maoguang tried
to implement wake_mask as the wake-up configuration to keep track of
effective wakeup sources(i.e. those who makes enable_irq_wake) and
write the wake-up configuration in mtk_eint_suspend(). What is your
suggestion to address this issue? Thanks!

On Wed, Sep 9, 2015 at 12:50 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 08/09/15 10:28, Sudeep Holla wrote:
>>
>>
>>
>> On 06/09/15 11:39, maoguang meng wrote:
>>>
>>> On Wed, 2015-09-02 at 14:02 +0800, Daniel Kurtz wrote:
>>>>
>>>> Hi maoguang,
>>>>
>>>> On Tue, Aug 25, 2015 at 12:27 AM, Sudeep Holla <sudeep.holla@arm.com>
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 14/08/15 09:38, maoguang.meng at mediatek.com wrote:
>>>>>>
>>>>>>
>>>>>> From: Maoguang Meng <maoguang.meng@mediatek.com>
>>>>>>
>>>>>> This patch implement irq_set_wake to get who is wakeup source and
>>>>>> setup on suspend resume.
>>>>>>
>>>>>> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
>>>>>>
>>>> [snip]
>>>>
>>>> Can you please respond to Sudeep's questions:
>>>>
>>>>> Does this pinmux controller:
>>>>>
>>>>> 1. Support wake-up configuration ? If not, you need to use
>>>>>      IRQCHIP_SKIP_SET_WAKE. I don't see any value in writing the
>>>>>      mask_{set,clear} if the same registers are used for {en,dis}able
>>>
>>>
>>>     YES.
>>>     we can call enable_irq_wake(irq) to config this irq as a wake-up
>>> source.
>>>
>>
>> No that doesn't answer my question. Yes you can always call
>> enable_irq_wake(irq) as along as you have irq_set_wake implemented.
>> But my question was does this pinmux controller support wake-up
>> configuration.
>>
>> IMHO, by looking at the implementation I can confirm *NO*, it doesn't.
>> So please stop copy-pasting the implementation from other drivers.
>> The reason is you operate on the same mask_{set,clear} which you use
>> to {en,dis}able the interrupts which means you don't have to do anything
>> to configure an interrupt as a wakeup source other than just keeping
>> them enabled. Hopefully this clarifies.
>>
>>>>>
>>>>> 2. Is in always on domain ? If not, you need save/restore only to
>>>>>      resume back the functionality. Generally we can set
>>>>>      IRQCHIP_MASK_ON_SUSPEND to ensure non-wake-up interrupts are
>>>>>      disabled during suspend and re-enabled in resume path. You just
>>>>>      save/restore raw values without tracking the wake-up source.
>>>
>>>
>>>     YES.
>>>
>>
>> Again *YES* for what part of my question. If it's always-on, then you
>> don't need this suspend/resume callbacks at all, so I assume the answer
>> is *NO*.
>>
>
> IIUC this pinmux controller, something like below should work.
>
>
> ---->8
>
> From 7c26992bce047efb66a6ba8d2ffec2b272499df7 Mon Sep 17 00:00:00 2001
> From: Sudeep Holla <sudeep.holla@arm.com>
> Date: Tue, 8 Sep 2015 17:35:38 +0100
> Subject: [PATCH] pinctrl: mediatek: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
>
> The mediatek pinmux controller doesn't provides any facility to configure
> the wakeup sources. So instead of providing redundant irq_set_wake
> functionality, SKIP_SET_WAKE could be set to it. Also there's no need to
> maintain 2 sets of masks.
>
> This patch enables IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND and
> also removes wake_mask.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Maoguang Meng <maoguang.meng@mediatek.com>
> Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-mediatek at lists.infradead.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 24 +-----------------------
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  1 -
>  2 files changed, 1 insertion(+), 24 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 7726c6caaf83..d8e194a5bb31 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -1063,20 +1063,6 @@ static int mtk_eint_set_type(struct irq_data *d,
>         return 0;
>  }
>
> -static int mtk_eint_irq_set_wake(struct irq_data *d, unsigned int on)
> -{
> -       struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> -       int shift = d->hwirq & 0x1f;
> -       int reg = d->hwirq >> 5;
> -
> -       if (on)
> -               pctl->wake_mask[reg] |= BIT(shift);
> -       else
> -               pctl->wake_mask[reg] &= ~BIT(shift);
> -
> -       return 0;
> -}
> -
>  static void mtk_eint_chip_write_mask(const struct mtk_eint_offsets *chip,
>                 void __iomem *eint_reg_base, u32 *buf)
>  {
> @@ -1112,7 +1098,6 @@ static int mtk_eint_suspend(struct device *device)
>
>         reg = pctl->eint_reg_base;
>         mtk_eint_chip_read_mask(eint_offsets, reg, pctl->cur_mask);
> -       mtk_eint_chip_write_mask(eint_offsets, reg, pctl->wake_mask);
>
>         return 0;
>  }
> @@ -1153,9 +1138,9 @@ static struct irq_chip mtk_pinctrl_irq_chip = {
>         .irq_unmask = mtk_eint_unmask,
>         .irq_ack = mtk_eint_ack,
>         .irq_set_type = mtk_eint_set_type,
> -       .irq_set_wake = mtk_eint_irq_set_wake,
>         .irq_request_resources = mtk_pinctrl_irq_request_resources,
>         .irq_release_resources = mtk_pinctrl_irq_release_resources,
> +       .flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
>  };
>
>  static unsigned int mtk_eint_init(struct mtk_pinctrl *pctl)
> @@ -1393,13 +1378,6 @@ int mtk_pctrl_init(struct platform_device *pdev,
>         }
>
>         ports_buf = pctl->devdata->eint_offsets.ports;
> -       pctl->wake_mask = devm_kcalloc(&pdev->dev, ports_buf,
> -                                       sizeof(*pctl->wake_mask),
> GFP_KERNEL);
> -       if (!pctl->wake_mask) {
> -               ret = -ENOMEM;
> -               goto chip_error;
> -       }
> -
>         pctl->cur_mask = devm_kcalloc(&pdev->dev, ports_buf,
>                                         sizeof(*pctl->cur_mask),
> GFP_KERNEL);
>         if (!pctl->cur_mask) {
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> index 55a534338931..acd804a945d8 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> @@ -267,7 +267,6 @@ struct mtk_pinctrl {
>         void __iomem            *eint_reg_base;
>         struct irq_domain       *domain;
>         int                     *eint_dual_edges;
> -       u32 *wake_mask;
>         u32 *cur_mask;
>  };
>
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
