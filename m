From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 21 Jan 2015 22:39:54 +0100
Subject: [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()
In-Reply-To: <1421448650-15904-1-git-send-email-tony@atomide.com>
References: <1421448650-15904-1-git-send-email-tony@atomide.com>
Message-ID: <CABxcv=nE8F7Jjy3Ojf_PE6LEDi_H2tZSbAwpeu+3spP4zF==RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

On Fri, Jan 16, 2015 at 11:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> Similar to omap_gpio_irq_type() let's make sure that the GPIO
> is usable as an interrupt if the platform init code did not
> call gpio_request(). Otherwise we can get invalid device access
> after setup_irq():
>
> WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access in Supervisor mode during Functional access
> ...
> [<c05f21e4>] (__irq_svc) from [<c05f1974>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [<c05f1974>] (_raw_spin_unlock_irqrestore) from [<c00914a8>] (__setup_irq+0x244/0x530)
> [<c00914a8>] (__setup_irq) from [<c00917d4>] (setup_irq+0x40/0x8c)
> [<c00917d4>] (setup_irq) from [<c0039c8c>] (omap_system_dma_probe+0x1d4/0x2b4)
> [<c0039c8c>] (omap_system_dma_probe) from [<c03b2200>] (platform_drv_probe+0x44/0xa4)
> ...
>
> We can fix this the same way omap_gpio_irq_type() is handling it.
>

I see that Linus already picked this patch but fwiw:

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

> Note that the long term solution is to change the gpio-omap driver
> to handle the banks as separate driver instances. This will allow
> us to rely on just runtime PM for tracking the bank specific state.
>

Agreed.

Best regards,
Javier
