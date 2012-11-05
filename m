From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Nov 2012 22:42:26 +0000
Subject: [PATCH v2] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <50983422.9090301@gmail.com>
References: <1351805329-19576-1-git-send-email-linus.walleij@linaro.org>
 <20121102121556.GV21164@n2100.arm.linux.org.uk> <50983422.9090301@gmail.com>
Message-ID: <201211052242.26894.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 November 2012, Rob Herring wrote:
> But this should work:
> 
> if (!handle_arch_irq)
>         handle_arch_irq = fpga_handle_irq;
> 
> As long as the primary controller is always initialized first, this will
> work. This is guaranteed by DT of_irq_init, and you will probably have
> other problems if that wasn't the case for non-DT.

How about adding a top-level function in arch/arm that does the assignment
and hides the handle_arch_irq variable:

void set_handle_irq(void (*handle_irq)(struct pt_regs *))
{
	if (WARN_ON(handle_arch_irq))
		return;

	handle_arch_irq = handle_irq;
}
EXPORT_SYMBOL_GPL(set_handle_irq);

Hmm, maybe putting the top-level handler into a loadable module is a bit
far-fetched, but one can hope ;-)

	Arnd
