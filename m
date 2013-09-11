From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 11 Sep 2013 09:36:11 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <52301C13.2030103@ahsoftware.de>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <51F8CC35.1070704@collabora.co.uk> <522EC392.8070002@ti.com>
 <522F1BF0.8080608@collabora.co.uk> <522F3408.6050608@ti.com>
 <52301655.6080801@ahsoftware.de> <523018DB.7080004@ahsoftware.de>
 <52301C13.2030103@ahsoftware.de>
Message-ID: <52301D6B.70305@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.09.2013 09:30, schrieb Alexander Holler:
> And another small update. ;)
>
> Am 11.09.2013 09:16, schrieb Alexander Holler:
>
>>> To summarize what happens if a driver uses a gpio as irq:
>>>
>>> gpio_request() // This works only if the gpio was not requested before
>>> gpio_direction_input()
>>> gpio_to_irq() // This needs an irq-mapping
>>> request_threaded_irq()
>>>
>>> So I would suggest multiple steps to change that:
>>>
>>> 1. Create a mapping for every gpio found in DT (or all gpios if no DT is
>>> used). I think that is what Linus patch does (sorry, I haven't really
>>> followed this thread and didn't look in deep at the patch).
>>>
>>> 2. Implement gpio_request_for_irq()
>>> This would just be a small macro for gpio_request();
>>> gpio_direction_input()
>>>
>
> I would add gpio_to_irq() to that macro, so that it returns the irq
> number or zero if something failed.

Doing that, it would be easy to mark gpio_to_irq() as deprecated and 
driver authors would change automatically to use gpio_request_for_irq()
(or gpio_request_as_irq() which might more correct english).

So I would suggest just the two steps above, the first with the mapping 
and the second which introduces gpio_request_as_irq() and marks 
gpio_to_irq() as deprecated.

Everthing else I would leave out for the future (so I wouldn't request 
gpios centrally).

Regards,

Alexander Holler
