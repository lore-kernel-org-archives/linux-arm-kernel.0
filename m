From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 29 Oct 2009 13:30:47 -0700
Subject: Fwd: [PATCH] iop13xx: workaround errata that causes uart interrupts
	to be missed
In-Reply-To: <1256843340.28922.14.camel@dwillia2-linux.ch.intel.com>
References: <1256843340.28922.14.camel@dwillia2-linux.ch.intel.com>
Message-ID: <e9c3a7c20910291330u17a33520reff44322d8bc8983@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ per Russell's note forwarding to Alan / LKML ]

---------- Forwarded message ----------
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, Oct 29, 2009 at 12:09 PM
Subject: [PATCH] iop13xx: workaround errata that causes uart
interrupts to be missed
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>, Lennert Buytenhek
<buytenh@wantstofly.org>


Reading the uart iir register sometimes results in the interrupt being
cleared without being reported. ?Use the the system interrupt pending
register as a fallback.

This converts locations in the code that only care about the interrupt
pending bit to use the iir_int_status() macro.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
This patch has been sitting in the 'misc' branch of the xscaleiop tree
in an un-mergeable form for quite a while [1]. ?I finally got fed up
with forward porting it and would like to try to get this workaround
upstream. ?There appears to be no maintainer for 8250.c, so not sure who
should merge this. ?I can append it to the end of my next pull request
for the iop queue...?

Thanks,
Dan

[1]: http://git.kernel.org/?p=linux/kernel/git/djbw/xscaleiop.git;a=commitdiff;h=a7d124f5

?drivers/serial/8250.c | ? 36 +++++++++++++++++++++++++++++++++---
?1 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index b1ae774..c905860 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -547,6 +547,36 @@ serial_out_sync(struct uart_8250_port *up, int
offset, int value)
? ? ? ?(up->port.serial_in(&(up)->port, (offset)))
?#define serial_out(up, offset, value) ?\
? ? ? ?(up->port.serial_out(&(up)->port, (offset), (value)))
+
+#ifndef CONFIG_ARCH_IOP13XX
+#define iir_int_status(up) serial_in((up), UART_IIR)
+#else
+/* A silicon issue on IOP13XX causes IIR reads to return UART_IIR_NO_INT
+ * even if an interrupt is pending. Use the system interrupt pending
+ * register to check for servicing as a workaround.
+ */
+#include <mach/irqs.h>
+static unsigned int iir_int_status(struct uart_8250_port *up)
+{
+ ? ? ? unsigned long membase = (unsigned long) up->port.membase;
+ ? ? ? unsigned long ipnd, iir;
+
+ ? ? ? ipnd = read_intpnd_1();
+ ? ? ? iir = UART_IIR_NO_INT;
+ ? ? ? if (membase == IOP13XX_UART0_VIRT) {
+ ? ? ? ? ? ? ? if (ipnd & (1 << (IRQ_IOP13XX_UART0 - 32)))
+ ? ? ? ? ? ? ? ? ? ? ? iir &= ~UART_IIR_NO_INT;
+ ? ? ? } else if (membase == IOP13XX_UART1_VIRT) {
+ ? ? ? ? ? ? ? if (ipnd & (1 << (IRQ_IOP13XX_UART1 - 32)))
+ ? ? ? ? ? ? ? ? ? ? ? iir &= ~UART_IIR_NO_INT;
+ ? ? ? } else
+ ? ? ? ? ? ? ? BUG();
+ ? ? ? /* clear the interupt via the LSR */
+ ? ? ? mem_serial_in(&up->port, UART_LSR);
+ ? ? ? return iir;
+}
+#endif
+
?/*
?* We used to support using pause I/O for certain machines. ?We
?* haven't supported this for a while, but just in case it's badly
@@ -1572,7 +1602,7 @@ static irqreturn_t serial8250_interrupt(int irq,
void *dev_id)

? ? ? ? ? ? ? ?up = list_entry(l, struct uart_8250_port, list);

- ? ? ? ? ? ? ? iir = serial_in(up, UART_IIR);
+ ? ? ? ? ? ? ? iir = iir_int_status(up);
? ? ? ? ? ? ? ?if (!(iir & UART_IIR_NO_INT)) {
? ? ? ? ? ? ? ? ? ? ? ?serial8250_handle_port(up);

@@ -1732,7 +1762,7 @@ static void serial8250_timeout(unsigned long data)
? ? ? ?struct uart_8250_port *up = (struct uart_8250_port *)data;
? ? ? ?unsigned int iir;

- ? ? ? iir = serial_in(up, UART_IIR);
+ ? ? ? iir = iir_int_status(up);
? ? ? ?if (!(iir & UART_IIR_NO_INT))
? ? ? ? ? ? ? ?serial8250_handle_port(up);
? ? ? ?mod_timer(&up->timer, jiffies + poll_timeout(up->port.timeout));
@@ -1753,7 +1783,7 @@ static void serial8250_backup_timeout(unsigned long data)
? ? ? ? ? ? ? ?serial_out(up, UART_IER, 0);
? ? ? ?}

- ? ? ? iir = serial_in(up, UART_IIR);
+ ? ? ? iir = iir_int_status(up);

? ? ? ?/*
? ? ? ? * This should be a safe test for anyone who doesn't trust the
