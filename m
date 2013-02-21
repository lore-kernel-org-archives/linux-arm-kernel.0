From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 20:12:30 +0100
Subject: [PATCH v3 10/12] gpio: pxa: add irq base in platform data
In-Reply-To: <1361164358-5845-11-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdbgJdmcTm86UTWsMw2yPv005=1c8AmAxfmDSrEoSWk-bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Macro PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() is used in machine driver
> without DT. Although we're allocating irq descriptions dynamically,
> it may break machine drivers without DT. Append pdata->irq_base.
> If irq_base is valid, allocate irq descriptions from irq_base.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
(...)
> -               chips[i].irq_base = irq_alloc_descs(-1, 0, gc->ngpio, 0);
> +               if (pdata->irq_base)
> +                       irq_base = pdata->irq_base + gpio;
> +               else
> +                       irq_base = -1;
> +               chips[i].irq_base = irq_alloc_descs(irq_base, 0, gc->ngpio, 0);
>                 if (chips[i].irq_base < 0)
>                         return -EINVAL;
>                 if (!irq_domain_add_legacy(pdev->dev.of_node, gc->ngpio,

In this case, when you want to pass a base IRQ, use
irq_domain_add_simple().

The descriptor allocation will still be unnecessary.

Yours,
Linus Walleij
