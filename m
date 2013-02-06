From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed,  6 Feb 2013 19:47:15 +0800
Subject: [PATCH 2/2] tty: serial: use module_init on pl011_init
In-Reply-To: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1360151235-11980-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If amba serial driver is probed defer, amba serial driver may be
probed after init process. So the error log shows in below.

[    0.389403] Warning: unable to open an initial console.
[    0.390107] Freeing init memory: 2328K

It results in serial console not enabled. So replace arch_initcall
by module_init on pl011_init(). The boot sequence is changed in below.

  pinctrl driver --> amba serial driver --> init process

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d43d530..8b7dacb 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2129,11 +2129,7 @@ static void __exit pl011_exit(void)
 	uart_unregister_driver(&amba_reg);
 }
 
-/*
- * While this can be a module, if builtin it's most likely the console
- * So let's leave module_exit but move module_init to an earlier place
- */
-arch_initcall(pl011_init);
+module_init(pl011_init);
 module_exit(pl011_exit);
 
 MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
-- 
1.7.10.4
