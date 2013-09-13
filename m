From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 10:35:26 +0200
Subject: [PATCH 3/7] misc: ixp4-beeper: use gpiolib strictly
In-Reply-To: <522FCE28.8020909@nvidia.com>
References: <1378816226-8016-1-git-send-email-linus.walleij@linaro.org>
 <522FCE28.8020909@nvidia.com>
Message-ID: <CACRpkdamJBKPcCCi0U6C7SY8fD9pR9-e+_k9EGHXLyAfcRvcQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 3:58 AM, Alex Courbot <acourbot@nvidia.com> wrote:
> On 09/10/2013 09:30 PM, Linus Walleij wrote:
>>         /* flip the beeper output */
>> -       *IXP4XX_GPIO_GPOUTR ^= (1 << (unsigned int) dev_id);
>> +       gpio_set_value(pin, ~gpio_get_value(pin));
>
>
> Don't you want
>
>         gpio_set_value(pin, !gpio_get_value(pin));
>
> instead? From the deleted line I suppose you guess to invert the GPIO value,
> but using ~ will invert all the bits of the integer returned by
> gpio_get_value(), meaning that if it returns 1 you will end up calling
> gpio_set_value(-2). In practice your gpio is very unlikely to ever be set to
> 0.

You're right, fixed this.

>>         free_irq(IRQ_IXP4XX_TIMER2, (void *)dev->id);
>> +       gpio_free(dev->id);
>
>
> Just wondering, is there a reason for not using the devm_gpio functions
> here?

I didn't want to change the style of the whole driver, but I can make
a separate patch switching the whole driver to use managed
resources at some later point.

Yours,
Linus Walleij
