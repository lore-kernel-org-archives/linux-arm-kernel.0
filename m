From: slash.tmp@free.fr (Mason)
Date: Tue, 01 Sep 2015 18:14:16 +0200
Subject: Porting MIPS IRQ handler to ARM
Message-ID: <55E5CED8.7000408@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to port to my ARM platform: IRQ handling code written for MIPS.

https://github.com/mansr/linux-tangox/blob/master/drivers/irqchip/irq-tangox.c

static void tangox_irq_handler(unsigned int irq, struct irq_desc *desc)
{
	struct irq_domain *dom = irq_desc_get_handler_data(desc);
	struct tangox_irq_chip *chip = dom->host_data;
	unsigned int status, status_hi;
	unsigned int sr = 0;

	status = intc_readl(chip, chip->ctl + IRQ_STATUS);
	status_hi = intc_readl(chip, chip->ctl + IRQ_CTL_HI + IRQ_STATUS);

	if (!(status | status_hi)) {
		spurious_interrupt();
		return;
	}

	if (chip->mask)
		sr = clear_c0_status(chip->mask);

	tangox_dispatch_irqs(dom, status, 0);
	tangox_dispatch_irqs(dom, status_hi, 32);

	if (chip->mask)
		write_c0_status(sr);
}

  CC      drivers/irqchip/irq-tangox.o
drivers/irqchip/irq-tangox.c: In function 'tangox_irq_handler':
drivers/irqchip/irq-tangox.c:85:3: error: implicit declaration of function 'spurious_interrupt' [-Werror=implicit-function-declaration]
   spurious_interrupt();
   ^
drivers/irqchip/irq-tangox.c:90:3: error: implicit declaration of function 'clear_c0_status' [-Werror=implicit-function-declaration]
   sr = clear_c0_status(chip->mask);
   ^
drivers/irqchip/irq-tangox.c:96:3: error: implicit declaration of function 'write_c0_status' [-Werror=implicit-function-declaration]
   write_c0_status(sr);
   ^
drivers/irqchip/irq-tangox.c: In function 'tangox_irq_init':
drivers/irqchip/irq-tangox.c:205:41: error: 'STATUSB_IP2' undeclared (first use in this function)
  chip->mask = ((1 << (irq - 2)) - 1) << STATUSB_IP2;
                                         ^
drivers/irqchip/irq-tangox.c:205:41: note: each undeclared identifier is reported only once for each function it appears in


In arch/mips/kernel/irq.c

atomic_t irq_err_count;

int arch_show_interrupts(struct seq_file *p, int prec)
{
	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
	return 0;
}

asmlinkage void spurious_interrupt(void)
{
	atomic_inc(&irq_err_count);
}


In arch/arm/kernel/irq.c

unsigned long irq_err_count;

int arch_show_interrupts(struct seq_file *p, int prec)
{
#ifdef CONFIG_FIQ
	show_fiq_list(p, prec);
#endif
#ifdef CONFIG_SMP
	show_ipi_list(p, prec);
#endif
	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
	return 0;
}

static inline void ack_bad_irq(int irq)
{
	extern unsigned long irq_err_count;
	irq_err_count++;
	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
}


Replacing spurious_interrupt() with ack_bad_irq() doesn't feel correct.
(Writing to the console from an IRQ handler can't be good?)

It's the same interrupt controller hardware on the MIPS and ARM platforms.
Are there platform-agnostic / generic alternatives?


In arch/mips/include/asm/mipsregs.h

/*
 * Manipulate bits in a c0 register.
 */
#define __BUILD_SET_C0(name)
set_c0_##name
clear_c0_##name
change_c0_##name
__BUILD_SET_C0(status)

#define read_c0_status()	__read_32bit_c0_register($12, 0)
#define write_c0_status(val)	__write_32bit_c0_register($12, 0, val)

Obviously very platform-specific...
Guess I'll have to take a look@the MIPS programmer's guide.

Regards.
