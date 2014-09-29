From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 29 Sep 2014 20:06:38 +0200
Subject: [PATCH 02/13] tty: serial: 8250: make serial8250_console_setup() non
 _init
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1412014009-13315-3-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if I boot with console=ttyS0 and the omap driver is module I end up with

| console [ttyS0] disabled
| omap8250 44e09000.serial: ttyS0 at MMIO 0x44e09000 (irq = 88, base_baud = 3000000) is a 8250
| Unable to handle kernel paging request at virtual address c07a9de0
| Modules linked in: 8250_omap(+)
| CPU: 0 PID: 908 Comm: modprobe Not tainted 3.17.0-rc5+ #1593
| PC is at serial8250_console_setup+0x0/0xc8
| LR is at register_console+0x13c/0x3a4
| [<c0078788>] (register_console) from [<c02d0340>] (uart_add_one_port+0x3cc/0x420)
| [<c02d0340>] (uart_add_one_port) from [<c02d38a4>] (serial8250_register_8250_port+0x298/0x39c)
| [<c02d38a4>] (serial8250_register_8250_port) from [<bf006274>] (omap8250_probe+0x218/0x3dc [8250_omap])
| [<bf006274>] (omap8250_probe [8250_omap]) from [<c02e3424>] (platform_drv_probe+0x2c/0x5c)
| [<c02e3424>] (platform_drv_probe) from [<c02e1eac>] (driver_probe_device+0x104/0x228)
?
| [<c009fa48>] (SyS_init_module) from [<c000e6e0>] (ret_fast_syscall+0x0/0x30)
| Code: 7823603b f8314620 051b3013 491ed416 (44792204)

because serial8250_console_setup() is already gone.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a1904628a2a1..159b72471622 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3237,7 +3237,7 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 	serial8250_rpm_put(up);
 }
 
-static int __init serial8250_console_setup(struct console *co, char *options)
+static int serial8250_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
-- 
2.1.0
