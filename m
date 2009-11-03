From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 2 Nov 2009 23:31:53 -0400
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <1257155873.5642.14.camel@utx.utx.cz>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz>
	<20091101220341.GA16698@elf.ucw.cz>
	<771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
	<1257155873.5642.14.camel@utx.utx.cz>
Message-ID: <771cded00911021931x41cfa51bh2959d3748db5ac0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2009 at 5:57 AM, Stanislav Brabec <utx@penguin.cz> wrote:
> Haojian Zhuang wrote:
>
>> Commit b5b82df6, from May 2007, breaks no_console_suspend on the OLPC
>> XO laptop. Basically what happens is that upon returning from resume,
>> serial8250_resume_port() will reconfigure the port for high speed
>> mode and all console output will be garbled, making debug of the
>> resume path painful. This patch modifies uart_resume_port() to
>> reset the port to the state it was in before we suspended.
>
> See my patch waiting for approval in LKML thread
> "serial-core: resume serial hardware with no_console_suspend".
>
> It attempts to fix it, but I was not yet able to test it due to spitz
> resume breakage.
>

Hi Stanislav,

At first, your patch can't be applied into my latest codebase. I have
to update the patch. But the console resume is still blocked after
applied your patch. It works only after I merge some old code back. My
modified patch is in below.

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 1689bda..73f41cc 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2005,12 +2005,6 @@ int uart_suspend_port(struct uart_driver *drv,
struct uart_port *uport)

 	mutex_lock(&port->mutex);

-	if (!console_suspend_enabled && uart_console(uport)) {
-		/* we're going to avoid suspending serial console */
-		mutex_unlock(&port->mutex);
-		return 0;
-	}
-
 	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
 	if (device_may_wakeup(tty_dev)) {
 		enable_irq_wake(uport->irq);
@@ -2018,20 +2012,22 @@ int uart_suspend_port(struct uart_driver *drv,
struct uart_port *uport)
 		mutex_unlock(&port->mutex);
 		return 0;
 	}
-	uport->suspended = 1;
+	if (console_suspend_enabled || !uart_console(uport))
+		uport->suspended = 1;

 	if (port->flags & ASYNC_INITIALIZED) {
 		const struct uart_ops *ops = uport->ops;
 		int tries;

-		set_bit(ASYNCB_SUSPENDED, &port->flags);
-		clear_bit(ASYNCB_INITIALIZED, &port->flags);
-
-		spin_lock_irq(&uport->lock);
-		ops->stop_tx(uport);
-		ops->set_mctrl(uport, 0);
-		ops->stop_rx(uport);
-		spin_unlock_irq(&uport->lock);
+		if (console_suspend_enabled || !uart_console(uport)) {
+			set_bit(ASYNCB_SUSPENDED, &port->flags);
+			clear_bit(ASYNCB_INITIALIZED, &port->flags);
+			spin_lock_irq(&uport->lock);
+			ops->stop_tx(uport);
+			ops->set_mctrl(uport, 0);
+			ops->stop_rx(uport);
+			spin_unlock_irq(&uport->lock);
+		}

 		/*
 		 * Wait for the transmitter to empty.
@@ -2046,16 +2042,18 @@ int uart_suspend_port(struct uart_driver *drv,
struct uart_port *uport)
 			       drv->dev_name,
 			       drv->tty_driver->name_base + uport->line);

-		ops->shutdown(uport);
+		if (console_suspend_enabled || !uart_console(uport))
+			ops->shutdown(uport);
 	}

 	/*
 	 * Disable the console device before suspending.
 	 */
-	if (uart_console(uport))
+	if (console_suspend_enabled && uart_console(uport))
 		console_stop(uport->cons);

-	uart_change_pm(state, 3);
+	if (console_suspend_enabled || !uart_console(uport))
+		uart_change_pm(state, 3);

 	mutex_unlock(&port->mutex);

@@ -2072,8 +2070,18 @@ int uart_resume_port(struct uart_driver *drv,
struct uart_port *uport)

 	mutex_lock(&port->mutex);

-	if (!console_suspend_enabled && uart_console(uport)) {
-		/* no need to resume serial console, it wasn't suspended */
+	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
+	if (!uport->suspended && device_may_wakeup(tty_dev)) {
+		disable_irq_wake(uport->irq);
+		mutex_unlock(&port->mutex);
+		return 0;
+	}
+	uport->suspended = 0;
+
+	/*
+	 * Re-enable the console device after suspending.
+	 */
+	if (uart_console(uport)) {
 		/*
 		 * First try to use the console cflag setting.
 		 */
@@ -2090,23 +2098,6 @@ int uart_resume_port(struct uart_driver *drv,
struct uart_port *uport)
 			termios.c_ispeed = termios.c_ospeed =
 				tty_termios_baud_rate(&termios);
 		}
-		uport->ops->set_termios(uport, &termios, NULL);
-		mutex_unlock(&port->mutex);
-		return 0;
-	}
-
-	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
-	if (!uport->suspended && device_may_wakeup(tty_dev)) {
-		disable_irq_wake(uport->irq);
-		mutex_unlock(&port->mutex);
-		return 0;
-	}
-	uport->suspended = 0;
-
-	/*
-	 * Re-enable the console device after suspending.
-	 */
-	if (uart_console(uport)) {
 		uart_change_pm(state, 0);
 		uport->ops->set_termios(uport, &termios, NULL);
 		console_start(uport->cons);
@@ -2120,21 +2111,23 @@ int uart_resume_port(struct uart_driver *drv,
struct uart_port *uport)
 		spin_lock_irq(&uport->lock);
 		ops->set_mctrl(uport, 0);
 		spin_unlock_irq(&uport->lock);
-		ret = ops->startup(uport);
-		if (ret == 0) {
-			uart_change_speed(state, NULL);
-			spin_lock_irq(&uport->lock);
-			ops->set_mctrl(uport, uport->mctrl);
-			ops->start_tx(uport);
-			spin_unlock_irq(&uport->lock);
-			set_bit(ASYNCB_INITIALIZED, &port->flags);
-		} else {
-			/*
-			 * Failed to resume - maybe hardware went away?
-			 * Clear the "initialized" flag so we won't try
-			 * to call the low level drivers shutdown method.
-			 */
-			uart_shutdown(state);
+		if (console_suspend_enabled || !uart_console(uport)) {
+			ret = ops->startup(uport);
+			if (ret == 0) {
+				uart_change_speed(state, NULL);
+				spin_lock_irq(&uport->lock);
+				ops->set_mctrl(uport, uport->mctrl);
+				ops->start_tx(uport);
+				spin_unlock_irq(&uport->lock);
+				set_bit(ASYNCB_INITIALIZED, &port->flags);
+			} else {
+				/*
+				 * Failed to resume - maybe hardware went away?
+				 * Clear the "initialized" flag so we won't try
+				 * to call the low level drivers shutdown method.
+				 */
+				uart_shutdown(state);
+			}
 		}

 		clear_bit(ASYNCB_SUSPENDED, &port->flags);
