From: Michael.McTernan.2001@cs.bris.ac.uk (Michael McTernan)
Date: Sun, 20 May 2012 12:04:27 +0100
Subject: ARM: iMX: lockup with irqs disabled in drivers/tty/imx.c
Message-ID: <4FB8CFBB.2020004@cs.bris.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I've found a lockup (interrupts disabled, infinite loop) in 
drivers/tty/imx.c.  This is on i.MX53 (Karo module), using the Karo BSP, 
but having checked the arm-soc git tree, I think the bug is here too. 
The Linaro tree(s) look the same.

I see the problem when the UART is setup to not have rtscts, so 
port->have_rtscts = 0 in the driver.  Additionally there is nothing 
hanging on the serial port (in my case the peripheral isn't yet powered 
up) so the rx line is low.

I can then trigger the lockup by simply booting the unit and issuing 
"echo > /dev/ttymxc1".  The same can be done on the other ports too. 
Once locked, magic sys-req appears not to work, pinging the target is 
dead etc...

The sequence of events in the kernel goes something like this:

1) imx_startup()
2) imx_int()
       \-> imx_rxint()
             |-> URXD0 returns 0xd800
             \-> tty_insert_flip_char(tty, 0, TTY_BREAK)
...
3) imx_start_tx()
       \-> imx_transmit_buffer()
              Writes '^' '@'
4) imx_set_termios()
       \-> hangs when waiting for USR2_TXDC

The problem is that UCR2_IRTS isn't yet set (that comes later in 
imx_set_termios()), so the transmitter is waiting for the pin to be 
asserted before it can serialise out from its FIFO and set the USR2_TXDC 
bit.  Since CTS/RTS will never come on this port, we end up spinning in 
the following bit of code in imx_set_termios():948, having earlier 
called spin_lock_irqsave():

	while ( !(readl(sport->port.membase + USR2) & USR2_TXDC))
		barrier();

The tx was a surprise to me; it looks like the receiver sees the low rx 
pin as a break which then, I think, causes a local echo sending back 
'^@', as per the following stack:

(imx_start_tx+0x60/0x12c)       from (__uart_start+0x44/0x48)
(__uart_start+0x44/0x48)        from (uart_start+0x20/0x4c)
(uart_start+0x20/0x4c)          from (process_echoes+0x25c/0x260)
(process_echoes+0x25c/0x260)    from (n_tty_receive_buf+0xc90/0xf04)
(n_tty_receive_buf+0xc90/0xf04) from (flush_to_ldisc+0xfc/0x1b0)
(flush_to_ldisc+0xfc/0x1b0)     from (process_one_work+0x1fc/0x330)
(process_one_work+0x1fc/0x330)  from (worker_thread+0x1d0/0x2f8)
(worker_thread+0x1d0/0x2f8)     from (kthread+0x7c/0x84)
(kthread+0x7c/0x84)             from (kernel_thread_exit+0x0/0x8)

Had imx_set_termios() been called prior to the imx_transmit_buffer(), 
UCR2_IRTS would have been set and disaster avoided.

So one workaround is to set UCR2_IRTS in imx_startup() as per the patch 
on the end of this email.  This still wouldn't cater for other cases 
where RTS/CTS is in use but not asserted by a peripheral (or the pin 
mux/pad isn't correctly setup/routed), or that termios() is called while 
data is blocked waiting for CTS/RTS.  The drain loop should probably 
implement a timeout and WARN(), but I'm not sure if it should also use a 
completion and interrupt to be correct - other serial drivers don't 
appear to do this though?

Anyway, the lockup is nasty, so hopefully can be triaged?

Regards,

Mike

Signed-off-by: Michael McTernan <Michael.McTernan.2001@cs.bris.ac.uk>
diff -Naurp orig/imx.c fixed/imx.c
--- orig/imx.c  2012-05-20 10:37:20.320041462 +0100
+++ fixed/imx.c 2012-05-20 11:18:28.512657377 +0100
@@ -741,6 +741,9 @@ static int imx_startup(struct uart_port
         writel(temp, sport->port.membase + UCR1);

         temp = readl(sport->port.membase + UCR2);
+       if (!sport->have_rtscts) {
+                       temp |= UCR2_IRTS;
+       }
         temp |= (UCR2_RXEN | UCR2_TXEN);
         writel(temp, sport->port.membase + UCR2);
