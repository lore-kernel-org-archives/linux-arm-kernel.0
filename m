From: hrhaan@gmail.com (Harro Haan)
Date: Thu, 28 Jan 2010 13:52:17 +0100
Subject: [patch 2/2] at91_udc.c use spinlocks instead of local_irq_xxx
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020E94E2@mi8nycmail19.Mi8.com>
References: <20100127163000.406832266@gmail.com>
	<20100127163115.337384288@gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E94E2@mi8nycmail19.Mi8.com>
Message-ID: <6681f8e11001280452l2f819b17x97213ff510366f52@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hartley,

Thanks for the feedback.

> For consistency (and better grepping) it would be better to keep the same use throughout the file.

I agree on the naming consistency. I reused the variable when it was already
present, but will make it consistent.

> This one should be &udc->lock

Yes, the spin_lock_irqsave() in proc_ep_show() is incorrect. It compiled because
CONFIG_USB_GADGET_DEBUG_FILES is not defined. Will fix this.

> Strange unlock/lock sequence.

This trick is used to avoid recursive locking. It is also used in:
amd5536udc.c, atmel_usba_udc.c, ci3xxx_udc.c, fsl_qe_udc.c,
fsl_udc_core.c, goku_udc.c, lh7a40x_udc.c, m66592-udc.c and omap_udc.c

> Who does the initial locking and who does the final unlock?

The unlock/lock sequence is used by the following functions:

handle_setup() _ handle_ep0() _ at91_udc_irq()

stop_activity() _ pullup() (only called with spinlock)
stop_activity() _ at91_udc_irq()

done() _ read_fifo() _ at91_ep_queue() (uses spinlock)
done() _ read_fifo() _ handle_ep() _ handle_setup() _ handle_ep0() _
at91_udc_irq()
done() _ read_fifo() _ handle_ep() _ handle_ep0() _ at91_udc_irq()
done() _ read_fifo() _ handle_ep() _ at91_udc_irq()
done() _ write_fifo() _ at91_ep_queue() (uses spinlock)
done() _ write_fifo() _ handle_ep() _ handle_setup() _ handle_ep0() _
at91_udc_irq()
done() _ write_fifo() _ handle_ep() _ handle_ep0() _ at91_udc_irq()
done() _ write_fifo() _ handle_ep() _ at91_udc_irq()
done() _ nuke() _ stop_activity() _ pullup() (only called with spinlock)
done() _ nuke() _ stop_activity() _ at91_udc_irq()
done() _ nuke() _ handle_ep0() _ at91_udc_irq()
done() _ nuke() _ at91_ep_disable() (uses spinlock)
done() _ at91_ep_dequeue() (uses spinlock)
done() _ handle_ep0() _ at91_udc_irq()

> You are in an irq path.  Is this locking and the unlock/lock below really needed?

Yes, to avoid recursive locking.

udc->driver->suspend() = at91udc_suspend() (uses spinlock)
udc->driver->resume() = at91udc_resume() (uses spinlock)

Regards,

Harro
