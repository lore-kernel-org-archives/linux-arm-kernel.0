From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 31 May 2012 10:21:24 +0200
Subject: [RFC PATCH 0/2] Remove at91 workaround from handle_IRQ
In-Reply-To: <1338449901-10288-1-git-send-email-will.deacon@arm.com>
References: <1338449901-10288-1-git-send-email-will.deacon@arm.com>
Message-ID: <4FC72A04.3040504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Le 05/31/2012 09:38 AM, Will Deacon a ?crit :
> Hello,
>
> This is a couple of patches that I wrote quickly to try and remove the
> irq_finish hook from handle_IRQ on ARM. Currently, the hook is only used
> by at91 in order to issue an EOI when using level_irq flow control.
>
> This patch moves the at91 irq_chip to fasteoi flow control, removing the
> need for the additional hook. Since I (a) don't know anything about at91
> (the TRM I found for the IRQ controller is only a few pages long) and (b)
> don't have a platform on which to test, this is very much an RFC series.
>
> All comments welcome.
>
> Will

I have sent a patch with the same purpose a few days ago: 
http://comments.gmane.org/gmane.linux.ports.arm.kernel/169371

The content of our patches is really close:
- I missed the remove of irq_finish macro in arch/arm/irq/kernel.c
- AIC don't care about the value written into AT91_AIC_EOICR, I don't 
know if it's better to write 0 or a precise value as you did.
- I didn't remove irq_ack but you're right it's no more useful.
- You missed gpio part, it has to use fasteoi flow control also.

I have also to remove some comments so I can send a second version and 
add what I missed the first time if you have no objections.


> Cc: Arnd Bergmann<arnd@arndb.de>
> Cc: Jean-Christophe Plagniol-Villard<plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
>
> Will Deacon (2):
>    ARM: at91: use EOI flow control for interrupt handling
>    ARM: irq: remove unused irq_finish hook from core interrupt handling
>
>   arch/arm/kernel/irq.c                  |   10 ----------
>   arch/arm/mach-at91/include/mach/irqs.h |    8 --------
>   arch/arm/mach-at91/irq.c               |   12 +++++++++---
>   3 files changed, 9 insertions(+), 21 deletions(-)
>

Regards

Ludovic
