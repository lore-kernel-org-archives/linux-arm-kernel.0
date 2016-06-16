From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jun 2016 11:53:12 +0200
Subject: [PATCH] Revert "gpio: bail out silently on NULL descriptors"
In-Reply-To: <5762701C.4060409@ti.com>
References: <1466014954-17956-1-git-send-email-hdegoede@redhat.com>
 <20160615184628.GA5144@lukather>
 <3a03fc91-b339-3e43-4e95-e1488197a8df@redhat.com>
 <5762701C.4060409@ti.com>
Message-ID: <CACRpkdbvhobvSvqifqKQFvsDqALVFUhj_8rtaAWbEFYJrug6yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 11:23 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 06/15/2016 10:08 PM, Hans de Goede wrote:

>>>> This commit causes the following code to fail:
>>>>
>>>> gpio_desc = devm_gpiod_get_optional(dev, ...);
>
> May be I missed smth., but in this example gpio_desc may contain err code.
>
>>>> gpio_irq  = gpiod_to_irq(gpio_desc);
> which, most probably will cause gpiod_to_irq() to crash
>         if (!desc) \
>                 return 0; \
>         if (!desc->gdev) { \
> ^^^^^^^^^^^^^ here

Hm good catch. These optional GPIOs may never have worked properly,
good that they are so rare :/

I'll send a separate patch making some IS_ERR() checks.

Yours,
Linus Walleij
