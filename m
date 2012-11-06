From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Nov 2012 14:38:16 +0000
Subject: [PATCH v2] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <20121105231410.GK28327@n2100.arm.linux.org.uk>
References: <1351805329-19576-1-git-send-email-linus.walleij@linaro.org>
 <201211052242.26894.arnd@arndb.de>
 <20121105231410.GK28327@n2100.arm.linux.org.uk>
Message-ID: <201211061438.16395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 November 2012, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2012 at 10:42:26PM +0000, Arnd Bergmann wrote:
> > On Monday 05 November 2012, Rob Herring wrote:
> > > But this should work:
> > > 
> > > if (!handle_arch_irq)
> > >         handle_arch_irq = fpga_handle_irq;
> > > 
> > > As long as the primary controller is always initialized first, this will
> > > work. This is guaranteed by DT of_irq_init, and you will probably have
> > > other problems if that wasn't the case for non-DT.
> > 
> > How about adding a top-level function in arch/arm that does the assignment
> > and hides the handle_arch_irq variable:
> > 
> > void set_handle_irq(void (*handle_irq)(struct pt_regs *))
> > {
> >       if (WARN_ON(handle_arch_irq))
> >               return;
> > 
> >       handle_arch_irq = handle_irq;
> > }
> > EXPORT_SYMBOL_GPL(set_handle_irq);
> > 
> > Hmm, maybe putting the top-level handler into a loadable module is a bit
> > far-fetched, but one can hope ;-)
> 
> Definitely no point in exporting this (never export a symbol unless you
> really want to use it from a module) - if you don't already have something
> in handle_arch_irq, you're not going to get anywhere near the module
> loader.

Yes, I agree. While I think we might theoretically get to the point where
even the main IRQ handler can be in a module loaded from initramfs, we
are not anywhere close to that now, and it would be better to just export
the symbol once it actually gets used that way.

The one case where I think we might use it earlier is when we have an irq
chip driver that can be either a primary or a secondary chip. It has
to call set_handle_irq() in the former case (as a built-in driver), but
could be a module in the latter case. If this actually happens, we might
want to export the symbol rather than adding an "#ifdef MODULE" in the
driver.

	Arnd
