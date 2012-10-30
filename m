From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2012 23:30:15 +0100
Subject: [PATCH 1/3] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <50900C90.7070101@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
 <1351608860-24617-2-git-send-email-robherring2@gmail.com>
 <20121030160129.7e39619b@skate> <508FFADC.3080506@gmail.com>
 <50900C90.7070101@gmail.com>
Message-ID: <20121030233015.11652d08@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, 30 Oct 2012 12:21:20 -0500, Rob Herring wrote:

> > Right. I'll have to move it. I wasn't really thinking about arm64 until
> > this morning.
> 
> Looking at this some more, arm64 doesn't need most of what's in gic.h.
> The register defines should be moved into the .c file. The remaining
> function declarations either are not needed (i.e. gic_init) or should
> should be done like the handle_irq function pointer init. We don't want
> to have platform code calling gic_cascade_irq or gic_raise_softirq
> directly. Perhaps we need to support this generically in irqchip code.
> So I'll leave them in the current header and arm64 can add the necessary
> support it needs.

The thing is that we have the same problem for the armada-370-xp
IRQ controller driver. In its current form, it doesn't need to expose
any symbol to the mach-mvebu code except the initialization function.
However, with the SMP support, we need to expose a bunch of symbols,
which kind of violates the whole idea of the drivers/irqchip
infrastructure, which was aiming at limiting the number of header files
added in <linux/irqchip/...> for each and every IRQ controller driver.

As you say, we maybe need to support thing like yyy_raise_softirq()
generically in the irqchip code.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
