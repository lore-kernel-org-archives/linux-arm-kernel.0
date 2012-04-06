From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  6 Apr 2012 18:02:29 +0200
Subject: [PATCH RFC] ARM: at91: remove at91_register_uart_fns and headers
Message-ID: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No AT91/AVR32 boards currently use at91_register_uart_fns so let's remove it.

The only other mach in the kernel that has a *_register_uart_fns function
is SA1100 so the demand for this functionality is not great.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---
 arch/arm/include/asm/mach/serial_at91.h   |   33 -----------------------------
 arch/avr32/include/asm/mach/serial_at91.h |   33 -----------------------------
 drivers/tty/serial/atmel_serial.c         |   18 ----------------
 3 files changed, 84 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/serial_at91.h
 delete mode 100644 arch/avr32/include/asm/mach/serial_at91.h

diff --git a/arch/arm/include/asm/mach/serial_at91.h b/arch/arm/include/asm/mach/serial_at91.h
deleted file mode 100644
index ea6d063..0000000
--- a/arch/arm/include/asm/mach/serial_at91.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/include/asm/mach/serial_at91.h
- *
- *  Based on serial_sa1100.h  by Nicolas Pitre
- *
- *  Copyright (C) 2002 ATMEL Rousset
- *
- *  Low level machine dependent UART functions.
- */
-
-struct uart_port;
-
-/*
- * This is a temporary structure for registering these
- * functions; it is intended to be discarded after boot.
- */
-struct atmel_port_fns {
-	void	(*set_mctrl)(struct uart_port *, u_int);
-	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*enable_ms)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
-	int	(*open)(struct uart_port *);
-	void	(*close)(struct uart_port *);
-};
-
-#if defined(CONFIG_SERIAL_ATMEL)
-void atmel_register_uart_fns(struct atmel_port_fns *fns);
-#else
-#define atmel_register_uart_fns(fns) do { } while (0)
-#endif
-
-
diff --git a/arch/avr32/include/asm/mach/serial_at91.h b/arch/avr32/include/asm/mach/serial_at91.h
deleted file mode 100644
index 55b317a..0000000
--- a/arch/avr32/include/asm/mach/serial_at91.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  linux/include/asm-arm/mach/serial_at91.h
- *
- *  Based on serial_sa1100.h  by Nicolas Pitre
- *
- *  Copyright (C) 2002 ATMEL Rousset
- *
- *  Low level machine dependent UART functions.
- */
-
-struct uart_port;
-
-/*
- * This is a temporary structure for registering these
- * functions; it is intended to be discarded after boot.
- */
-struct atmel_port_fns {
-	void	(*set_mctrl)(struct uart_port *, u_int);
-	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*enable_ms)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
-	int	(*open)(struct uart_port *);
-	void	(*close)(struct uart_port *);
-};
-
-#if defined(CONFIG_SERIAL_ATMEL)
-void atmel_register_uart_fns(struct atmel_port_fns *fns);
-#else
-#define atmel_register_uart_fns(fns) do { } while (0)
-#endif
-
-
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index f9a6be7..513bc3d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -43,7 +43,6 @@
 #include <asm/io.h>
 #include <asm/ioctls.h>
 
-#include <asm/mach/serial_at91.h>
 #include <mach/board.h>
 
 #ifdef CONFIG_ARM
@@ -1509,23 +1508,6 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 	}
 }
 
-/*
- * Register board-specific modem-control line handlers.
- */
-void __init atmel_register_uart_fns(struct atmel_port_fns *fns)
-{
-	if (fns->enable_ms)
-		atmel_pops.enable_ms = fns->enable_ms;
-	if (fns->get_mctrl)
-		atmel_pops.get_mctrl = fns->get_mctrl;
-	if (fns->set_mctrl)
-		atmel_pops.set_mctrl = fns->set_mctrl;
-	atmel_open_hook		= fns->open;
-	atmel_close_hook	= fns->close;
-	atmel_pops.pm		= fns->pm;
-	atmel_pops.set_wake	= fns->set_wake;
-}
-
 struct platform_device *atmel_default_console_device;	/* the serial console device */
 
 #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
-- 
1.7.9.6
