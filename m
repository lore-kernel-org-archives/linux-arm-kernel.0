From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 11 Sep 2013 09:05:57 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <522F3408.6050608@ti.com>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <51F8CC35.1070704@collabora.co.uk> <522EC392.8070002@ti.com>
 <522F1BF0.8080608@collabora.co.uk> <522F3408.6050608@ti.com>
Message-ID: <52301655.6080801@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.09.2013 17:00, schrieb Joel Fernandes:

> I think your initial patch is much better than fixing up DT but then I may be
> missing other problems with your patch that Linus's patch addresses.

The initial patch had the problem that it not only did introduce 
irq-mappings for only those gpios which are marked as IRQs, but it 
requested those gpios too and preconfigured them

And that breaks every driver which uses gpios for IRQs.

To summarize what happens if a driver uses a gpio as irq:

gpio_request() // This works only if the gpio was not requested before
gpio_direction_input()
gpio_to_irq() // This needs an irq-mapping
request_threaded_irq()

So I would suggest multiple steps to change that:

1. Create a mapping for every gpio found in DT (or all gpios if no DT is 
used). I think that is what Linus patch does (sorry, I haven't really 
followed this thread and didn't look in deep at the patch).

2. Implement gpio_request_for_irq()
This would just be a small macro for gpio_request(); gpio_direction_input()

3. Change all drivers which do use gpio_to_irq() to use 
gpio_request_for_irq() instead of gpio_request() and 
gpio_direction_input(). This will end up with a big series of more or 
less trivial patches (I count 677 occurences of gpio_to_irq) and might 
be splitted.

4. request gpios and set them to input when a gpio is marked as an IRQ 
in the DT and DT is used. Change gpio_rquest_for_irq() to a NOP if DT is 
used or leave it as it is for the none-dt case.


Regards,

Alexander Holler
