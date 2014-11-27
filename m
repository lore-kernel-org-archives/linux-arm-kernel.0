From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 27 Nov 2014 23:03:10 +0100 (CET)
Subject: [PATCH] ARM: pxa: fix lubbock interrupts handling
In-Reply-To: <1417113721-9062-1-git-send-email-robert.jarzmik@free.fr>
References: <1417113721-9062-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <alpine.DEB.2.11.1411272258010.3961@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014, Robert Jarzmik wrote:

> When gpio-pxa was moved to drivers/pxa, it became a driver, and its
> initialization and probing happen at postcore initcall. The lubbock code
> used to install the chained lubbock interrupt handler at init_irq()
> time.
> 
> The consequence of the gpio-pxa change is that the installed chained irq
> handler lubbock_irq_handler() was overwritten in pxa_gpio_probe(_dt)(),
> removing :
>  - the handler
>  - the falling edge detection setting of GPIO0, which revealed the
>    interrupt request from the lubbock IO board.
>
> As a fix, move the gpio0 chained handler setup to a place where we have
> the guarantee that pxa_gpio_probe() was called before, so that lubbock
> handler becomes the true IRQ chained handler of GPIO0, demuxing the
> lubbock IO board interrupts.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> For Thomas: as a side note, I'm not very happy with this patch. What
>             makes me unhappy is that I don't know how to express the
>             dependency between gpio-pxa probe time and
>             irq_set_chained_handler(irq, lubbock_irq_handler).
> 
>             At the moment I rely on the fact that
>             lubbock_irq_device_init() is called as device initcall while
>             pxa_gpio_probe() is called as postcore initcall.

Admittedly I'm confused.

So what is the relationship between installing that chained handler
and that gpio-pxa probe stuff?

And why is the GPIO0 interrupt handled from arch code rather than from
a regular driver setup, which depends on the availablity of the GPIO
driver?

Thanks,

	tglx
