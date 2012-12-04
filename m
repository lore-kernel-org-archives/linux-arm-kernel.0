From: stigge@antcom.de (Roland Stigge)
Date: Tue, 04 Dec 2012 21:39:38 +0100
Subject: [PATCH 0/6 v8] gpio: Add block GPIO
In-Reply-To: <50BC6E11.3040203@grandegger.com>
References: <1354298637-25058-1-git-send-email-stigge@antcom.de>
 <50BC6E11.3040203@grandegger.com>
Message-ID: <50BE5F8A.2000903@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfgang,

On 03/12/12 10:17, Wolfgang Grandegger wrote:
> I re-tried v8 on my AT91-SAM9G45 board and it works fine if
> CONFIG_GPIO_SYSFS is enable. Unfortunately, the access via misc device
> fails if CONFIG_GPIO_SYSFS is not set. That's due to gpio_block_export()
> returning -ENOSYS in gpio_block_register().
> 
> Anyway, I really like that new GPIO block interface making life for
> applications fiddling with GPIOs much easier and faster. Just the poll
> support is missing.

Thanks for your feedback!

I'm posting an update (v9) which includes poll() support in the dev
interface.

Some issues regarding IRQ driven poll() remain:

* What would be the correct locking mechanism for the got_int flag (set
in the isr and reset on read()'s return), if necessary at all?
* There is probably an explicit interrupt configuration necessary (via
struct gpio_block, and devicetree, respectively) since there are
constellations where gpio_to_irq() isn't working. E.g., in contrast to
controllers which are aware of their IRQs and providing to_irq(), there
is typically independent wiring from GPIO expander chips' interrupt line
to individual IRQ inputs on SoCs/CPUs. Or should all this be solved via
devicetree and drivers (which should support IRQ config where possible)?
* For the same reason, the IRQ flags are currently IRQF_TRIGGER_FALLING,
which isn't flexible. Instead, either preset by board setup/firmware, or
via interrupts config in devicetree (optional property of a GPIO block?)
* Some GPIOs' IRQs are not suitable for GPI input change detection. E.g.
on LPC32xx, I can configure the IRQ which is controlled directly by the
GPI's values as FALLING, RISING, HIGH /exclusive/ or LOW. I.e., this way
it's not possible to detect both 0->1 and 1->0 changes without
reconfiguring the GPIO controller inbetween. Other controllers provide a
dedicated interrupt on all values changes.
* Would IRQF_SHARED be appropriate to enable opening IRQ enabled GPIO
blocks multiple times?

Thanks,

Roland
