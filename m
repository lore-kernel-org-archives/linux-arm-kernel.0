From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed,  6 Feb 2013 19:47:14 +0800
Subject: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
Message-ID: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If uart driver is probed defer, console_setup will be called later
after __init && __initdata sections destroyed. And amba_console isn't
defined in __init or __initdata section. So we needn't define
pl011_console_setup() && pl011_console_get_options() in __init section.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3ea5408..d43d530 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1810,7 +1810,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	clk_disable(uap->clk);
 }
 
-static void __init
+static void
 pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 			     int *parity, int *bits)
 {
@@ -1845,7 +1845,7 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 	}
 }
 
-static int __init pl011_console_setup(struct console *co, char *options)
+static int pl011_console_setup(struct console *co, char *options)
 {
 	struct uart_amba_port *uap;
 	int baud = 38400;
-- 
1.7.10.4
