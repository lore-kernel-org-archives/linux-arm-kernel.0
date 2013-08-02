From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 02 Aug 2013 11:57:38 +0200
Subject: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
In-Reply-To: <51F8CC35.1070704@collabora.co.uk>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <51F8CC35.1070704@collabora.co.uk>
Message-ID: <51FB8292.9090000@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.07.2013 10:35, schrieb Javier Martinez Canillas:

>
> The problem is that board files and drivers that has not not been completed
> migrated to DT assumes (at least for OMAP) that *every* GPIO line is mapped as
> an IRQ and they just do:
>
> gpio_request(gpio,...);
> gpio_direction_input()
> request[_threaded]_irq(gpio_to_irq(gpio), ...);
>
> My patch-set changed the gpio-omap driver to not map all GPIO lines but only the
> ones that were really used as an IRQ and let the DT core to do the mapping from
> irq_create_of_mapping(). The first problem reported with the OMAP patch was that
> a driver was using the above sequence and that the GPIO had not been mapped.
> This user was booting with DT and so this showed a bug in the driver and a DT
> that did not conform with the standard schema used in mainline but this shows a
> potential issue.

There must have been a bug in the patch too. I've also added that 
iinterrupt-parent stuff (with the same flags as used by the driver) and 
just have let the driver call

request_threaded_irq(gpio_to_irq(gpio), flags);

without the gpio_request()/input() before. And request_threaded_irq() 
returned -EBUSY. I'm pretty sure nothing else did use that gpio, but I 
haven't looked at why request_threaded_irq() returned -EBUSY. I assume 
the new mapping stuff did reserve the irq in such a way, that the driver 
couldn't request the IRQ.

Otherwise I wouldn't have had a problem by just adding the necessary 
entries to the DT.

But I have to say I didn't like the syntax too, and it wasn't obvious 
how the syntax is and how to conclude from a gpio number to an 
irq-number and the patch didn't really include some documentation or 
useful example.

Regards,

Alexander Holler
