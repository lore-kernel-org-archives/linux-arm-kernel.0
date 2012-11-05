From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2012 23:14:10 +0000
Subject: [PATCH v2] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <201211052242.26894.arnd@arndb.de>
References: <1351805329-19576-1-git-send-email-linus.walleij@linaro.org>
 <20121102121556.GV21164@n2100.arm.linux.org.uk> <50983422.9090301@gmail.com>
 <201211052242.26894.arnd@arndb.de>
Message-ID: <20121105231410.GK28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 10:42:26PM +0000, Arnd Bergmann wrote:
> On Monday 05 November 2012, Rob Herring wrote:
> > But this should work:
> > 
> > if (!handle_arch_irq)
> >         handle_arch_irq = fpga_handle_irq;
> > 
> > As long as the primary controller is always initialized first, this will
> > work. This is guaranteed by DT of_irq_init, and you will probably have
> > other problems if that wasn't the case for non-DT.
> 
> How about adding a top-level function in arch/arm that does the assignment
> and hides the handle_arch_irq variable:
> 
> void set_handle_irq(void (*handle_irq)(struct pt_regs *))
> {
> 	if (WARN_ON(handle_arch_irq))
> 		return;
> 
> 	handle_arch_irq = handle_irq;
> }
> EXPORT_SYMBOL_GPL(set_handle_irq);
> 
> Hmm, maybe putting the top-level handler into a loadable module is a bit
> far-fetched, but one can hope ;-)

Definitely no point in exporting this (never export a symbol unless you
really want to use it from a module) - if you don't already have something
in handle_arch_irq, you're not going to get anywhere near the module
loader.
