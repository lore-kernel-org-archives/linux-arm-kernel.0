From: wg@grandegger.com (Wolfgang Grandegger)
Date: Wed, 05 Dec 2012 19:44:55 +0100
Subject: [PATCH 0/6 v8] gpio: Add block GPIO
In-Reply-To: <50BE5F8A.2000903@antcom.de>
References: <1354298637-25058-1-git-send-email-stigge@antcom.de>
 <50BC6E11.3040203@grandegger.com> <50BE5F8A.2000903@antcom.de>
Message-ID: <50BF9627.4050102@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roland,

On 12/04/2012 09:39 PM, Roland Stigge wrote:
> Hi Wolfgang,
> 
> On 03/12/12 10:17, Wolfgang Grandegger wrote:
>> I re-tried v8 on my AT91-SAM9G45 board and it works fine if
>> CONFIG_GPIO_SYSFS is enable. Unfortunately, the access via misc device
>> fails if CONFIG_GPIO_SYSFS is not set. That's due to gpio_block_export()
>> returning -ENOSYS in gpio_block_register().
>>
>> Anyway, I really like that new GPIO block interface making life for
>> applications fiddling with GPIOs much easier and faster. Just the poll
>> support is missing.
> 
> Thanks for your feedback!
> 
> I'm posting an update (v9) which includes poll() support in the dev
> interface.

I just gave it a try and it was working after replacing
IRQF_TRIGGER_FALLING with 0 in the request_irq in the device open: 

  # ./gpio_block_test 
  mask=0x7e
  mask=0x7f
  mask=0x7d
  mask=0x7f
  mask=0x77
  mask=0x7f

Otherwise it get:

  # ./gpio_block_test 
  genirq: Setting trigger mode 2 for irq 86 failed (gpio_irq_type+0x0/0x18)
  can't open device /dev/gpiobuttons (Invalid argument)

Also opening with O_NONBLOCK works as expected.

> Some issues regarding IRQ driven poll() remain:
> 
> * What would be the correct locking mechanism for the got_int flag (set
> in the isr and reset on read()'s return), if necessary at all?

If you sync against the interrupt context, I think spin_lock_irqsave and
spin_unlock_irqrestore should be used.

> * There is probably an explicit interrupt configuration necessary (via
> struct gpio_block, and devicetree, respectively) since there are
> constellations where gpio_to_irq() isn't working. E.g., in contrast to
> controllers which are aware of their IRQs and providing to_irq(), there
> is typically independent wiring from GPIO expander chips' interrupt line
> to individual IRQ inputs on SoCs/CPUs. Or should all this be solved via
> devicetree and drivers (which should support IRQ config where possible)?

Yes, I think it's up to the device tree or platform code to properly setup
the interrupt... like for defining the GPIO block.

> * For the same reason, the IRQ flags are currently IRQF_TRIGGER_FALLING,
> which isn't flexible. Instead, either preset by board setup/firmware, or
> via interrupts config in devicetree (optional property of a GPIO block?)

Yes, and it did fail on my setup.

> * Some GPIOs' IRQs are not suitable for GPI input change detection. E.g.
> on LPC32xx, I can configure the IRQ which is controlled directly by the
> GPI's values as FALLING, RISING, HIGH /exclusive/ or LOW. I.e., this way
> it's not possible to detect both 0->1 and 1->0 changes without
> reconfiguring the GPIO controller inbetween. Other controllers provide a
> dedicated interrupt on all values changes.

Hm.

> * Would IRQF_SHARED be appropriate to enable opening IRQ enabled GPIO
> blocks multiple times?

Sounds reasonable for me. Some more comments in the patch mails...

Wolfgang.
