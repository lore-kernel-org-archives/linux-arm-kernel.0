From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 22:24:50 +0200
Subject: [PATCH] genirq: export handle_bad_irq
Message-ID: <5847725.4IBopItaOr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cleanup of the omap gpio driver introduced a use of the
handle_bad_irq() function in a device driver that can be
a loadable module.

This broke the ARM allmodconfig build:

ERROR: "handle_bad_irq" [drivers/gpio/gpio-omap.ko] undefined!

This patch exports the handle_bad_irq symbol in order to
allow the use in modules.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 450fa54cfd66 ("gpio: omap: convert to use generic irq handler")

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index ea7b5fd99ba5..142bbf3b607f 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -35,6 +35,7 @@ void handle_bad_irq(struct irq_desc *desc)
 	kstat_incr_irqs_this_cpu(desc);
 	ack_bad_irq(irq);
 }
+EXPORT_SYMBOL_GPL(handle_bad_irq);
 
 /*
  * Special, empty irq handler:
