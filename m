From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Nov 2012 12:15:56 +0000
Subject: [PATCH v2] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <20121101232010.78269291@skate>
References: <1351805329-19576-1-git-send-email-linus.walleij@linaro.org>
 <20121101232010.78269291@skate>
Message-ID: <20121102121556.GV21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 11:20:10PM +0100, Thomas Petazzoni wrote:
> Linus,
> 
> On Thu,  1 Nov 2012 22:28:49 +0100, Linus Walleij wrote:
> 
> > +void fpga_handle_irq(struct pt_regs *regs);
> 
> This function does not need to be exposed in a public header: as
> proposed for the bcm2835 and armada-370-xp IRQ controller drivers, the
> driver should directly do handle_arch_irq = fpga_handle_irq, and
> therefore there is no need for the machine desc structure to reference
> fpga_handle_irq anymore.

Err no, then you don't understand what's going on here.  This may or may
not be a top-level IRQ handler.  Some ARM platforms have three of these
cascaded, others have one of these cascaded off a VIC or GIC.

To override the top level IRQ handler unconditionally is going to break
platforms.
