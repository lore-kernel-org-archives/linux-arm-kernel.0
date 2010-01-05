From: mkl0301@hotmail.com (mkl lin)
Date: Tue, 5 Jan 2010 16:02:22 +0000
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <20100101205850.GI16220@n2100.arm.linux.org.uk>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>,
	<20100101205850.GI16220@n2100.arm.linux.org.uk>
Message-ID: <SNT109-W597ECAF29FF35A1CFC84D0A7730@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> These two sounds like a problem with interrupts - userspace console IO
> is interrupt driven, whereas kernel console IO is not.

Thanks for Russell's
advice, after some tracing, I found that my IER (Interrupt Enable
Register) of the serial port is 0 under case 1!!

Case 2 is
actually the same with case 1. Case 1 would come first, if I don't keep
input things and let it finish its slow printing, it would then become
case 2.

UART_BUG_THRE are detected and enabled on my platform, causing serial8250_backup_timeout to be used.

There
are many places that do ( get IER, clear IER, restore IER ), like
serial8250_console_write called by printk, and
serial8250_backup_timeout. serial8250_backup_timeout is not protected
by spinlock, causing the race condition, and result in wrong IER value.

Following patch fix this issue. Case 3 and Case 4 are still often seen, but not case 1 and case 2.

Best Regards,
Mac Lin
diff --git a/kernels/linux-2.6.31.1-X/drivers/serial/8250.c b/kernels/linux-2.6.31.1-X/drivers/serial/8250.c
index 288a0e4..55602c3 100644
--- a/kernels/linux-2.6.31.1-cavm1/drivers/serial/8250.c
+++ b/kernels/linux-2.6.31.1-cavm1/drivers/serial/8250.c
@@ -1752,6 +1758,8 @@ static void serial8250_backup_timeout(unsigned long data)
  unsigned int iir, ier = 0, lsr;
  unsigned long flags;
 
+
+ spin_lock_irqsave(&up->port.lock, flags);
  /*
   * Must disable interrupts or else we risk racing with the interrupt
   * based handler.
@@ -1769,10 +1777,8 @@ static void serial8250_backup_timeout(unsigned long data)
   * the "Diva" UART used on the management processor on many HP
   * ia64 and parisc boxes.
   */
- spin_lock_irqsave(&up->port.lock, flags);
  lsr = serial_in(up, UART_LSR);
  up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
- spin_unlock_irqrestore(&up->port.lock, flags);
  if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
      (!uart_circ_empty(&up->port.info->xmit) || up->port.x_char) &&
      (lsr & UART_LSR_THRE)) {
@@ -1780,12 +1786,14 @@ static void serial8250_backup_timeout(unsigned long data)
   iir |= UART_IIR_THRI;
  }
 
- if (!(iir & UART_IIR_NO_INT))
-  serial8250_handle_port(up);
-
  if (is_real_interrupt(up->port.irq))
   serial_out(up, UART_IER, ier);
 
+ spin_unlock_irqrestore(&up->port.lock, flags);
+
+ if (!(iir & UART_IIR_NO_INT))
+  serial8250_handle_port(up);
+
  /* Standard timer interval plus 0.2s to keep the port running */
  mod_timer(&up->timer,
   jiffies + poll_timeout(up->port.timeout) + HZ / 5);
 		 	   		  
_________________________________________________________________
Windows Live Hotmail: Your friends can get your Facebook updates, right from Hotmail?.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_4:092009
